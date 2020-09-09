
#备份
pg_dump -U jrxany -h 39.0.158.106 -d anyest3_financial_cloud_101 -f /data/est/gp/anyest3_financial_cloud_101.sql
pg_dump -h 112.***.***.*** -p 4321 -U carnot -f M2_cc.0914.sql carnot 
#恢复
psql -h 220.194.***.*** -p 2343（端口号） -U carnot（数据库用户名） -f M2_cc.0914.sql carnotnew(库名)
end=`psql -d ${db_name} -h ${host_name}  -p ${db_port} -U ${user_name}   -q -f /data/app/app/etl/deploy/deploy_dll_all.sql | sed -n '3p'`

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
  
  