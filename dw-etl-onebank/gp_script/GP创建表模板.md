drop table if exists rpt.rpt_bill_m ; 

create table rpt.rpt_bill_m (

user_id SERIAL, ----自增序列

acct_month varchar(6),

bill_fee numeric(16,2) ,

user_info text 

)

WITH (

appendonly=true, -- 对于压缩表跟列存储来说，前提必须是appendonly表

orientation=column,-- 列存 row

compresstype=zlib,-- 压缩格式 --QUICKLZ

COMPRESSLEVEL=5, -- 压缩等级 0--9 --1 压缩低查询快

OIDS=FALSE

)

DISTRIBUTED BY (user_id) -- 分布键

PARTITION BY LIST("acct_month") -- 分区键

(

PARTITION p_201810 VALUES ('201810'),

PARTITION p_201811 VALUES ('201811'),

PARTITION p_201812 VALUES ('201812'),

default partition other --容错没有分区键在此表

/* PARTITION p_20170801 START('20170801'::DATE) END ('20170831'::DATE)

EVERY ('1 month'::INTERVAL) */

);

comment on column rpt.rpt_bill_m.user_info is '员工备注信息'; -- 注解 
