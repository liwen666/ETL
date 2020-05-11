---------------------------------------------------------------
--
--     表名：sys_batch_job_log
--          数仓批次任务日志表
--
---------------------------------------------------------------  
DROP TABLE IF EXISTS sys_batch_job_log;
create table sys_batch_job_log (
    biz_date int4,      -- 业务日期
    batch_start_time timestamp,   -- 执行开始时间
    batch_end_time timestamp,   -- 执行结束时间
    execute_time int8, --执行耗时s
    table_name varchar(64), -- 业务表名称
    table_type varchar(10), -- 拉链表类型ODS_MD_DM
    step varchar(10),       -- 拉链表执行步骤DAILY_SNAP或HIS
    result varchar(15),   -- 拉链结果SUCCESSFUL_FAILED
    affected_rows int8,   -- 影响行数
    new_rows int8,  -- 新增行数
    updated_rows int8, -- 更新行数
    remark text,  -- 备注
    PRIMARY KEY(biz_date, table_name, step)
);
COMMENT ON COLUMN sys_batch_job_log.biz_date is '业务日期';
COMMENT ON COLUMN sys_batch_job_log.batch_start_time is '执行开始时间';
COMMENT ON COLUMN sys_batch_job_log.batch_end_time is '执行结束时间';
COMMENT ON COLUMN sys_batch_job_log.execute_time is '执行耗时s';
COMMENT ON COLUMN sys_batch_job_log.table_name is '业务表名称';
COMMENT ON COLUMN sys_batch_job_log.table_type is '拉链表类型ODS_MD_DM';
COMMENT ON COLUMN sys_batch_job_log.step is '拉链表执行步骤DAILY_SNAP或HIS';
COMMENT ON COLUMN sys_batch_job_log.result is '拉链结果SUCCESSFUL_FAILED';
COMMENT ON COLUMN sys_batch_job_log.affected_rows is '影响行数';
COMMENT ON COLUMN sys_batch_job_log.new_rows is '新增行数';
COMMENT ON COLUMN sys_batch_job_log.updated_rows is '更新行数';
COMMENT ON COLUMN sys_batch_job_log.remark is '备注';

COMMENT ON TABLE sys_batch_job_log IS '数仓批次任务日志表';