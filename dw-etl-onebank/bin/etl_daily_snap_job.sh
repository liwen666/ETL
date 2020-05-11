#!/bin/bash
############################################################################
# 拉起实时数据仓库日终快照任务
#
# 传入参数：etl_date 
#
# 描述：
# 1. 检查ods_anytxn_boa_exec_sign表中当日txn日终跑批是否完成，没有完成则轮循5分钟检查一次
# 2. 启动日终快照存储过程
#
# 调用方法：sh etl_daily_snap_job.sh 20190529
############################################################################

#引入配置文件
cur_dir=$(cd "$(dirname "$0")";pwd)
. ${cur_dir}/config.cfg
log_path=${log_path}/

#业务日期
etl_date=$1
sleep_interval=${sleep_interval}
job_delay_time=${job_delay_time}

#数据库连接信息
host_name=${host_name}
user_name=${user_name}
user_pass=`${cur_dir}/decrypt.sh ${user_pass}`
db_name=${db_name}
db_port=${db_port}

#创建日志目录
if [ ! -d ${log_path} ]; then
  mkdir -p ${log_path}
fi

#日志函数
shlog() {
    local line_no msg 
    line_no=$1
    msg=$2
  
    echo "[etl_daily_snap_job.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg " >> ${log_path}etl_daily_snap_job.log
    echo "[etl_daily_snap_job.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg "
}

#检查日志跑批是否完成，未完成则每5分钟轮询一次
txn_batch_status=`psql -d ${db_name} -h ${host_name} -p ${db_port} -U ${user_name} -q -c "SELECT check_txn_batch_status(${etl_date});" | sed -n '3p'`
while [ ${txn_batch_status} = 0 ]
do
	shlog $LINENO "TXN日终跑批还未完成"
	sleep ${sleep_interval}
	
	txn_batch_status=`psql -d ${db_name} -h ${host_name} -p ${db_port} -U ${user_name} -q -c "SELECT check_txn_batch_status(${etl_date});" | sed -n '3p'`
done

	
#检查或者主批完成时间, 等待60分钟后启动任务
dw_job_can_start=`psql -d ${db_name} -h ${host_name} -p ${db_port} -U ${user_name} -q -c "SELECT check_dw_job_can_start(${etl_date}, ${job_delay_time});" | sed -n '3p'`
while [ ${dw_job_can_start} = 0 ]
do
	shlog $LINENO "等待时间未到"
	echo ${dw_job_can_start}
	
	sleep ${sleep_interval}
	dw_job_can_start=`psql -d ${db_name} -h ${host_name} -p ${db_port} -U ${user_name} -q -c "SELECT check_dw_job_can_start(${etl_date}, ${job_delay_time});" | sed -n '3p'`
done

#运行日终快照加工任务
res_etl_ods_snap=`psql -d ${db_name} -h ${host_name} -p ${db_port} -U ${user_name} -q -c "SET client_min_messages=WARNING;SELECT etl_ods_create_daily_snap_table(${etl_date});" | sed -n '3p'`
if [[ $res_etl_ods_snap == *ERROR* ]]; then
    shlog $LINENO "ODS日终快照加工失败：${res_etl_ods_snap}"
    
    exit -1
fi

#运行日终拉链表加工任务
res_etl_ods_zip=`psql -d ${db_name} -h ${host_name} -p ${db_port} -U ${user_name} -q -c "SET client_min_messages=WARNING;SELECT etl_ods_create_zip_table(${etl_date});" | sed -n '3p'`
if [[ $res_etl_ods_zip == *ERROR* ]]; then
    shlog $LINENO "ODS日终拉链表加工失败：${res_etl_ods_zip}"
    
    exit -1
fi

exit 0