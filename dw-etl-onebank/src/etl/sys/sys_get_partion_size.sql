---------------------------------------------------------------
--
-- sys_get_partion_size
-- 函数描述：获取所有分取表尺寸
--  返回值：尺寸（数值型）
--  创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
CREATE OR REPLACE FUNCTION "sys_get_partion_size"()
  RETURNS "pg_catalog"."int8" AS $BODY$
Declare
  tbl_raw_size BIGINT;
BEGIN
  EXECUTE 'SELECT SUM(pg_relation_size(psut.relid)) as raw_data_size
             FROM pg_statio_user_tables  psut
       INNER JOIN pg_inherits pi ON psut.relid = pi.inhrelid
            WHERE pi.inhparent = ' || tbl_pid  
		INTO tbl_raw_size;
				
  return tbl_raw_size;
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100