DROP TABLE IF EXISTS "ods_anytxn_bm_acct_intr_his";
CREATE TABLE "ods_anytxn_bm_acct_intr_his" (
  "his_start_time" int4 NOT NULL,
  "his_end_time" int4 NOT NULL,
  "txa_number" varchar(2000) COLLATE "pg_catalog"."default" NOT NULL,
  "txa_type" varchar(100) COLLATE "pg_catalog"."default",
  "txa_status" varchar(100) COLLATE "pg_catalog"."default",
  "txa_business_module" varchar(100) COLLATE "pg_catalog"."default",
  "txn_type" varchar(100) COLLATE "pg_catalog"."default",
  "txn_code" varchar(100) COLLATE "pg_catalog"."default",
  "txn_system_date" timestamp(6),
  "txn_organization_id" varchar(100) COLLATE "pg_catalog"."default",
  "txn_effective_date" timestamp(6),
  "txn_effective_amnt" numeric,
  "txn_effective_currency" varchar(100) COLLATE "pg_catalog"."default",
  "txn_posting_date" date,
  "txn_posting_time" timestamp(6),
  "txn_posting_amnt" numeric,
  "txn_posting_currency" varchar(100) COLLATE "pg_catalog"."default",
  "txn_settle_amnt" numeric,
  "txn_settle_currency" varchar(100) COLLATE "pg_catalog"."default",
  "txn_markup_percent" numeric,
  "txn_exchange_rate" numeric,
  "txn_plastic_number" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_card_number_post" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_lbs_info" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_country" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_region" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_channel" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_sub_channel_1" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_sub_channel_2" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_mechant_number" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_material_flag" varchar(100) COLLATE "pg_catalog"."default",
  "txn_pos_ind" varchar(100) COLLATE "pg_catalog"."default",
  "txn_auth_code" varchar(100) COLLATE "pg_catalog"."default",
  "txn_batch_number" varchar(100) COLLATE "pg_catalog"."default",
  "txn_voucher_number" varchar(100) COLLATE "pg_catalog"."default",
  "txn_reference_number" varchar(100) COLLATE "pg_catalog"."default",
  "txn_cust_number" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_cust_name" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_cust_group_id" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_intr_start_date" date,
  "txn_waive_intr_flag" varchar(100) COLLATE "pg_catalog"."default",
  "txn_waive_latechg_flag" varchar(100) COLLATE "pg_catalog"."default",
  "txn_chargeoff_flag" varchar(100) COLLATE "pg_catalog"."default",
  "txn_chargeoff_amnt" numeric,
  "txn_chargeoff_date" date,
  "txn_chargeoff_rsn_cd" varchar(100) COLLATE "pg_catalog"."default",
  "txn_total_amnt_due" numeric,
  "txn_orig_txa_number" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_intr_table_id" varchar(100) COLLATE "pg_catalog"."default",
  "txn_create_date" timestamp(6),
  "txn_last_update_date" timestamp(6),
  "txn_last_update_operator" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_parent_txa_number" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_late_charge_feetableid" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_stmt_repayment_tableid" varchar(2000) COLLATE "pg_catalog"."default",
  "pro_cd" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_orig_txa_type" varchar(100) COLLATE "pg_catalog"."default",
  "txn_parent_txa_type" varchar(100) COLLATE "pg_catalog"."default",
  "txn_connect_txa_number" varchar(2000) COLLATE "pg_catalog"."default",
  "txn_connect_txa_type" varchar(100) COLLATE "pg_catalog"."default",
  "loan_banlance_type_flag" varchar(100) COLLATE "pg_catalog"."default",
  "loan_order_number" varchar(100) COLLATE "pg_catalog"."default",
  "loan_billing_tenor" int4,
  "product_code" varchar(2000) COLLATE "pg_catalog"."default",
  "cs_accu_total_accru_intr" numeric,
  "txn_cs_posting_amnt" numeric,
  "txn_capital_source_posting_amnt" numeric,
  "fus_id" varchar(2000) COLLATE "pg_catalog"."default",
  "joint_loan_flag" varchar(100) COLLATE "pg_catalog"."default",
  "fus_percentage" numeric,
  "hp_posting_amnt" numeric,
  "flag" varchar(2000) COLLATE "pg_catalog"."default",
  "ot_posting_amnt" numeric,
  "create_time" timestamp(6),
  "last_update_time" timestamp(6),
  "real_channel" varchar(2000) COLLATE "pg_catalog"."default",
  "etl_date" int4,
  CONSTRAINT "ods_anytxn_bm_acct_intr_his_pkey" PRIMARY KEY ("his_end_time","txa_number")
);