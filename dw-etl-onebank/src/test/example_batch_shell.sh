#!/bin/bash
############################################################################
#本地数据入仓校验脚本
#1 检查OK文件中的数据日期和当前的etl日期是否一致，不一致则轮询5分钟检查一次
#2 循环对各个dfa数据文件进行校验
#2.1 检查OK文件中的记录数和外表中的记录数是否一致
#2.2 检查OK文件中的汇总字段值和外表中的汇总字段值是否一样
#2.3 检查数据文件中的字段个数和外表中的字段个数是否一样
#2.1-2.3中任何一个校验不一致则报错退出
#3 将多个dfa数据文件拷贝到外表对应目录
#4 插入报批控制表
#调用方法：sh local_file_check_dfa.sh 20190529 ARS O_ARS_ECR_LOAN_ADVPAY
############################################################################

cur_dir=$(cd "$(dirname "$0")";pwd)
conf_dir=$(dirname $cur_dir)/conf
. ${conf_dir}/PUB.CFG

etl_date=$1
source_system=$2
odm_tab_name=$3

edw_etlpath=${etlpath}
shell_path=${edw_etlpath}bin/
edw_dbname=${edwname}
odm_dbname=${odmname}
dsi_dbname=${dsiname}
user_name=${username}
user_pass=`${shell_path}decrypt.sh ${userpass}`
host_name=${hostname}
jdbc_conn_str=jdbc:hive2://${host_name}:10000/${edw_dbname}
src_tab_name=`echo ${odm_tab_name#*"${source_system}"_}`
src_tab_path=${edw_etlpath}data/${etl_date}/${source_system}/       
odm_tab_path=EDW/ODM/${source_system}/${src_tab_name}/
check_path=${src_tab_path}
exit_code=0
bak_path=EDW/BAK/${etl_date}/${source_system}/
log_path=${edw_etlpath}log/${etl_date}/${source_system}/

new_etl_date=`${shell_path}get_date.sh ${etl_date}`
echo "new_etl_date:${new_etl_date}"

#认证
#kinit -kt ${edw_etlpath}keytab/${user_name}.keytab ${user_name}
kinit -c /data/script/${user_name}_krb5 -kt ${edw_etlpath}keytab/${user_name}.keytab ${user_name}
export KRB5CCNAME=/data/script/${user_name}_krb5

cd ${shell_path}

if [ ! -d ${log_path} ]; then
  mkdir -p ${log_path}
fi

hadoop fs -test -e ${bak_path}
if [ $? = 1 ]; then
  hadoop fs -mkdir -p ${bak_path}
fi

shlog()
{
	local line_no msg 
	line_no=$1
	msg=$2
	echo "[file_check_dfa.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg ">> ${log_path}${odm_tab_name}.log
	echo "[file_check_dfa.sh][$line_no]["`date "+%Y%m%d %H:%M:%S"`"] $msg "
}

fun_file_check(){
  local src_file_name
  src_file_name=$1
  
  shlog $LINENO "进入fun_file_check,开始校验${src_file_name}数据文件和OK标志文件是否一致"
  #外表中的行数
  odm_line_count=`beeline -u "${jdbc_conn_str}" -n ${user_name} -p ${user_pass} --silent=true --outputformat=vertical -e "select count(1) from ${odm_dbname}.${odm_tab_name}" | awk -F"  " '{print $2}'`
  #ok标志文件中的行数
  file_line_count=`cat ${check_path}${src_file_name}.OK | awk -F"" '{print $3}'`
  #ok标志文件中提供的汇总字段名
  file_column_name=`cat ${check_path}${src_file_name}.OK | awk -F"" '{print $4}'`
  #标志文件中提供的汇总字段的值
  file_column_val=`cat ${check_path}${src_file_name}.OK | awk -F"" '{print $5}'`
   
  shlog $LINENO "${src_file_name}.OK标志文件中的行数为：${file_line_count}，外表中计算的行数为：${odm_line_count}"
  
  if [ ${file_line_count} -ne 0 ]; then
    #1判断外表中的行数和ok标志文件中的行数是否一致
    [ "${odm_line_count}" = "${file_line_count}" ] || return 1
  
    if [ ${file_column_name} != "NULL" ]; then
      #外表中的相应字段的合计
      odm_column_val=`beeline -u "${jdbc_conn_str}" -n ${user_name} -p ${user_pass} --silent=true --outputformat=vertical -e "select sum(${file_column_name}) from ${odm_dbname}.${odm_tab_name}" | awk -F"  " '{print $2}'`
      shlog $LINENO "${src_file_name}.OK标志文件中的汇总值为：${file_column_val}，外表中计算的汇总值为：${odm_column_val}"
      
      #2判断外表中的汇总值和ok标志文件中的汇总值是否一致
      [ "${odm_column_val}" = "${file_column_val}" ] || return 2
    fi

    #从TXT文件中计算字段个数
    line=`cat ${src_tab_path}${src_file_name}.TXT | head -1`
    str_num=`echo ${line} | tr -cd "" | wc -c`
    file_col_num=`expr ${str_num} + 1`
  
    #从数据库中查询外表的字段个数
    echo "${odm_dbname}.${odm_tab_name}"
    query_sql="select field_num from ${edw_dbname}.edw_sm_history where table_name='${odm_dbname}.${odm_tab_name}'"
    echo "query_sql:"${query_sql}
    odm_col_num=`beeline -u "${jdbc_conn_str}" -n ${user_name} -p ${user_pass} --silent=true --outputformat=vertical -e "${query_sql}" | awk -F"  " '{print $2}'`
    
    shlog $LINENO "TXT文件中的字段数为：${file_col_num}，外表中的字段数为：${odm_col_num}"
    
    #3检查TXT文件中的字段个数和外表中的字段个数是否一致
    [ "${file_col_num}" = "${odm_col_num}" ] || return 3
  else
    #1判断外表中的行数和ok标志文件中的行数是否一致
    [ "${odm_line_count}" = "${file_line_count}" ] || return 1
  
  fi
   
  #完全合法,正常退出
  return 0
}

