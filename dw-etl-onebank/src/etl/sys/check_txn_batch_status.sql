---------------------------------------------------------------
--
-- 函数名称：check_txn_batch_status
-- 函数描述：检查业务日期txn跑批结果
--     参数：etl_date，整型
--   返回值：是否完成标识
--   创建人：**
--
--------------------------------------------------------------- 
CREATE OR REPLACE FUNCTION "check_txn_batch_status"(etl_date int4)
  RETURNS int4 AS $BODY$
	DECLARE
	  res_status int;
    sql_stmt varchar;
  BEGIN
	  -- 检查表
	  EXECUTE 'SELECT COUNT(1) FROM ods_anytxn_batch_quartz_sign WHERE business_date = date_add_by_day(' || etl_date || ', -1)::TEXT AND status = 1 AND quartz_id = 2' INTO res_status;
	
    RETURN res_status;
  END;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;