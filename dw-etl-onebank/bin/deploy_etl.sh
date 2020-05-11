#!/usr/bin/env bash
  
if [ ! -d "../deploy" ]
then
    echo "Create Directory: deploy..."
     mkdir -p ../deploy
fi

timestamp=`date "+%Y%m%d%H%M%S"`

if [ "$1"  -eq 0 ]; then
 echo ------------合并etl添加时间戳---------------------
 deploy_file="../deploy/deploy_etl_$timestamp.sql"
else
echo ------------ 合并etl使用默认文件名---------------------
  deploy_file="../deploy/deploy_etl_all.sql"
fi

find ../src/etl/helpers -name "*.sql" |
while read file_name;
do
    echo "Deploy ${file_name} ..."
    cat "$file_name" >> $deploy_file
    echo ";" >> $deploy_file
done


find ../src/etl/ods -name "*.sql" |
while read file_name;
do
    echo "Deploy ${file_name} ..."
    cat "$file_name" >> $deploy_file
    echo ";" >> $deploy_file
done

find ../src/etl/sys -name "*.sql" |
while read file_name;
do
    echo "Deploy ${file_name} ..."
    cat "$file_name" >> $deploy_file
    echo ";" >> $deploy_file
done
