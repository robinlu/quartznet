-- this script is for Firebird
-- Firebird DB script submitted by Leonardo Alves and tweaked by siyu wu

DROP TABLE QRTZ_FIRED_TRIGGERS;
DROP TABLE QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE QRTZ_SCHEDULER_STATE;
DROP TABLE QRTZ_LOCKS;
DROP TABLE QRTZ_SIMPLE_TRIGGERS;
DROP TABLE QRTZ_SIMPROP_TRIGGERS;
DROP TABLE QRTZ_CRON_TRIGGERS;
DROP TABLE QRTZ_BLOB_TRIGGERS;
DROP TABLE QRTZ_TRIGGERS;
DROP TABLE QRTZ_JOB_DETAILS;
DROP TABLE QRTZ_CALENDARS;


CREATE TABLE QRTZ_JOB_DETAILS (
    SCHED_NAME         VARCHAR(120) NOT NULL,
    JOB_NAME           VARCHAR(150) NOT NULL,
    JOB_GROUP          VARCHAR(150) NOT NULL,
    DESCRIPTION        VARCHAR(250) default NULL,
    JOB_CLASS_NAME     VARCHAR(250) NOT NULL,
    IS_DURABLE         SMALLINT NOT NULL,
    IS_NONCONCURRENT   SMALLINT NOT NULL,
    IS_UPDATE_DATA     SMALLINT NOT NULL,
    REQUESTS_RECOVERY  SMALLINT NOT NULL,
    JOB_DATA           BLOB DEFAULT NULL,
    CONSTRAINT PK_QRTZ_JOB_DETAILS PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_TRIGGERS (
    SCHED_NAME      VARCHAR(120) NOT NULL,
    TRIGGER_NAME    VARCHAR(150) NOT NULL,
    TRIGGER_GROUP   VARCHAR(150) NOT NULL,
    JOB_NAME        VARCHAR(150) NOT NULL,
    JOB_GROUP       VARCHAR(150) NOT NULL,
    DESCRIPTION     VARCHAR(250) DEFAULT NULL,
    NEXT_FIRE_TIME  BIGINT DEFAULT NULL,
    PREV_FIRE_TIME  BIGINT DEFAULT NULL,
    PRIORITY        INTEGER DEFAULT NULL,
    TRIGGER_STATE   VARCHAR(16) NOT NULL,
    TRIGGER_TYPE    VARCHAR(8) NOT NULL,
    START_TIME      BIGINT NOT NULL,
    END_TIME        BIGINT DEFAULT NULL,
    CALENDAR_NAME   VARCHAR(200) DEFAULT NULL,
    MISFIRE_INSTR   SMALLINT DEFAULT NULL,
    JOB_DATA        BLOB DEFAULT NULL,
    CONSTRAINT PK_QRTZ_TRIGGERS PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    CONSTRAINT FK_QRTZ_TRIGGERS_1 FOREIGN KEY (SCHED_NAME, JOB_NAME, JOB_GROUP)
    REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME, JOB_NAME, JOB_GROUP)
);

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
    SCHED_NAME       VARCHAR(120) NOT NULL,
    TRIGGER_NAME     VARCHAR(150) NOT NULL,
    TRIGGER_GROUP    VARCHAR(150) NOT NULL,
    REPEAT_COUNT     BIGINT NOT NULL,
    REPEAT_INTERVAL  BIGINT NOT NULL,
    TIMES_TRIGGERED  BIGINT NOT NULL,
    CONSTRAINT PK_QRTZ_SIMPLE_TRIGGERS PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    CONSTRAINT FK_QRTZ_SIMPLE_TRIGGERS_1 FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CRON_TRIGGERS (
    SCHED_NAME       VARCHAR(120) NOT NULL,
    TRIGGER_NAME     VARCHAR(150) NOT NULL,
    TRIGGER_GROUP    VARCHAR(150) NOT NULL,
    CRON_EXPRESSION  VARCHAR(250) NOT NULL,
    TIME_ZONE_ID     VARCHAR(80),
    CONSTRAINT PK_QRTZ_CRON_TRIGGERS PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    CONSTRAINT FK_QRTZ_CRON_TRIGGERS_1 FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_SIMPROP_TRIGGERS (
    SCHED_NAME     VARCHAR(120) NOT NULL,
    TRIGGER_NAME   VARCHAR(150) NOT NULL,
    TRIGGER_GROUP  VARCHAR(150) NOT NULL,
    STR_PROP_1     VARCHAR(512) DEFAULT NULL,
    STR_PROP_2     VARCHAR(512) DEFAULT NULL,
    STR_PROP_3     VARCHAR(512) DEFAULT NULL,
    INT_PROP_1     INTEGER DEFAULT NULL,
    INT_PROP_2     INTEGER DEFAULT NULL,
    LONG_PROP_1    BIGINT DEFAULT NULL,
    LONG_PROP_2    BIGINT DEFAULT NULL,
    DEC_PROP_1     NUMERIC(9,0) DEFAULT  NULL,
    DEC_PROP_2     NUMERIC(9,0) DEFAULT NULL,
    BOOL_PROP_1    SMALLINT DEFAULT NULL,
    BOOL_PROP_2    SMALLINT DEFAULT NULL,
    TIME_ZONE_ID   VARCHAR(80) DEFAULT NULL,
    CONSTRAINT PK_QRTZ_SIMPROP_TRIGGERS PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    CONSTRAINT FK_QRTZ_SIMPROP_TRIGGERS_1 FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_BLOB_TRIGGERS (
    SCHED_NAME     VARCHAR(120) NOT NULL,
    TRIGGER_NAME   VARCHAR(150) NOT NULL,
    TRIGGER_GROUP  VARCHAR(150) NOT NULL,
    BLOB_DATA      BLOB DEFAULT NULL,
    CONSTRAINT PK_QRTZ_BLOB_TRIGGERS PRIMARY KEY (SCHED_NAME, TRIGGER_NAME,TRIGGER_GROUP),
    CONSTRAINT FK_QRTZ_BLOB_TRIGGERS_1 FOREIGN KEY (SCHED_NAME, TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME, TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CALENDARS (
    SCHED_NAME     VARCHAR(120) NOT NULL,
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR       BLOB NOT NULL,
    CONSTRAINT PK_QRTZ_CALENDARS PRIMARY KEY (SCHED_NAME, CALENDAR_NAME)
);

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
    SCHED_NAME     VARCHAR(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR(150) NOT NULL,
    CONSTRAINT PK_QRTZ_PAUSED_TRIGGER_GRPS PRIMARY KEY (SCHED_NAME, TRIGGER_GROUP)
);

CREATE TABLE QRTZ_FIRED_TRIGGERS (
    SCHED_NAME         VARCHAR(120) NOT NULL,
    ENTRY_ID           VARCHAR(140) NOT NULL,
    TRIGGER_NAME       VARCHAR(150) NOT NULL,
    TRIGGER_GROUP      VARCHAR(150) NOT NULL,
    INSTANCE_NAME      VARCHAR(200) NOT NULL,
    FIRED_TIME         BIGINT NOT NULL,
    SCHED_TIME         BIGINT NOT NULL,
    PRIORITY           INTEGER NOT NULL,
    STATE              VARCHAR(16) NOT NULL,
    JOB_NAME           VARCHAR(150) DEFAULT NULL,
    JOB_GROUP          VARCHAR(150) DEFAULT NULL,
    IS_NONCONCURRENT   SMALLINT NOT NULL,
    REQUESTS_RECOVERY  SMALLINT DEFAULT NULL,
    CONSTRAINT PK_QRTZ_FIRED_TRIGGERS PRIMARY KEY (SCHED_NAME, ENTRY_ID)
);

CREATE TABLE QRTZ_SCHEDULER_STATE (
    SCHED_NAME         VARCHAR(120) NOT NULL,
    INSTANCE_NAME      VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME  BIGINT NOT NULL,
    CHECKIN_INTERVAL   BIGINT NOT NULL,
    CONSTRAINT PK_QRTZ_SCHEDULER_STATE PRIMARY KEY (SCHED_NAME, INSTANCE_NAME)
);

CREATE TABLE QRTZ_LOCKS (
    SCHED_NAME  VARCHAR(120) NOT NULL,
    LOCK_NAME   VARCHAR(40) NOT NULL,
    CONSTRAINT PK_QRTZ_LOCKS PRIMARY KEY (SCHED_NAME, LOCK_NAME)
);

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);

COMMIT;
