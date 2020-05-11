---------------------------------------------------------------
--
-- table_exist
-- 函数描述：判断表是否存在
--    参数：table_name 表名称
--         schema_name schema名称
--  返回值：空
--  创建人：--
--
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION "public"."table_existed"("schema_name" text,"table_name" text)
    RETURNS "pg_catalog"."bool" AS $BODY$
    DECLARE tableName text;
    BEGIN
        SELECT c.relname into tableName FROM pg_namespace n,pg_class c WHERE c.relname = table_name and n.nspname=schema_name and c.relnamespace = n.oid;
        
        IF tableName IS NULL THEN
            return false;
        ELSE
            return true;
        END IF;
    END;
    $BODY$
LANGUAGE plpgsql VOLATILE
COST 100;