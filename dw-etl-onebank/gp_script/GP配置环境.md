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
#切换数据库
\c dbname 
\help  帮助
\l  列出所有数据库
\d 列出所有表
 \d order_detail  列出表所有字段
 查看分区键和分布键
  \d+ order_detail




