---------------------------------------------------------------
--
-- 函数名称：gb_last_value_sfunc
--         在分组计算中取对应日期最大时间的值  
-- 函数描述：gb_last_value聚合函数的状态转换函数
--     参数：in_s_value 中间状态
--        ：in_date   日期
--        ：in_num    数值
--        ：condition 过滤条件，为TRUE才计算，FALSE直接忽略
--   返回值：二维数组，【【日期，值】】
--   创建人：北京江融信科技有限公司
--
---------------------------------------------------------------   
CREATE OR REPLACE FUNCTION "gb_last_value_sfunc"("in_s_value" _numeric, "in_date" timestamp, "in_num" numeric, "condition" bool)
  RETURNS "pg_catalog"."_numeric" AS $BODY$
  DECLARE
     int_date int;
     s_value numeric[];
   BEGIN
       IF (condition IS NOT NULL) AND (condition = FALSE) THEN
           return in_s_value;
       END IF;

       int_date = cast(extract(epoch from in_date) as integer);
       
       IF in_s_value IS NULL OR (int_date > in_s_value[1]) THEN
           s_value[1] = int_date;
           s_value[2] = in_num;
       ELSE
           s_value[1] = in_s_value[1];
           s_value[2] = in_s_value[2];
       END IF;
       
       return s_value;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

---------------------------------------------------------------
--
-- 函数名称：gb_last_value_sfunc
--         在分组计算中取对应日期最大时间的值  
-- 函数描述：gb_last_value聚合函数的最终处理函数
--     参数：s_value 中间状态
--   返回值：数值型
--   创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
CREATE OR REPLACE FUNCTION "gb_last_value_ffunc"("s_value" _numeric)
    RETURNS "pg_catalog"."numeric" AS $BODY$
    BEGIN
        RETURN s_value[2];
    END;
    $BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
  
---------------------------------------------------------------
--
-- 函数名称：gb_last_value
--         在分组计算中取对应日期最大时间的值  
-- 函数描述：聚合函数
--     参数：in_date   日期
--        ：in_num    数值
--        ：condition 过滤条件，为TRUE才计算，FALSE直接忽略
--   返回值：数值型
--   创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
DROP AGGREGATE IF EXISTS gb_last_value(timestamp, numeric, bool);
CREATE AGGREGATE gb_last_value(timestamp, numeric, bool) (
   SFUNC = gb_last_value_sfunc,
   STYPE = numeric[],
   FINALFUNC = gb_last_value_ffunc);