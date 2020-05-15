
#行存取只有堆表 heap
AO表可以行存取也可以列存取



#1、创建一个函数，用于创建400列的表（行存堆表、AO行存表、AO列存表）。
create or replace function f(name, int, text) returns void as $$  
declare  
  res text := '';  
begin  
  for i in 1..$2 loop  
    res := res||'c'||i||' int8,';  
  end loop;  
  res := rtrim(res, ',');  
  if $3 = 'ao_col' then  
    res := 'create table '||$1||'('||res||') with  (appendonly=true, blocksize=8192, compresstype=none, orientation=column)';  
  elsif $3 = 'ao_row' then  
    res := 'create table '||$1||'('||res||') with  (appendonly=true, blocksize=8192, orientation=row)';  
  elsif $3 = 'heap_row' then  
    res := 'create table '||$1||'('||res||') with  (appendonly=false)';  
  else  
    raise notice 'use ao_col, ao_row, heap_row as $3';  
    return;  
  end if;  
  execute res;  
end;  
$$ language plpgsql;

#创建表
 select f('tbl_ao_col', 400, 'ao_col');  
select f('tbl_ao_row', 400, 'ao_row');  
select f('tbl_heap_row', 400, 'heap_row'); 
#创建1个函数，用于填充数据，其中第一个和最后3个字段为测试数据的字段，其他都填充1。

create or replace function f_ins1(name, int, int8) returns void as $$  
declare  
  res text := '';  
begin  
  for i in 1..($2-4) loop  
    res := res||'1,';  
  end loop;  
  res := 'id,'||res;  
  res := rtrim(res, ',');  
  res := 'insert into '||$1||' select '||res||'id,random()*10000,random()*100000 from generate_series(1,'||$3||') t(id)';  
  execute res;  
end;  
$$ language plpgsql;
#填充数据
select f_ins1('tbl_ao_col',400,1000000);  
#创建1个函数，用于填充数据，其中前4个字段为测试数据的字段，其他都填充1。

create or replace function f_ins2(name, int, int8) returns void as $$  
declare  
  res text := '';  
begin  
  for i in 1..($2-4) loop  
    res := res||'1,';  
  end loop;  
  res := 'id,id,random()*10000,random()*100000,'||res;  
  res := rtrim(res, ',');  
  res := 'insert into '||$1||' select '||res||' from generate_series(1,'||$3||') t(id)';  
  execute res;  
end;  
$$ language plpgsql

#填充数据
select f_ins12'tbl_ao_col',400,1000000);


#给对标和行表添加数据
postgres=# insert into tbl_ao_row select * from tbl_ao_col;  
INSERT 0 1000000  
postgres=# insert into tbl_heap_row select * from tbl_ao_col;  
  
  
  #分析sql执行结果
  explain analyze select c2,count(*),sum(c3),avg(c3),min(c3),max(c3) from tbl_heap_row group by c2;  
  
结论：
行存堆表：  前面字段聚合计算： 138.524 ms  第300个字段：  聚合计算：214.024 ms


AO行：  行存AO表:  前面字段统计 152.386ms  最后字段聚合计算： 184.723 ms
AP列：  前面字段聚合计算 106.859 ms   后面字段聚合计算 122.173 ms 