shlog $LINENO "----------------${etl_date}日${odm_tab_name}校验开始----------------"

#1、拷贝ok文件
#hadoop fs -cp $src_tab_path${src_tab_name}.OK ${check_path}

#计算该表在配置文件中的条数
tab_count=`grep ${odm_tab_name}" " ${edw_etlpath}conf/TAB.CFG | wc -l`


if [ ${tab_count} -eq 0 ]; then
  shlog $LINENO "配置文件TAB.CFG中不存在${odm_tab_name}表,请检查......"
  exit 1
elif [ ${tab_count} -gt 1 ]; then
  shlog $LINENO "配置文件TAB.CFG中有多条${odm_tab_name}记录,请检查......"
  exit 1
else

  #每张表对应多个数据文件，需要循环多次对每个数据文件和对应的OK文件进行校验，如果有一个数据文件校验不通过则跳出循环，报错
  tab_line=`grep ${odm_tab_name}" " ${edw_etlpath}conf/TAB.CFG`
  dfa_code=`echo ${tab_line} | awk -F" " '{print $2}'`
  
  #判断该表是否分dfa
  if [ ${dfa_code}"x" = "x" ]; then
    shlog $LINENO "首先删除备份目录${bak_path}下的数据文件${src_tab_name}"
    hadoop fs -test -e ${bak_path}${src_file_name}.TXT
      if [ $? = 0 ]; then
      hadoop fs -rm ${bak_path}${src_file_name}.TXT
      fi
      
      hadoop fs -test -e ${bak_path}${src_file_name}.OK
      if [ $? = 0 ]; then
      hadoop fs -rm ${bak_path}${src_file_name}.OK
      fi
  else
    shlog $LINENO "首先删除备份目录${bak_path}下的数据文件${src_tab_name}-*"
    hadoop fs -rm ${bak_path}${src_tab_name}'-'*
  fi

  dcn_count=`echo "${tab_line}" | tr -cd " " | wc -c`
  count=1

  #for src_file_name in `grep ^${src_tab_name}\- ${source_system}.CFG`
  while(( ${count}<=${dcn_count} ))
  do

    echo $count
    let "count++"
    echo $count
    echo ${tab_line}
    dcn_name=`echo ${tab_line} | awk -F" " '{print $v}' v=$count`
    echo "dcn_name:"${dcn_name}
    if [ ${dfa_code}"x" = "x" ]; then #数据文件不带dfa编号
      src_file_name=${src_tab_name}
    else
      src_file_name=${src_tab_name}'-'${dcn_name}
    fi
    echo ${src_file_name}
shlog $LINENO "----------开始从文件服务器下载数据文件和OK文件到本地----------"
    sh download_file.sh ${etlpath} /${source_system}/${etl_date}/${src_file_name}.TXT ${src_tab_path}
    sh download_file.sh ${etlpath} /${source_system}/${etl_date}/${src_file_name}.OK ${src_tab_path}
