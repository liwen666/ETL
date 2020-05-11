---------------------------------------------------------------
--
-- sys_create_dw_overview
-- 函数描述：生成数据集市元数据数据报告
--  返回值：void
--  创建人：北京江融信科技有限公司
--
---------------------------------------------------------------  
CREATE OR REPLACE FUNCTION "sys_create_dw_overview"()
  RETURNS "pg_catalog"."void" AS $BODY$
    DECLARE
        v_val INT;
        rec_tbl RECORD;
        tbl_cnt BIGINT;
        tbl_col_cnt INT;
        tbl_raw_size BIGINT;
        tbl_rb_raw_size TEXT;
        tbl_partition_cnt INT;
        his_start_time INT;
        his_end_time INT;
        mth_cnt INT;
        year_cnt INT;

        tbl_1m_raw_size BIGINT;
        tbl_1m_rb_size TEXT;

        last_day_cnt BIGINT;
        last_30day_cnt BIGINT;
        last_60day_cnt BIGINT;
        last_90day_cnt BIGINT;
    BEGIN

        -- 遍历数仓基础层、中间层和集市层所有表
        FOR rec_tbl IN SELECT psut.relid, 
                              psut.relname,
                              substr(psut.relname, 1, 2) as layer
                         FROM pg_statio_user_tables psut 
                    LEFT JOIN pg_inherits pi ON psut.relid = pi.inhrelid
                       WHERE schemaname = 'public' 
                         AND pi.inhparent IS NULL 
                         AND substr(psut.relname, 1, 2) IN ('wh', 'md', 'dm') -- LIMIT 1
        LOOP
            -- 获取表列数
            EXECUTE 'SELECT COUNT(1) FROM information_schema.columns WHERE table_name = ''' || rec_tbl.relname  || '''' INTO tbl_col_cnt;

            -- 获取行数
            EXECUTE 'SELECT count(1) FROM ' || rec_tbl.relname INTO tbl_cnt;

            -- 获取分区数
            EXECUTE 'SELECT COUNT(1) FROM pg_inherits WHERE inhparent = ' || rec_tbl.relid INTO tbl_partition_cnt;
                    
            -- 获取表尺寸(如果有分区，则主表空间为0, 需要基于分区表计算总容量
            IF tbl_partition_cnt > 0 THEN
                EXECUTE 'SELECT sys_get_partion_size(' || rec_tbl.relid || ')' INTO tbl_raw_size;
            ELSE 
                EXECUTE 'SELECT pg_relation_size(' || rec_tbl.relid || ')' INTO tbl_raw_size;
            END IF;
                    
            -- 获取可读的表尺寸
            EXECUTE 'SELECT pg_size_pretty(' || tbl_raw_size || '::bigint)' INTO tbl_rb_raw_size;

            -- 获取最小时间
            EXECUTE 'SELECT min(his_start_time) FROM ' || rec_tbl.relname INTO his_start_time;
            --           
            -- 获取最大时间
            EXECUTE 'SELECT max(his_start_time) FROM ' || rec_tbl.relname INTO his_end_time;
                    
            -- 获取月份数
            mth_cnt = datediff('mth', his_start_time, his_end_time);

            -- 获取年份数
            year_cnt = datediff('year', his_start_time, his_end_time);
                    
            -- 100w行数据容量
                        IF tbl_cnt > 0 THEN
                tbl_1m_raw_size = tbl_raw_size * 1000000 / tbl_cnt;
                        ELSE 
                            tbl_1m_raw_size = 0;
                        END IF;
                    
            -- 获取可读的表尺寸
            EXECUTE 'SELECT pg_size_pretty(' || tbl_1m_raw_size || '::bigint)' INTO tbl_1m_rb_size;
            --           tbl_avg_1m_rb_size = ;

            -- 获取最大时间
            EXECUTE 'SELECT COUNT(1) FROM ' || rec_tbl.relname || ' WHERE his_start_time = ' || to_int_date(now()::date) INTO last_day_cnt;

            -- 获取最大时间
            EXECUTE 'SELECT COUNT(1) FROM ' || rec_tbl.relname || ' WHERE his_start_time <= ' || to_int_date(now()::date) || ' AND his_start_time >= ' || to_int_date((now() - INTERVAL '30 day')::date) INTO last_30day_cnt;

            -- 获取最大时间
            EXECUTE 'SELECT COUNT(1) FROM ' || rec_tbl.relname || ' WHERE his_start_time <= ' || to_int_date(now()::date) || ' AND his_start_time >= ' || to_int_date((now() - INTERVAL '60 day')::date) INTO last_60day_cnt;

            -- 获取最大时间
            EXECUTE 'SELECT COUNT(1) FROM ' || rec_tbl.relname || ' WHERE his_start_time <= ' || to_int_date(now()::date) || ' AND his_start_time >= ' || to_int_date((now() - INTERVAL '90 day')::date) INTO last_90day_cnt;
                
                
            -- 获取表尺寸
            -- EXECUTE 'SELECT pg_size_pretty(' || tbl_raw_size || ')' INTO tbl_rb_raw_size;
                    
            -- RAISE NOTICE '%, %, %, %, %, %, %, %', rec_tbl, tbl_cnt, tbl_raw_size, tbl_rb_raw_size, tbl_partition_cnt, tbl_1m_raw_size, tbl_1m_rb_size, tbl_col_cnt;

            -- RAISE NOTICE '%,%,%', last_day_cnt,ceil(tbl_raw_size * last_day_cnt / tbl_cnt),pg_size_pretty(ceil(tbl_raw_size * last_day_cnt / tbl_cnt)::BIGINT);

            INSERT INTO sys_table_status VALUES (
                rec_tbl.relid, -- 表格ID
                rec_tbl.relname, -- 表格名称
                rec_tbl.layer, -- 数仓层次
                tbl_cnt, -- 表格数据量
                166, -- 表格列数
                tbl_partition_cnt, -- 表格分区数
                tbl_raw_size, -- 表格容量（raw）
                tbl_rb_raw_size, -- 表格容量（格式化）
                his_start_time,-- 数据起始时间（格式化）
                his_end_time,-- 数据结束时间（格式化）
                mth_cnt,-- 数据月份周期
                year_cnt,-- 数据年份周期
                tbl_1m_raw_size,-- 100万条数据容量（raw）
                tbl_1m_rb_size,-- 100万条数据容量（格式化）
                to_int_date(now()::date)
            );
                
        END LOOP;
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;