/*
Navicat PGSQL Data Transfer

Source Server         : 10.11.16.29
Source Server Version : 90424
Source Host           : 10.11.16.29:5432
Source Database       : dw_onebank_ccs_sit
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90424
File Encoding         : 65001

Date: 2020-04-15 21:17:02
*/


-- ----------------------------
-- Table structure for ods_anytxn_batch_quartz_sign
-- ----------------------------
DROP TABLE IF EXISTS "public"."ods_anytxn_batch_quartz_sign";
CREATE TABLE "public"."ods_anytxn_batch_quartz_sign" (
"id" int4 NOT NULL,
"create_time" timestamp(6),
"quartz_id" int4 NOT NULL,
"status" int4,
"business_date" varchar(10) COLLATE "default" NOT NULL,
"update_time" timestamp(6)
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of ods_anytxn_batch_quartz_sign
-- ----------------------------

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table ods_anytxn_batch_quartz_sign
-- ----------------------------
ALTER TABLE "public"."ods_anytxn_batch_quartz_sign" ADD PRIMARY KEY ("id");
