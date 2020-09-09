#GP安装位置
whereis greenplum-db-6.0.0

/usr/local/greenplum-db-6.0.0

#配置环境
vi ~/.bashrc
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export LANG=en_US.UTF-8


source /usr/local/greenplum-db-6.0.0/greenplum_path.sh
export MASTER_DATA_DIRECTORY=/data/master/gpseg-1
export PGPORT=5432
export PGUSER=gpadmin
#export PGDATABASE=test_db
export LD_PRELOAD=/lib64/libz.so.1 ps

source ~./bashrc

#测试使用

psql -d etl_test -h 172.16.101.37  -p 5432 -U gpadmin

psql -d finace_cloud -h 172.16.103.105  -p 5432 -U gpadmin

#切换数据库
\c dbname 
\help  帮助
\l  列出所有数据库
\d 列出所有表
 \d order_detail  列出表所有字段
 查看分区键和分布键
  \d+ order_detail
  \di 查看索引
  \df 查看函数
  \timing on   开启执行时间统计
  \g  执行sql  展示执行结果  
  
  
  
  
  --1，查看列名以及类型
  select upper(column_name) ,data_type from information_schema.columns 
  where table_schema='ods_hs08' and lower(table_name)=lower('T_ods_hs08_secumreal');
  
  --2,查看表名剔除分区表名
  select a.tablename from pg_tables a where a.schemaname='ods_hs08'
  and a.tablename not in (select b.partitiontablename from pg_partitions b where b.schemaname='ods_hs08' ) ;
  --3,查分区表名
  select parentpartitiontablename,partitiontablename,* from pg_partitions ;
  --4,查看gpload错误记录表
  select * from gp_read_error_log('ext_gpload_reusable_2117d97e_5cf0_11e9_b169_2880239d54e8') 
  where cmdtime > to_timestamp('1554971595.06');
  
  select gp_read_error_log('ext_gpload_4a33e352_5f20_11e9_8223_2880239d54e8 ');
  --5,修改主键
  alter table ods_htgs.ttrd_acc_balance_cash
    add constraint ttrd_acc_balance_cash_pkey primary key (cash_ext_accid, accid, currency);
    --或者在建表语句列后面加
  CONSTRAINT ttrd_acc_balance_cash_pkey PRIMARY KEY (cash_ext_accid, accid, currency)
  
  --6，外键约束
  alter table ods_htgs.ttrd_acc_secu
    add constraint fk_ttrd_acc_secu foreign key (cash_accid)
    references ods_htgs.ttrd_acc_cash (accid);
    --或者在建表语句列后面加
    CONSTRAINT fk_ttrd_acc_secu FOREIGN KEY (cash_accid)
        REFERENCES ods_htgs.ttrd_acc_cash (accid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
       
  --7，字符转日期转数字
  select * from  ods_hs08.t_ods_hs08_his_entrust
  where to_number(to_char(to_date(init_date || '','yyyyMMdd'),'yyyyMMdd'),'99999999') between 20010101 and 20191201
  
  --8，table_constraint语法：
  table_constraint is:
  
  [ CONSTRAINT constraint_name ]
  { UNIQUE ( column_name [, ... ] ) [ USING INDEX TABLESPACE tablespace ] |
    PRIMARY KEY ( column_name [, ... ] ) [ USING INDEX TABLESPACE tablespace ] |
    CHECK ( expression ) |
    FOREIGN KEY ( column_name [, ... ] ) REFERENCES reftable [ ( refcolumn [, ... ] ) ]
      [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ] [ ON DELETE action ] [ ON UPDATE action ] }
  [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
  
  --9，查看数据库、表占用空间:
  select pg_size_pretty(pg_relation_size('schema.tablename'));
  select pg_size_pretty(pg_database_size('databasename'));
  
  --10，查看schema占用的空间：
  select pg_size_pretty(pg_relation_size(tablename)) from pg_tables t
  inner join pg_namespase d on t.schemaname=d.nspname group by d.nspname;
  -- 必须在数据库锁对应的存储系统里，至少保留30%的自由空间，日常巡检，哟啊检查存储空间的剩余容量；
  --11，查看数据分布情况：
  select gp_segment_id,count(*) from tablename group by 1;
  -- 如果数据分布不均匀，将发挥不了并行计算机的优势，严重影响性能；
  --12，查看锁信息：
  select locktype,database,c.relname,l.relation,l.transactionid,l.transaction,l.id,l.mode,
  l.granted,a.current_query from pg_locks l,pg_class c, pg_stat_activity a
  where l.relation=c.oid and l.pid =a.procpid
  order by c.relname;
  -- relname:表名
  -- locktype、mode：标识锁的类型
  --13，分区表信息
  select * from pg_partitions a 
  where a.schemaname='bib' and a.tablename='t_project_ibma1'




