CREATE OR REPLACE FUNCTION "etl_create_daily_snap_table"("ods_table" varchar, "biz_date" int4, "debug" int4=0)
    RETURNS "pg_catalog"."void" AS $BODY$
DECLARE
    job_status int4;
    start_time timestamp;
    end_time timestamp;
    execute_time int8;
    affected_rows int8;
    sqlStmt VARCHAR;
BEGIN
    -- 检查dw_batch_job_log表当天的每日快照数据是否已经成功生成(step='DAILY_SNAP' AND result = 'SUCCESS')
    EXECUTE 'SELECT COUNT(1) FROM sys_batch_job_log WHERE biz_date = '|| biz_date || 'AND table_name = '''||ods_table||''' AND step = ''DAILY_SNAP'' AND result = ''SUCCESS''' INTO job_status; 
    PERFORM log_info(format('%1$s', job_status), debug);

        -- 如果sys_batch_job_log当天的每日快照数据没有成功生成(未开始生成或者之前有失败记录)，则进行数据跑入
        IF (job_status = 0) THEN 
            start_time = NOW();

            --====第一步：创建当前快照临时表用于缓存数据
            EXECUTE 'DROP TABLE IF EXISTS ' || ods_table || '_snap';
            sqlStmt = 'CREATE TABLE ' || ods_table || '_snap AS SELECT ods.* FROM ' || ods_table || ' ods ';
            PERFORM log_info(format('%1$s', sqlStmt), debug);
            EXECUTE  sqlStmt;

            --====第二步：备份当日快照数据，存储到每日快照表,（我这里在ods层加了一张表，用来保存30天每日快照，只保留30天，防止拉链做错了，回溯不行）
            sqlStmt = 'INSERT INTO ' || ods_table || '_daily_snap SELECT ' || biz_date || '::INT AS biz_date, * FROM ' || ods_table || '_snap';
            PERFORM log_info(format('%1$s', sqlStmt), debug);
            EXECUTE  sqlStmt;

            -- 获取影响行数
            GET DIAGNOSTICS affected_rows = ROW_COUNT;  

            end_time = NOW();
            select extract(epoch FROM (end_time - start_time)) INTO execute_time;

            -- 每日快照生成完成，记录日志
            INSERT INTO sys_batch_job_log VALUES
                    (biz_date,start_time,end_time,execute_time,ods_table,'ODS','DAILY_SNAP','SUCCESS',affected_rows,affected_rows,0,null);
        END IF;

        return;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPTION '[etl_create_daily_snap_table][%]  %', ods_table, SQLERRM;
                return;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100
;

-- SELECT etl_create_daily_snap_table('ods_anytxn_bm_acct_loan', 20200201, 1);
-- 
-- SELECT * FROM sys_batch_job_log WHERE biz_date = 20200207;
-- 
-- 
-- 
-- 
--  CREATE OR REPLACE FUNCTION "public"."etl_create_ods_daily_snap"(etl_date int4)
--   RETURNS "pg_catalog"."varchar" AS $BODY$
--   BEGIN
--     PERFORM etl_create_daily_snap_table('ods_anytxn_bm_acct_loan', 'txa_number', etl_date);
--      
--      RETURN 'ETLOK';
--      EXCEPTION
--     WHEN others THEN    
--     RETURN 'ETLERROR: ' || SQLERRM; 
--      
--   END;
--   $BODY$
--   LANGUAGE plpgsql VOLATILE
--   COST 100;
    
    
--  SELECT etl_create_ods_daily_snap(20200204);
--  
--  
--  SELECT biz_date, COUNT(*) FROM ods_anytxn_bm_acct_loan_daily_snap GROUP BY biz_date;
    
-- SELECT * FROM sys_batch_job_log;
-- SELECT * FROM dw_batch_job_log ORDER BY batch_start_time DESC;

-- 存储过程的几个问题：
-- 1. 讨论下到底返回值是TRUE，FALSE，还是是错误信息，或者状态码？现在是字符串，得考虑是BOOL，还是状态码。这些状态码如何被角度平台捕捉。
-- 2. 日终跑批检查后面不用放ELSE
-- 3.SELECT COUNT(1) 写法有风险，还是用状态来判断比较好。如果当天没有数据，就是会为0，但是实际任务完成了。
-- 4. SUCCESS -> SUCCESS