
#GP的节点的数量
select * from gp_segment_configuration where status='d' or mode <>'s';

#1）创建临时表，插入10000条数据
create table xdual_temp

as 

select generate_series(1,10000) id

distributed by (id);

#2）建立心跳表，2个字段，第二个字段是timestamp类型的，每次心跳检测数据都会更新

create table xdual (id int,update_time timestamp(0))

distributed by (id);

#3）向心跳表中每个Segment中插入一条数据

insert into xdual(id,update_time)

select id,now() from 

(select id,row_number() over(partition by gp_segment_id order by id) rn 

from xdual_temp) t;


#4）心跳检测

运行update xdual set update_time=now();

只要这个SQL运行正常，就代表每一个Segment都是正常的。