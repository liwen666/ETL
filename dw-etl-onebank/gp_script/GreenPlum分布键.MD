#greenplum分布键详解
1）hash分布：选择一个列后者多个列作为数据表的分布键，通过hash计算，然后将插入的数据路由到特定的segment上；
create table t_hash(id int,name varchar(50)) distributed by (id);


#分析是否用到分布键

explain analyze select * from t_hash where name='ddd'; 





greenplum分布键选取策略：

（1）尽量选择经常需要JOIN的列：当关联键和分布键均一致时，可以在 Segment 中完成 JOIN，不需要重分布或者广播小表；当关联键和分布键不一致时，则需要重分布不一致的表或者广播小表，带来额外的开销。
（2）尽量选择分布均匀的列或者多列：若选择的分布列值分布不均匀，则可能导致数据倾斜。某些 Segment 非常大（压力大），某些 Segment 非常小。根据木桶原理，时间消耗会卡在数据多的节点上。
（3）尽量选择高并发查询的条件列（指该查询条件产生的中间结果集小的，如果中间结果集很大，那就让所有节点都来参与运算更好，因此不选）
如果数据经常被高并发的键值或离散查询，可以将查询条件的列作为分布列，这样不需要连接到所有的 Segment 去查，可以大大提高并发能力。
（4）不要轻易使用随机分布


修改分布键
alter table tab01 set distributed by(name);

#列转行用，分隔
select string_agg(b.attname,',') from  pg_attribute  b