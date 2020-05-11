/*
 Navicat Premium Data Transfer

 Source Server         : 华通SITGP
 Source Server Type    : PostgreSQL
 Source Server Version : 90424
 Source Host           : 10.11.20.83:5432
 Source Catalog        : dw_onebank_ccs
 Source Schema         : zip_test

 Target Server Type    : PostgreSQL
 Target Server Version : 90424
 File Encoding         : 65001

 Date: 27/03/2020 14:52:26
*/


-- ----------------------------
-- Table structure for md_cm_bp_code_table_type
-- ----------------------------
DROP TABLE IF EXISTS "md_cm_bp_code_table_type";
CREATE TABLE "md_cm_bp_code_table_type" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "name_local" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "desc_" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "desc_local" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "addable" char(1) COLLATE "pg_catalog"."default",
  "order_" int8 NOT NULL,
  "isvalid" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "lastupdater" varchar(128) COLLATE "pg_catalog"."default",
  "lastupdatetime" timestamp(6),
  "ischannel" char(1) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Primary Key structure for table md_cm_bp_code_table_type
-- ----------------------------
ALTER TABLE "md_cm_bp_code_table_type" ADD CONSTRAINT "md_cm_bp_code_table_type_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Records of md_cm_bp_code_table_type
-- ----------------------------
INSERT INTO "md_cm_bp_code_table_type" VALUES ('APP_DEVICE_TYPE', '申请设备类型', '申请设备类型', '申请设备类型', '申请设备类型', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('CUSTOMER_TYPE', '客户类型', '客户类型', '客户类型', '客户类型', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('DECOUPLING_FLAG', '是否他行客户', '是否他行客户', '是否他行客户', '是否他行客户', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('ID_TYPE', '证件类型', '证件类型', '证件类型', '证件类型', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('LOAN_PURPOSE', '贷款用途', '贷款用途', '贷款用途', '贷款用途', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('OCCUPATION', '职业/职务', '职业/职务', '职业/职务', '职业/职务', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('RELATION_TYPE', '关系类型', '关系类型', '关系类型', '关系类型', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('ASSET_TYPE', '资产类型', '资产类型', '资产类型', '资产类型', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('BANK_CODE', '放款银行代码', '放款银行代码', '放款银行代码', '放款银行代码', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('EDUCATION', '学历', '学历', '学历', '学历', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('INDUSTRY_TP_CD', '行业类型', '行业类型', '行业类型', '行业类型', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('LPR_TYPE', '利率品种类型', '利率品种类型', '利率品种类型', '利率品种类型', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('MARRIAGE_STATUS', '婚姻状况', '婚姻状况', '婚姻状况', '婚姻状况', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('NATION', '民族', '民族', '民族', '民族', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('REPAYMENT', '还款方式', '还款方式', '还款方式', '还款方式', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
INSERT INTO "md_cm_bp_code_table_type" VALUES ('SEX', '客户性别', '客户性别', '客户性别', '客户性别', 'Y', 1, 'Y', 'CS0707A011', '2012-09-04 16:37:44', NULL);
COMMIT;

