CREATE OR REPLACE FUNCTION "public"."etl_create_zip_table"("ods_table" varchar, "pkey" varchar, "biz_date" int4, "debug" int4=0)
    RETURNS "pg_catalog"."void" AS $BODY$
DECLARE
    snap_job_status int4;
    zip_job_status int4;
    start_time timestamp;
    end_time timestamp;
    execute_time int8;
    affected_rows int8;
    new_rows int8;
    updated_rows int8;
    sqlStmt VARCHAR;
    snap_fields VARCHAR;
    his_fields VARCHAR;
BEGIN
    -- 检查sys_batch_job_log表当天的每日快照数据是否已经成功生成(step='DAILY_SNAP' AND result = 'SUCCESS')
    EXECUTE 'SELECT COUNT(1) FROM sys_batch_job_log WHERE biz_date = '|| biz_date || 'AND table_name = '''|| ods_table ||''' AND step = ''DAILY_SNAP'' AND result = ''SUCCESS''' INTO snap_job_status; 
    IF snap_job_status = 0 THEN
        RAISE EXCEPTION '日终快照任务未完成';
    END IF;

    -- 检查sys_batch_job_log表当天的拉链数据是否已经成功生成(step='HIS' AND result = 'SUCCESS')
    EXECUTE 'SELECT COUNT(1) FROM sys_batch_job_log WHERE biz_date = '|| biz_date || ' AND table_name = '''|| ods_table ||''' AND result = ''SUCCESS'' AND step = ''HIS''' INTO zip_job_status; 
    PERFORM log_info(format('zip_job_status: %1$s; snap_job_status: %2$s', zip_job_status, snap_job_status), debug);

    -- 2.1.2如果拉链表表里面。没有当天拉链数据，进行数据跑入
    IF (zip_job_status = 1 AND snap_job_status = 1) THEN
        RETURN;
    END IF;

    -- 创建拉链表
    IF (zip_job_status = 0 AND snap_job_status = 1) THEN
        start_time = NOW();
        sqlStmt = 'SELECT STRING_AGG(''snap.'' || column_name || '''', '','') AS snap_fields, STRING_AGG(''his.'' || column_name || '''', '','') AS his_fields
                     FROM information_schema.columns
                    WHERE table_name = ''' || ods_table || '''';
        PERFORM log_info(sqlStmt, debug);
        EXECUTE sqlStmt into snap_fields, his_fields;
        -- PERFORM log_info(format('snap_fields: %1$s; snap_fields: %2$s', snap_fields, his_fields), debug);

        --删除临时增量表
        sqlStmt = 'DROP TABLE IF EXISTS tmp_incr_' || ods_table;
        PERFORM log_info(sqlStmt, debug);
        EXECUTE sqlStmt;
                
        --创建临时增量数据表
        sqlStmt = 'CREATE TABLE tmp_incr_' || ods_table || ' (LIKE ' || ods_table || '_his)';
        PERFORM log_info(sqlStmt, debug);
        EXECUTE sqlStmt;
     
        --对比整行MD5, 创建增量表(有变更的记录)
        sqlStmt = 'INSERT INTO tmp_incr_' || ods_table || ' 
                        SELECT ' || biz_date || ' AS his_start_time,
                                         99991231 AS his_end_time,
                                         snap.*,
                                 ' || to_int_date(now()::DATE) || ' AS etl_date
                                FROM ' || ods_table || '_snap snap
                INNER JOIN ' || ods_table || '_his his ON snap.' || pkey || '=his.' || pkey || ' AND his.his_end_time = 99991231
                     WHERE MD5(ROW(' || snap_fields || '):: TEXT) <> MD5(ROW(' || his_fields || '):: TEXT)';
        PERFORM log_info(sqlStmt, debug);
        EXECUTE sqlStmt;

        GET DIAGNOSTICS updated_rows = ROW_COUNT;  
                
        --新增的记录
        sqlStmt = 'INSERT INTO tmp_incr_' || ods_table || '  
                     SELECT ' || biz_date || ' AS his_start_time,
                                    99991231 AS his_end_time,
                                    *,
                                    ' || to_int_date(now()::DATE) || ' AS etl_date
                         FROM ' || ods_table || '_snap snap
                     WHERE ' || pkey || ' NOT IN (SELECT ' || pkey || ' FROM ' || ods_table || '_his WHERE his_end_time = 99991231)';
        PERFORM log_info(sqlStmt, debug);
        EXECUTE sqlStmt;                

        GET DIAGNOSTICS new_rows = ROW_COUNT;  

        --已变更的旧数据做关链
        --给拉链表做关链
        EXECUTE 'UPDATE ' || ods_table || '_his 
                     SET his_end_time = ' || to_int_date((to_date(biz_date::text, 'YYYYMMDD') + interval '-1 day')::DATE) || ' 
                 WHERE his_end_time = 99991231 AND ' || pkey || ' IN (SELECT ' || pkey || ' FROM tmp_incr_' || ods_table || ')';

        GET DIAGNOSTICS affected_rows = ROW_COUNT;  


        --把新增数据和变更的99991231数据 插入拉链表
        EXECUTE 'INSERT INTO ' || ods_table || '_his SELECT * FROM tmp_incr_' || ods_table || '';

        affected_rows = new_rows + updated_rows + affected_rows;
        end_time = now();
        select extract(epoch FROM (end_time - start_time)) INTO execute_time;
        
        -- 每日拉链生成完成，记录日志
        INSERT INTO sys_batch_job_log VALUES(biz_date,start_time,end_time,execute_time,ods_table,'ODS','HIS','SUCCESS',affected_rows,new_rows,updated_rows,null);

        RETURN;
    END IF;
    
    EXCEPTION
        WHEN others THEN
            RAISE EXCEPTION '[etl_create_zip_table][%] %', ods_table, SQLERRM;
            RETURN;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100
;

-- SELECT etl_create_zip_table('ods_anytxn_bm_acct_loan', 'txa_number', 20200201, 1);