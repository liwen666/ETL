---------------------------------------------------------------
--
-- log_info
-- 函数描述：判断表是否存在
--    参数：table_name 表名称
--         schema_name schema名称
--  返回值：空
--  创建人：--
--
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION log_info(msg VARCHAR, show_log INT DEFAULT 1, log_level VARCHAR DEFAULT 'info')
    returns VOID as $$
BEGIN
        IF show_log = 0 THEN
        RETURN;
    END IF;

        IF log_level = 'info' THEN
          RAISE INFO '%', msg;
            
        ELSIF log_level = 'notice' THEN
          RAISE NOTICE '%', msg;
            
        ELSIF log_level = 'warning' THEN
          RAISE WARNING '%', msg;
            
        ELSIF log_level = 'exception' THEN
          RAISE EXCEPTION '%', msg;
    END IF;
END;
$$ language plpgsql;

-- select ; 

-- SELECT log_info(format('Hello %2$s and %1$s', 'Jane', 'Joe'), 1, 'exception');