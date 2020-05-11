---------------------------------------------------------------
--
--     表名：sys_alter_threshold
--     描述：监控告警阈值参数表
--
---------------------------------------------------------------  
DROP TABLE IF EXISTS sys_alter_threshold;
CREATE TABLE "sys_alter_threshold" (
  "threshold_id" varchar(32) NOT NULL,
  "job_id" varchar(64),
  "name" varchar(64),
  "value" int4,
  "mobile" text,
  "msg_tpl" text,
  "create_time" timestamp(6) DEFAULT now(),
  "last_update_time" timestamp(6),
  PRIMARY KEY ("threshold_id")
);

COMMENT ON COLUMN "sys_alter_threshold"."threshold_id" IS '阈值ID';
COMMENT ON COLUMN "sys_alter_threshold"."job_id" IS '任务ID';
COMMENT ON COLUMN "sys_alter_threshold"."name" IS '阈值名称';
COMMENT ON COLUMN "sys_alter_threshold"."value" IS '阈值';
COMMENT ON COLUMN "sys_alter_threshold"."mobile" IS '告警手机号';
COMMENT ON COLUMN "sys_alter_threshold"."msg_tpl" IS '短信模板id';
COMMENT ON COLUMN "sys_alter_threshold"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_alter_threshold"."last_update_time" IS '最后更新时间';

comment on table sys_alter_threshold is '监控告警阈值参数表';