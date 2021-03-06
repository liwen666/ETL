DROP TABLE IF EXISTS "ods_anytxn_bm_cc_customer_lmt_daily_snap";
CREATE TABLE "ods_anytxn_bm_cc_customer_lmt_daily_snap" (
  "biz_date" int4 NOT NULL,
  "id" varchar(100) COLLATE "pg_catalog"."default",
  "cust_nbr" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "template_id" varchar(100) COLLATE "pg_catalog"."default",
  "lmt_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "typ_des" varchar(2000) COLLATE "pg_catalog"."default",
  "use_mde" varchar(100) COLLATE "pg_catalog"."default",
  "ccy" int4,
  "lmt_class" varchar(100) COLLATE "pg_catalog"."default",
  "oc_flg" varchar(100) COLLATE "pg_catalog"."default",
  "percent" numeric,
  "cr_lmt" numeric,
  "cr_lmt_permanent" numeric,
  "father_id" varchar(100) COLLATE "pg_catalog"."default",
  "father_typ_des" varchar(2000) COLLATE "pg_catalog"."default",
  "tol_precent" numeric,
  "tol_amt" numeric,
  "cr_lmt_temp" numeric,
  "cr_lmt_temp_start_dte" date,
  "cr_lmt_temp_end_dte" date,
  "avail_cr_lmt" numeric,
  "use_cr_lmt" numeric,
  "outstanding_auth_amt" numeric,
  "outstanding_auth_nbr" int4,
  "ol_pymt_amt" numeric,
  "cr_lmt_expiry_dte" date,
  "cr_lmt_dte" date,
  "organization_id" varchar(100) COLLATE "pg_catalog"."default",
  "lmt_lst_mnt_dte" timestamp(6),
  "lmt_lst_mnt_usr" varchar(2000) COLLATE "pg_catalog"."default",
  "lmt_count" int4,
  "use_count" int4,
  "use_flag" int4,
  "contract_no" varchar(2000) COLLATE "pg_catalog"."default" NOT NULL,
  "channel" varchar(2000) COLLATE "pg_catalog"."default",
  "business_date" date,
  "last_update_business_date" date,
  "is_use_control" varchar(100) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "last_update_time" timestamp(6),
  "last_update_operator" varchar(100) COLLATE "pg_catalog"."default",
  "real_channel" varchar(2000) COLLATE "pg_catalog"."default",
  CONSTRAINT "ods_anytxn_bm_cc_customer_lmt_daily_snap_pkey" PRIMARY KEY ("biz_date", "cust_nbr", "lmt_id", "contract_no")
);
