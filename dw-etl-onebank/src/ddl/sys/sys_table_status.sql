---------------------------------------------------------------
--
--     表名：sys_table_status
--          数据集市元数据数据概览表
--
---------------------------------------------------------------  
DROP TABLE IF EXISTS sys_table_status;
CREATE TABLE "sys_table_status" (
  "tbl_id" int4,
  "tbl_name" varchar(64),
  "dw_layer" varchar(64),
  "tbl_cnt" int8,
  "tbl_col_cnt" int8,
  "tbl_partition_cnt" varchar(60),
  "tbl_raw_size" int8,
  "tbl_rb_raw_size" varchar(60),
  "his_start_time" int4,
  "his_end_time" int4,
  "mth_cnt" int4,
  "year_cnt" int4,
  "tbl_1m_raw_size" int8,
  "tbl_1m_rb_size" varchar(60),
  "etl_date" int4
);