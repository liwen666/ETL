DROP TABLE IF EXISTS "ods_anytxn_bm_cc_loan_plan_daily_snap";
CREATE TABLE "ods_anytxn_bm_cc_loan_plan_daily_snap" (
  "biz_date" int4,
  "plan_detl_id" int4 NOT NULL,
  "status" varchar(100) COLLATE "pg_catalog"."default",
  "loan_order_number" varchar(2000) COLLATE "pg_catalog"."default",
  "billing_tenor" int4,
  "delq_days" int4,
  "curr_total_amnt" numeric,
  "cs_curr_total_amnt" numeric,
  "principal_amnt" numeric,
  "interest_amnt" numeric,
  "service_fee" numeric,
  "cs_service_fee" numeric,
  "over_due_amnt" numeric,
  "exempt_amnt" numeric,
  "hp_curr_total_amnt" numeric,
  "hp_principal_amnt" numeric,
  "hp_interest_amnt" numeric,
  "hp_service_fee" numeric,
  "ot_curr_total_amnt" numeric,
  "ot_principal_amnt" numeric,
  "ot_interest_amnt" numeric,
  "ot_service_fee" numeric,
  "payment_due_date" date,
  "effective_date" date,
  "effective_time" timestamp(6),
  "card_number" varchar(2000) COLLATE "pg_catalog"."default",
  "bank_name" varchar(2000) COLLATE "pg_catalog"."default",
  "acq_ref_nbr" varchar(2000) COLLATE "pg_catalog"."default",
  "auto_pymt_ind" varchar(100) COLLATE "pg_catalog"."default",
  "payment_flag" varchar(100) COLLATE "pg_catalog"."default",
  "is_cmps_over" int4,
  "compensatory_flag" varchar(100) COLLATE "pg_catalog"."default",
  "bal_trans_flag" varchar(100) COLLATE "pg_catalog"."default",
  "last_update_business_date" date,
  "last_update_time" timestamp(6),
  "create_time" timestamp(6),
  "rep_grace" int4,
  "ovd_status" varchar(100) COLLATE "pg_catalog"."default",
  "start_date_option" varchar(100) COLLATE "pg_catalog"."default",
  "etl_date" int4,
  CONSTRAINT "ods_anytxn_bm_cc_loan_plan_daily_snap_pkey" PRIMARY KEY ("biz_date", "plan_detl_id")
)
;