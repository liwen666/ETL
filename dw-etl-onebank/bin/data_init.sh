#!/bin/bash
##############################################
echo ---------------启动初始化表结构---------------
#引入配置文件
cur_dir=$(cd "$(dirname "$0")";pwd)
. ${cur_dir}/config.cfg

echo ----------------初始化ddl表结构---------------
end=`psql -d ${db_name} -h ${host_name}  -p ${db_port} -U ${user_name}   -q -f /data/app/app/etl/deploy/deploy_dll_all.sql | sed -n '3p'`
echo ----------------初始化etl脚本---------------
end=`psql -d ${db_name} -h ${host_name}  -p ${db_port} -U ${user_name}   -q -f /data/app/app/etl/deploy/deploy_etl_all.sql | sed -n '3p'`

exit 0