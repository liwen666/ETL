--======================================================
--
-- Author: 北京江融信科技有限公司
-- Create date: 2019年8月3日
-- Description: 创建拉链表
-- Modify:
--
--======================================================
DROP FUNCTION IF EXISTS etl_ods_create_zip_table(int);
CREATE OR REPLACE FUNCTION "etl_ods_create_zip_table"("biz_date" int)
RETURNS VARCHAR AS $BODY$
    BEGIN

    --额度利率表
    PERFORM etl_create_zip_table_multi_pkey('ods_anytxn_bm_cc_customer_lmt', ARRAY['cust_nbr', 'lmt_id', 'contract_no'], biz_date);

    --贷款借据表
    PERFORM etl_create_zip_table('ods_anytxn_bm_acct_loan', 'txa_number', biz_date);

    --还款计划表
    PERFORM etl_create_zip_table('ods_anytxn_bm_cc_loan_plan', 'plan_detl_id', biz_date);

	--利息表
	PERFORM etl_create_zip_table('ods_anytxn_bm_acct_intr','txa_number', biz_date);

    --利息累计表
    PERFORM etl_create_zip_table('ods_anytxn_bm_intr_accu_acct', 'txa_number', biz_date);


	--延滞表
	PERFORM etl_create_zip_table('ods_anytxn_bm_acct_delq',  'txa_number',biz_date);


	--贷款本金表
	PERFORM etl_create_zip_table('ods_anytxn_bm_acct_loan_detl', 'txa_number', biz_date);

    RETURN 'OK';
    
    EXCEPTION
        WHEN others THEN
            RETURN 'ERROR: [etl_ods_create_daily_snap_table][' || biz_date || '] ' || SQLERRM;
    END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

-- SELECT etl_ods_create_zip_table('ods_anytxn_', '2020-02-02');
-- 1824.153s