shlog $LINENO "----------结束从文件服务器下载数据文件和OK文件到本地----------"   
    
    shlog $LINENO "----------开始校验${src_file_name}文件----------"
    
    test -e ${check_path}${src_file_name}.OK
    #判断ok标志文件是否存在,不存在轮询判断
    while [ $? = 1 ]
    do
      shlog $LINENO "${src_file_name}.OK标志文件不存在，开始轮询"
      sleep 300
      test -e ${check_path}${src_file_name}.OK
    done
    
    #截取ok文件中的数据日期
    file_date=`cat ${check_path}${src_file_name}.OK | awk -F"" '{print $1}'`
    
    #开始轮询，每5分钟一次  把ok文件中的日期和当前数据日期比对
    while [ ${new_etl_date} != ${file_date} ]
    do
    shlog $LINENO "${etl_date}日的数据文件还没到，开始轮询"
    sleep 300
    #hadoop fs -cp $src_tab_path${src_file_name}.OK ${check_path}
    file_date=`cat ${check_path}${src_file_name}.OK | awk -F"" '{print $1}'`
    done
    
    #将外表对应的目录的数据文件清空
    hadoop fs -rm ${odm_tab_path}*
    
    #ok标志文件中的日期和当前数据日期一致，则拷贝数据文件到外表相应的目录下
    hadoop fs -put ${src_tab_path}${src_file_name}.TXT ${odm_tab_path}
    
    #判断备份目录对应的TXT和OK文件是否存在，如果存在，则先删除，再拷贝
    hadoop fs -test -e ${bak_path}${src_file_name}.TXT
    if [ $? = 0 ]; then
    shlog $LINENO "备份目录${bak_path}下有${src_file_name}.TXT文件，先删除"
    hadoop fs -rm ${bak_path}${src_file_name}.TXT
    fi
    
    hadoop fs -test -e ${bak_path}${src_file_name}.OK
    if [ $? = 0 ]; then
    shlog $LINENO "备份目录${bak_path}下有${src_file_name}.OK文件，先删除"
    hadoop fs -rm ${bak_path}${src_file_name}.OK
    fi
    
    hadoop fs -put ${src_tab_path}${src_file_name}.TXT ${bak_path}
    hadoop fs -put ${src_tab_path}${src_file_name}.OK ${bak_path}

    fun_file_check ${src_file_name}
    if [ $? -eq 0 ]; then
      shlog $LINENO "${etl_date}日${src_file_name}标志文件和外表校验一致"
      exit_code=0
    else  
      shlog $LINENO "${etl_date}日${src_file_name}标志文件和外表校验不一致"
      exit_code=1
      break
    fi
  done
fi

echo "exit_code:${exit_code}"
if [ ${exit_code} = 0 ]; then
  if [ ${dfa_code}"x" != "x" ]; then
    hadoop fs -rm ${odm_tab_path}*
    hadoop fs -cp ${bak_path}${src_tab_name}'-'*.TXT ${odm_tab_path}
    if [ $? -ne 0 ]; then
      shlog $LINENO "将各dfa的TXT数据文件从备份目录拷贝到外表对应目录失败..."
      exit 1
    else
      shlog $LINENO "成功将各dfa的TXT数据文件从备份目录拷贝到外表对应目录..."
    fi
  fi
   # if [ ${odm_tab_name} = O_CLS_KGLB_KMJZLS ]; then
    	#echo "${odm_tab_name} = O_CLS_KGLB_KMJZLS"
      #hadoop fs -rm EDW/ODM/CLS/KGLB_KMJZLS/XW_KGLB_KMJZLS-*.TXT
    #  hadoop fs -cp EDW/ODM/CLS/XW_KGLB_KMJZLS/XW_KGLB_KMJZLS-*.TXT EDW/ODM/CLS/KGLB_KMJZLS/
    # if [ $? -ne 0 ]; then
       #  shlog $LINENO "将XW_KGLB_KMJZLS表数据拷贝到EDW/ODM/CLS/KGLB_KMJZLS/失败..."
      #   exit 1
     # else
     #    shlog $LINENO "将XW_KGLB_KMJZLS表数据拷贝到EDW/ODM/CLS/KGLB_KMJZLS/成功..."
    # fi
   #fi
  
  #供数控制表
  beeline -u "${jdbc_conn_str}" -n ${user_name} -p ${user_pass} --silent=true --outputformat=vertical -e "begin pkg_dw_util.sp_dsi_ctrl(tdh_todate('${etl_date}'), '${odm_tab_name}') end"
  if [ $? -ne 0 ]; then
    shlog $LINENO "插入控制表${dsi_dbname}.DSI_SM_CTRL失败..."
    exit 1
  else
    shlog $LINENO "插入控制表${dsi_dbname}.DSI_SM_CTRL成功..."
  fi
  
  shlog $LINENO "----------------${odm_tab_name}校验通过----------------"
  exit 0
else
  shlog $LINENO "----------------${odm_tab_name}校验失败----------------"
  exit 1
fi
