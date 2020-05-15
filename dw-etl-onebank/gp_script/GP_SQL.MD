#查询表字段以及字段类型

SELECT relname,attname,typname FROM pg_class c,pg_attribute a,pg_type t WHERE c.relname = 't_hash' AND c.oid = attrelid AND atttypid = t.oid AND attnum > 0;

#查看表的分布键信息
select * from gp_distribution_policy bb where bb.localoid='214090' -- 分布键信息表

select oid, relname, relnamespace from pg_class aa where relname='t_hash'
select attname ,attrelid from pg_attribute where attrelid='214090'  -- 表字段信息表
select * from pg_inherits hh where inhrelid='214090'
select * from pg_namespace dd where dd.nspname = 'public'  -- 表的模式信息表
select * from pg_class aa  -- 表基础信息表 


#查看分区键定义
SELECT pg_get_partition_def('public.order_detail'::regclass,true);
#查看分布键定义
SELECT attname FROM pg_attribute WHERE attrelid='public.order_detail'::regclass and attnum in (SELECT unnest(distkey) FROM pg_catalog.gp_distribution_policy t WHERE localoid='public.order_detail'::regclass);

#查看表大小
select pg_size_pretty(pg_relation_size('tbl_ao_col')); 


#表分析
analyze tbl_ao_col ;

#分析sql执行结果
explain analyze select c2,count(*),sum(c3),avg(c3),min(c3),max(c3) from tbl_heap_row group by c2;  

#如何查看表的存储结构
pg_class.relstorage表示这个对象是什么存储：

postgres=# select distinct relstorage from pg_class ;    
 relstorage     
------------    
 a  -- 行存储AO表    
 h  -- heap堆表、索引    
 x  -- 外部表(external table)    
 v  -- 视图    
 c  -- 列存储AO表  
 
 
 #查询当前数据库有哪些AO表：
 
select t2.nspname, t1.relname from pg_class t1, pg_namespace t2 where t1.relnamespace=t2.oid and relstorage in ('c', 'a');    


#查询当前数据库有哪些堆表：

select t2.nspname, t1.relname from pg_class t1, pg_namespace t2 where t1.relnamespace=t2.oid and relstorage in ('h')