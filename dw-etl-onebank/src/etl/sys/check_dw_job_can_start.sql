CREATE OR REPLACE FUNCTION "check_dw_job_can_start"(etl_date int4, delay_time int4)
  RETURNS int4 AS $BODY$
    DECLARE
      res_status int;
  BEGIN
      -- 检查表
      EXECUTE 'SELECT CASE WHEN DATEDIFF(''minute'', update_time, NOW()) >= ' || delay_time || ' THEN 1 ELSE 0 END
                 FROM ods_anytxn_batch_quartz_sign 
                WHERE business_date = date_add_by_day(' || etl_date || ', -1)::TEXT 
                  AND status = 1 
                  AND quartz_id = 2' INTO res_status;
    
    RETURN res_status;
  END;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;