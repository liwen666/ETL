#heap表
    drop table if exists t01; 
    create table t01(id int primary key) distributed by (id);
1
2
#AO表不压缩 (AO表是否不能有主键？)
    drop table if exists t02;
    create table t02(id int) with (appendonly=true) distributed by (id);
1
2
#AO表压缩
    drop table if exists t03;
    create table t03(id int) with (appendonly=true, compresslevel=5)
    distributed by (id);
1
2
3
#AO表列存压缩 与上表的压缩方式不同
    drop table if exists t04;
    create table t04(id int) with (appendonly=true,compresslevel=5, orientation=column) distributed by (id);

（1）列表分区

--为表p的id2字段创建列表分区
create table p(
  id1 integer,
  id2 varchar(10)) 
  distribute by(id1)
  partition by list(id2)
  (
    partition p1 values ('1','2')     --子分区p1包含的值为('1','2')
    partition p2 values ('3','0')     --子分区p2包含的值为(‘3’,‘0’)
    default partition pd              --其他值默认为pd分区
  )
);




#创建分区表

 
CREATE TABLE "public".order_detail
(
  date_id integer,
  order_id character varying(22),
  product_id character varying(50),
  order_quantity numeric,
  allot_quantity numeric,
  original_price numeric,
  sale_price numeric,
  vip_price numeric,
  bargin_price numeric,
  medium numeric,
  promotion_id numeric,
  is_vip_discount numeric,
  product_type numeric,
  reduce_price numeric,
  etl_change_date timestamp without time zone,
  order_items_id numeric,
  gift_card_charge numeric(12,2),
  gift_unit_price numeric,
  item_id numeric,
  parent_item_id numeric,
  allot_activity_fee numeric(12,2),
  allot_point_deduction_amount numeric,
  send_date timestamp without time zone,
  privilege_code_discount_amount numeric,
  relation_type numeric,
  parent_id character varying(16),
  shop_id numeric,
  shop_type numeric
)
WITH (
  OIDS=FALSE
)
DISTRIBUTED BY (order_id)
PARTITION BY RANGE(send_date)
(
PARTITION p_order_detail_20170701 START ('2017-06-01 00:00:00'::timestamp without time zone) END ('2017-07-01 00:00:00'::timestamp without time zone),
PARTITION p_order_detail_20170801 START ('2017-07-01 00:00:00'::timestamp without time zone) END ('2017-08-01 00:00:00'::timestamp without time zone)
)

#添加分区
 
alter table public.order_detail add partition p_order_detail_adt_20170601 START ('2017-05-01 00:00:00'::timestamp without time zone) END ('2017-06-01 00:00:00'::timestamp without time zone)
 EVERY ('1 mon'::interval)
 
 
 
 
 
 #--为p表的id3字段创建范围分区
  
 
 create table p
 (id1 integer,
  id2 varchar(10),
  id3 date,
  id4 integer)
  distributed by (id1)
  --从1号到31号每一天为一个子分区表
 --  partition by range(id4)
 --  ( START (1) END (31) every(1),
 --    default partition none 
 --  )
  --指定时间区间作为子分区
  --分区的values必须是与分区表分区键类型对应的值，如无对应分区，数据插入时会出错。
  --且不需要一次性将所有分区写入，有分区表存储过程可自动增加相应分区
 --  partition by range(id3)
 --  ( partition p1 START ('2018-08-20') END ('2018-09-20'),
 --    partition p2 START ('2018-09-21') END ('2018-09-30'),
 --    default partition other
 --  );
  --从18年到19年每七天为一个子分区表
  partition by range(id3)
 ( START ( '2018-01-01') INCLUSIVE
    END ( '2019-01-01') EXCLUSIVE
    EVERY (INTERVAL '7 day') 
 );
 

#列分区表
drop table if exists t07;
    create table t07(id int , gender char(2)) with(appendonly=true,compresslevel=5) distributed by (id)
    partition by list(gender)
    (
        partition man values('m'),
        partition woman values('f'),
        default partition Unkown
    );
    
#二级分区表
  drop table if exists t08;
    create table t08(id int, period date, Sales decimal(9,6), Region varchar(500)) distributed by (id)
    partition by range (period)
    subpartition by list (region)
    subpartition template
    (
        subpartition usa values ('usa'),
        subpartition asia values ('asia'),
        subpartition europe values ('europe'),
        default subpartition other
    )
    (
        start ('2018-01-01'::date) inclusive
        end ('2019-01-01'::date) exclusive
        every (interval '1 month'),
        default partition other
    );  


  