DROP TABLE IF EXISTS "ods_anytxn_bm_acct_loan_daily_snap";
CREATE TABLE "ods_anytxn_bm_acct_loan_daily_snap" (
  "biz_date" int4 NOT NULL,
  "txa_number" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "txa_type" varchar(2) COLLATE "pg_catalog"."default",
  "txa_status" varchar(1) COLLATE "pg_catalog"."default",
  "txa_business_module" varchar(2) COLLATE "pg_catalog"."default",
  "txn_organization_id" varchar(4) COLLATE "pg_catalog"."default",
  "txn_type" varchar(5) COLLATE "pg_catalog"."default",
  "txn_code" varchar(5) COLLATE "pg_catalog"."default",
  "txn_system_date" timestamp(6),
  "txn_effective_date" timestamp(6),
  "txn_effective_amnt" numeric(18,5),
  "txn_effective_currency" varchar(3) COLLATE "pg_catalog"."default",
  "txn_posting_date" date,
  "txn_posting_time" timestamp(6),
  "txn_posting_amnt" numeric(18,5),
  "txn_posting_currency" varchar(3) COLLATE "pg_catalog"."default",
  "txn_settle_amnt" numeric(18,5),
  "txn_settle_currency" varchar(3) COLLATE "pg_catalog"."default",
  "txn_markup_percent" numeric(18,6),
  "txn_exchange_rate" numeric(18,9),
  "txn_plastic_number" varchar(19) COLLATE "pg_catalog"."default",
  "txn_card_number_post" varchar(19) COLLATE "pg_catalog"."default",
  "txn_lbs_info" varchar(255) COLLATE "pg_catalog"."default",
  "txn_country" varchar(3) COLLATE "pg_catalog"."default",
  "txn_region" varchar(2) COLLATE "pg_catalog"."default",
  "txn_channel" varchar(32) COLLATE "pg_catalog"."default",
  "txn_sub_channel_1" varchar(6) COLLATE "pg_catalog"."default",
  "txn_sub_channel_2" varchar(6) COLLATE "pg_catalog"."default",
  "txn_mechant_number" varchar(16) COLLATE "pg_catalog"."default",
  "txn_material_flag" varchar(1) COLLATE "pg_catalog"."default",
  "txn_pos_ind" varchar(1) COLLATE "pg_catalog"."default",
  "txn_auth_code" varchar(6) COLLATE "pg_catalog"."default",
  "txn_batch_number" varchar(6) COLLATE "pg_catalog"."default",
  "txn_voucher_number" varchar(6) COLLATE "pg_catalog"."default",
  "txn_reference_number" varchar(12) COLLATE "pg_catalog"."default",
  "txn_cust_number" varchar(32) COLLATE "pg_catalog"."default",
  "txn_cust_name" varchar(60) COLLATE "pg_catalog"."default",
  "txn_cust_group_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_intr_start_date" date,
  "txn_statment_day_date" date,
  "txn_waive_intr_flag" varchar(1) COLLATE "pg_catalog"."default",
  "txn_waive_latechg_flag" varchar(1) COLLATE "pg_catalog"."default",
  "txn_chargeoff_flag" varchar(1) COLLATE "pg_catalog"."default",
  "txn_chargeoff_amnt" numeric(18,5),
  "txn_chargeoff_date" date,
  "txn_chargeoff_rsn_cd" varchar(4) COLLATE "pg_catalog"."default",
  "txn_orig_txa_number" varchar(32) COLLATE "pg_catalog"."default",
  "txn_create_date" timestamp(6),
  "txn_last_update_date" timestamp(6),
  "txn_last_update_operator" varchar(40) COLLATE "pg_catalog"."default",
  "txn_parent_txa_number" varchar(32) COLLATE "pg_catalog"."default",
  "txn_stmt_repayment_tableid" varchar(6) COLLATE "pg_catalog"."default",
  "pro_cd" varchar(6) COLLATE "pg_catalog"."default",
  "txn_orig_txa_type" varchar(2) COLLATE "pg_catalog"."default",
  "txn_parent_txa_type" varchar(2) COLLATE "pg_catalog"."default",
  "txn_session_number" varchar(32) COLLATE "pg_catalog"."default",
  "txn_connect_txa_number" varchar(32) COLLATE "pg_catalog"."default",
  "txn_connect_txa_type" varchar(2) COLLATE "pg_catalog"."default",
  "loan_plan_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "bal_trans_flag" varchar(1) COLLATE "pg_catalog"."default",
  "compensatory_flag" varchar(1) COLLATE "pg_catalog"."default",
  "joint_loan_flag" varchar(1) COLLATE "pg_catalog"."default",
  "fus_id" varchar(4) COLLATE "pg_catalog"."default",
  "loan_prin_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_intr_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "loan_fee_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "loan_payoff_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_pen_intr_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_cs_pen_intr_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_cs_intr_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_cs_loan_fee_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_cs_loan_prepay_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "txn_cs_loan_payoff_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "loan_billing_cycle" varchar(2) COLLATE "pg_catalog"."default",
  "loan_payment_due_date" date,
  "first_payment_due_date" date,
  "last_payment_due_date" date,
  "loan_tenor" int4,
  "loan_fee_wavie_from" int4,
  "loan_fee_wavie_to" int4,
  "loan_status" varchar(3) COLLATE "pg_catalog"."default",
  "loan_tenor_typ" varchar(4) COLLATE "pg_catalog"."default",
  "loan_acq_ref_nbr" varchar(32) COLLATE "pg_catalog"."default",
  "loan_operator_id" varchar(20) COLLATE "pg_catalog"."default",
  "loan_mechant_name" varchar(60) COLLATE "pg_catalog"."default",
  "loan_b018_merchant_typ" varchar(4) COLLATE "pg_catalog"."default",
  "loan_order_number" varchar(32) COLLATE "pg_catalog"."default",
  "loan_status_reason" varchar(256) COLLATE "pg_catalog"."default",
  "loan_cast_tenor" int4,
  "loan_payment_tenor" int4,
  "loan_close_payment_date" date,
  "loan_curr_balance" numeric(18,2),
  "loan_contract_id" varchar(16) COLLATE "pg_catalog"."default",
  "loan_channel_id" varchar(16) COLLATE "pg_catalog"."default",
  "loan_total_balance" numeric(18,2),
  "loan_total_principal_balance" numeric(18,2),
  "loan_total_interest_balance" numeric(18,2),
  "loan_total_service_fee_balance" numeric(18,2),
  "discount_be_interest" numeric(18,2),
  "discount_interest" numeric(18,2),
  "loan_total_penalty_fee" numeric(18,2),
  "loan_total_penalty_exempt_amnt" numeric(18,2),
  "coupon_flow_id" varchar(16) COLLATE "pg_catalog"."default",
  "loan_payment_date_dd" int8,
  "loan_daily_rate" numeric(18,10),
  "fus_daily_rate" numeric(18,8),
  "converted_daily_rate" numeric(18,8),
  "daily_rate_before" numeric(18,10),
  "loan_prepay_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "loan_contract_number" varchar(60) COLLATE "pg_catalog"."default",
  "business_type" varchar(2) COLLATE "pg_catalog"."default",
  "staff_name_lj" varchar(256) COLLATE "pg_catalog"."default",
  "staff_id_type" varchar(50) COLLATE "pg_catalog"."default",
  "staff_id_number" varchar(20) COLLATE "pg_catalog"."default",
  "staff_account" varchar(20) COLLATE "pg_catalog"."default",
  "check_digit" varchar(200) COLLATE "pg_catalog"."default",
  "serial_num" varchar(64) COLLATE "pg_catalog"."default",
  "loan_use" varchar(4) COLLATE "pg_catalog"."default",
  "staff_cust_number" varchar(16) COLLATE "pg_catalog"."default",
  "product_code" varchar(32) COLLATE "pg_catalog"."default",
  "txn_late_charge_fee_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "compensatory_days" int4,
  "txn_lending_time" timestamp(6),
  "total_over_due_tenor" int8,
  "total_cmps_tenor" int8,
  "invest" varchar(10) COLLATE "pg_catalog"."default",
  "reveal_mobel" varchar(1) COLLATE "pg_catalog"."default",
  "back_fee_rate" numeric(18,2),
  "last_update_business_date" date,
  "hp_posting_amnt" numeric(18,2),
  "ot_posting_amnt" numeric(18,2),
  "fus_percentage" numeric(3,2),
  "hp_curr_balance" numeric(18,2),
  "ot_curr_balance" numeric(18,2),
  "continue_over_due_tenor" int4,
  "mark" varchar(255) COLLATE "pg_catalog"."default",
  "txn_partner_pen_intr_table_id" varchar(6) COLLATE "pg_catalog"."default",
  "last_update_time" timestamp(6),
  "create_time" timestamp(6),
  "loan_start_date" date,
  "real_channel" varchar(23) COLLATE "pg_catalog"."default",
  "is_stock_order" varchar(1) COLLATE "pg_catalog"."default",
  "asset_status" varchar(1) COLLATE "pg_catalog"."default",
  "portfolio_code" varchar(32) COLLATE "pg_catalog"."default",
  "has_loop" varchar(2) COLLATE "pg_catalog"."default",
  "org_code" varchar(32) COLLATE "pg_catalog"."default",
  "cust_ecif_id" varchar(32) COLLATE "pg_catalog"."default",
  "subject_code" varchar(32) COLLATE "pg_catalog"."default",
  "org_id" varchar(32) COLLATE "pg_catalog"."default",
  "five_code" varchar(32) COLLATE "pg_catalog"."default",
  "asset_type" varchar(10) COLLATE "pg_catalog"."default",
  "trusted_pay" varchar(10) COLLATE "pg_catalog"."default",
  "lpr_rate_arith_sbl" varchar(10) COLLATE "pg_catalog"."default",
  "lpr_rate_arith_value" numeric(10,8),
  "year_base_rate" varchar(10) COLLATE "pg_catalog"."default",
  "lpr_base_rate" varchar(10) COLLATE "pg_catalog"."default",
  "loan_close_payment_pdf" varchar(1) COLLATE "pg_catalog"."default",
  CONSTRAINT "ods_anytxn_bm_acct_loan_daily_snap_pkey" PRIMARY KEY ("biz_date", "txa_number")
);