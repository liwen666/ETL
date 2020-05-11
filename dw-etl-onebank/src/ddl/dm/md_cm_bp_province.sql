
-- ----------------------------
-- Table structure for md_cm_bp_province
-- ----------------------------
DROP TABLE IF EXISTS "md_cm_bp_province";
CREATE TABLE "md_cm_bp_province" (
  "id" varchar(20) COLLATE "pg_catalog"."default",
  "name" varchar(60) COLLATE "pg_catalog"."default",
  "desc_" varchar(600) COLLATE "pg_catalog"."default",
  "order_" int8,
  "isvalid" char(1) COLLATE "pg_catalog"."default",
  "lastupdatetime" char(20) COLLATE "pg_catalog"."default"
);

-- ----------------------------
-- Records of md_cm_bp_province
-- ----------------------------
INSERT INTO "md_cm_bp_province" VALUES ('110000', '北京市', '北京市', 1, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('230000', '黑龙江省', '黑龙江省', 8, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('500000', '重庆市', '重庆市', 22, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('430000', '湖南省', '湖南省', 18, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('120000', '天津市', '天津市', 2, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('340000', '安徽省', '安徽省', 12, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('350000', '福建省', '福建省', 13, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('640000', '宁夏回族自治区', '宁夏回族自治区', 30, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('440000', '广东省', '广东省', 19, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('410000', '河南省', '河南省', 16, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('520000', '贵州省', '贵州省', 24, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('140000', '山西省', '山西省', 4, 'Y', '2016-11-13 10:57:36 ');
INSERT INTO "md_cm_bp_province" VALUES ('150000', '内蒙古自治区', '内蒙古自治区', 5, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('710000', '台湾省', '台湾省', 32, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('450000', '广西壮族自治区', '广西壮族自治区', 20, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('810000', '香港特别行政区', '香港特别行政区', 33, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('820000', '澳门特别行政区', '澳门特别行政区', 34, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('540000', '西藏自治区', '西藏自治区', 26, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('630000', '青海省', '青海省', 29, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('370000', '山东省', '山东省', 15, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('420000', '湖北省', '湖北省', 17, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('360000', '江西省', '江西省', 14, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('310000', '上海市', '上海市', 9, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('130000', '河北省', '河北省', 3, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('320000', '江苏省', '江苏省', 10, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('330000', '浙江省', '浙江省', 11, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('530000', '云南省', '云南省', 25, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('220000', '吉林省', '吉林省', 7, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('210000', '辽宁省', '辽宁省', 6, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('510000', '四川省', '四川省', 23, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('610000', '陕西省', '陕西省', 27, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('650000', '新疆维吾尔自治区', '新疆维吾尔自治区', 31, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('620000', '甘肃省', '甘肃省', 28, 'Y', '2013-06-05 19:05:58 ');
INSERT INTO "md_cm_bp_province" VALUES ('460000', '海南省', '海南省', 21, 'Y', '2013-06-05 19:05:58 ');
COMMIT;
