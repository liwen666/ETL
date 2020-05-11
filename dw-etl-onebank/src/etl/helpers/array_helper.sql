---------------------------------------------------------------
--
-- array_sort
-- 函数描述：数值类型数组排序
--  返回值：数字数组
--  创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
CREATE OR REPLACE FUNCTION "array_sort"("array_to_sort" _numeric)
  RETURNS "pg_catalog"."_numeric" AS $BODY$
  DECLARE 
      tmp int;
      result _numeric;
  BEGIN
      FOR tmp in select unnest(array_to_sort) as a order by a asc
      LOOP
        result = array_append(result,tmp::numeric);
      end LOOP;

      RETURN result;
  END;
   $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;