
---------------------------------------------------------------
--
-- 函数名称：gb_dsum_sfunc
--         去重累计计算
-- 函数描述：gb_dsum聚合函数的状态转换函数
--     参数：in_s_value 中间状态
--        ：in_key   去重键值
--        ：in_num   数值
--   返回值：二维数组，【【日期，值】】
--   创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
CREATE OR REPLACE FUNCTION "gb_dsum_sfunc"("in_s_value" _numeric, "in_key" numeric, "in_num" numeric)
    RETURNS "pg_catalog"."_numeric" AS $BODY$
    DECLARE
        i INT;
    BEGIN
        IF in_s_value IS NULL OR in_key IS NULL THEN
            RETURN ARRAY[[in_key, in_num]];
        END IF;
     
          
        FOR i IN array_lower(in_s_value, 1) .. array_upper(in_s_value, 1)
        LOOP
          IF in_s_value[i][1] = in_key THEN
              RETURN in_s_value;
          END IF;
        END LOOP;

        RETURN in_s_value || ARRAY[in_key, in_num];
    END;
    $BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
	
---------------------------------------------------------------
--
-- 函数名称：gb_dsum_sfunc
--         去重累计计算 
-- 函数描述：gb_dsum聚合函数的状态转换函数
--    参数：in_s_value 中间状态
--   返回值：数值
--   创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
	CREATE OR REPLACE FUNCTION "gb_dsum_ffunc"("s_value" _numeric)
  RETURNS "pg_catalog"."numeric" AS $BODY$
  DECLARE
     i INT;
     tmp_value numeric; 
   BEGIN
     tmp_value = 0;
     FOR i IN array_lower(s_value, 1) .. array_upper(s_value, 1)
     LOOP
       tmp_value = tmp_value + s_value[i][2];
     END LOOP;
       
     RETURN tmp_value;
   END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
	
---------------------------------------------------------------
--
-- 函数名称：gb_dsum
--         去重累计计算  
-- 函数描述：聚合函数
--     参数：in_key   去重键值
--        ：in_num   数值
--   返回值：数值型
--   创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
DROP AGGREGATE IF EXISTS dsum(numeric, numeric);
CREATE AGGREGATE dsum(numeric, numeric) (
    SFUNC = gb_dsum_sfunc,
    STYPE = numeric[],
    FINALFUNC = gb_dsum_ffunc);