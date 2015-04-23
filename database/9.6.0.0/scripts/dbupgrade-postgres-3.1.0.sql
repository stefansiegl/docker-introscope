-- upgrade database from 3.1.0 to 3.2.0

-- add index (see bug 115)
create index ts_users_UserDefGroupIndex on ts_users (ts_userdef_group_id);

-- change impact settings icons
update ts_impact_settings set ts_bitmap='i_moderate.gif' where ts_id=1;
update ts_impact_settings set ts_bitmap='i_severe.gif' where ts_id=2;
update ts_impact_settings set ts_bitmap='i_critical.gif' where ts_id=3;

-- 2 phase login
create table ts_interim_session_id_parameters (
    ts_app_id int8 not null,
    ts_type varchar(200) not null,
    ts_name varchar(200) not null,
    ts_id_type int2 not null,
    version_info int8 not null,
    ts_offset int4 not null,
    ts_length int4 not null,
    ts_soft_delete bool not null,
    primary key (ts_app_id, ts_type, ts_name, ts_id_type)
);

alter table ts_user_sessions_map add column ts_interim_session_id varchar(2000) not null default '';
alter table ts_user_sessions_map drop constraint ts_user_sessions_map_pkey;
alter table ts_user_sessions_map add constraint ts_user_sessions_map_pkey primary key (ts_app_id, ts_session_id, ts_interim_session_id);

-- scheduled reports items
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1015, 1, 'reports.subject', 'Automatically Generated CEM Report', 'text used as Subject: for scheduled reports', 'Automatically Generated CEM Report', false);

-- scheduled reports tables
create table ts_report_def_param_values
(
  ts_id int8 not null unique,
  version_info int8 not null,
  ts_param_key_id int8 not null,
  ts_report_def_id int8 not null,
  ts_value varchar(10485760),
  ts_soft_delete bool not null,
  primary key (ts_id)
);
create index ts_report_def_param_value_ParamKeyIndex on ts_report_def_param_values (ts_param_key_id);
create index ts_report_def_param_value_ReportDefIndex on ts_report_def_param_values (ts_report_def_id);
create table ts_report_defs
(
  ts_id int8 not null unique,
  version_info int8 not null,
  ts_name varchar(200),
  ts_report_type_id int8 not null,
  ts_creation_date timestamp not null,
  ts_soft_delete bool not null,
  primary key (ts_id)
);
create table ts_report_param_keys
(
  ts_id int8 not null unique,
  version_info int8 not null,
  ts_name varchar(200) not null,
  ts_query_string_name varchar(200),
  ts_value_type varchar(200) not null,
  ts_default_value varchar(200),
  ts_soft_delete bool not null,
  primary key (ts_id)
);
create table ts_report_type_param_values
(
  ts_id int8 not null unique,
  version_info int8 not null,
  ts_param_key_id int8 not null,
  ts_report_type_id int8 not null,
  ts_value varchar(10485760),
  ts_soft_delete bool not null,
  primary key (ts_id)
);
create index ts_report_type_param_value_ReportTypeIndex on ts_report_type_param_values (ts_report_type_id);
create index ts_report_type_param_value_ParamKeyIndex on ts_report_type_param_values (ts_param_key_id);
create table ts_report_types
(
  ts_id int8 not null unique,
  version_info int8 not null,
  ts_name varchar(200) not null,
  ts_soft_delete bool not null,
  primary key (ts_id)
);
alter table ts_report_def_param_values add constraint FKDE7570F927121B26 foreign key (ts_param_key_id) references ts_report_param_keys on delete cascade;
alter table ts_report_def_param_values add constraint FKDE7570F9A0746AFE foreign key (ts_report_def_id) references ts_report_defs on delete cascade;
alter table ts_report_defs add constraint FK498E2779DF34A896 foreign key (ts_report_type_id) references ts_report_types;
alter table ts_report_type_param_values add constraint FK78097D6EDF34A896 foreign key (ts_report_type_id) references ts_report_types on delete cascade;
alter table ts_report_type_param_values add constraint FK78097D6E27121B26 foreign key (ts_param_key_id) references ts_report_param_keys;

-- insert the report types
insert into ts_report_types values (1, 1, 'BizValueReport', false);
insert into ts_report_types values (2, 1, 'ImpactLeadersReport', false);
insert into ts_report_types values (3, 1, 'TranPerformanceReport', false);
insert into ts_report_types values (4, 1, 'TranQualityReport', false);
insert into ts_report_types values (5, 1, 'TranSlaPerformanceReport', false);
insert into ts_report_types values (6, 1, 'TranSlaQualityReport', false);
insert into ts_report_types values (7, 1, 'TranTrendPerformanceReport', false);
insert into ts_report_types values (8, 1, 'TranTrendQualityReport', false);
insert into ts_report_types values (9, 1, 'UserPerformanceReport', false);
insert into ts_report_types values (10, 1, 'UserQualityReport', false);
insert into ts_report_types values (11, 1, 'UserSlaPerformanceReport', false);
insert into ts_report_types values (12, 1, 'UserSlaQualityReport', false);
insert into ts_report_types values (13, 1, 'UserTrendPerformanceReport', false);
insert into ts_report_types values (14, 1, 'UserTrendQualityReport', false);

-- insert the report param keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (1,'url','','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (2,'owner','','com.timestock.tess.data.objects.Operator','',FALSE, 1);
-- email info keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (3,'fromName','','java.lang.String','Wily CEM Reports Engine',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (4,'fromAddress','','java.lang.String','cem-support@wilytech.com',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (5,'to','','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (6,'subject','','java.lang.String','Wily CEM Report via email',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (7,'message','','java.lang.String','This email has been sent to you by the Wily CEM Reports Engine.\nThe report is attached in PDF format.\n',FALSE, 1);
-- trigger info keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (8,'frequency','','java.lang.Integer','0',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (9,'dayOfWeek','','java.lang.Integer','1',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (10,'dayOfMonth','','java.lang.Integer','1',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (11,'hour','','java.lang.Integer','3',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (12,'minute','','java.lang.Integer','30',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (13,'second','','java.lang.Integer','0',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (14,'status','','java.lang.Integer','',FALSE, 1);
-- report filter keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (15,'userGroup','UserGroupId','com.timestock.tess.data.objects.UserGroup','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (16,'user','UserId','com.timestock.tess.data.objects.User','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (17,'tranSetGroup','TranSetGroupId','com.timestock.tess.data.objects.TranSetGroup','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (18,'tranSetDef','TranSetId','com.timestock.tess.data.objects.TranSetDef','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (19,'tranUnitDef','TranUnitId','com.timestock.tess.data.objects.TranUnitDef','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (20,'timeFrame','Timeframe','com.timestock.tess.util.TimeFrame','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (21,'currentTimeFrame','CurrentTimeframe','com.timestock.tess.util.TimeFrame','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (22,'previousTimeFrame','PreviousTimeframe','com.timestock.tess.util.TimeFrame','',FALSE, 1);

-- report type param values
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (1,1,1,1,'roiReportPerformance.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (2,1,17,1,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (3,1,20,1,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (4,1,1,2,'impactLeadersReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (5,1,20,2,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (6,1,1,3,'tranSetGroupPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (7,1,17,3,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (8,1,20,3,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (9,1,1,4,'tranSetGroupQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (10,1,17,4,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (11,1,20,4,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (12,1,1,5,'tranSlaPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (13,1,15,5,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (14,1,17,5,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (15,1,20,5,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (16,1,1,6,'tranSlaQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (17,1,15,6,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (18,1,17,6,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (19,1,20,6,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (20,1,1,7,'tranTrendPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (21,1,15,7,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (22,1,17,7,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (23,1,21,7,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (24,1,22,7,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (25,1,1,8,'tranTrendQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (26,1,15,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (27,1,17,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (28,1,21,8,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (29,1,22,8,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (30,1,1,9,'userGroupPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (31,1,15,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (32,1,17,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (33,1,18,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (34,1,20,9,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (35,1,1,10,'userGroupQualityReport',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (36,1,15,10,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (37,1,17,10,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (38,1,18,10,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (39,1,20,10,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (40,1,1,11,'userSlaPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (41,1,15,11,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (42,1,17,11,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (43,1,18,11,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (44,1,20,11,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (45,1,1,12,'userSlaQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (46,1,17,12,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (47,1,15,12,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (48,1,18,12,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (49,1,20,12,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (50,1,1,13,'userTrendPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (51,1,17,13,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (52,1,15,13,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (53,1,18,13,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (54,1,21,13,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (55,1,22,13,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (56,1,1,14,'userTrendQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (57,1,15,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (58,1,18,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (59,1,17,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (60,1,21,14,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (61,1,22,14,'Yesterday',false);

-- insert license key settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1014, 1, 'license.lastSuccessfulCheck', '', 'Last successful license check', '', false);

-- rename ts_app_types -> ts_app_auth_types
alter table ts_apps drop constraint FKC1F8AC328CD64687;
alter table ts_apps rename column ts_apptype_id to ts_authtype_id;
alter table ts_app_types rename to ts_app_auth_types;
alter table ts_apps 
    add constraint FKC1F8AC328CD64687 
    foreign key (ts_authtype_id) 
    references ts_app_auth_types;

-- name change Netegrity -> eTrust
update ts_app_auth_types set ts_name='eTrust SiteMinder' where ts_id=2;

-- create application type table (Siebel, ...)
create table ts_app_types (
    ts_id int8 not null unique,
    version_info int8 not null,
    ts_name varchar(200) not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(1, 'Unknown', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(2, 'Generic', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(3, 'Siebel', false, 1);

-- add app type column to ts_apps
alter table ts_apps add column ts_apptype_id int8 not null default 2;
alter table ts_apps 
    add constraint FKC1F8AC328CD64688
    foreign key (ts_apptype_id) 
    references ts_app_types;

-- add app type column to user mapping tables
alter table ts_user_logins_map add column ts_apptype_id int8 not null default 1;
alter table ts_user_sessions_map add column ts_apptype_id int8 not null default 1;
alter table ts_user_logins_map 
    add constraint FKEC04E0FB92916D71 
    foreign key (ts_apptype_id) 
    references ts_app_types on delete cascade;
alter table ts_user_sessions_map 
    add constraint FKE04844EE92916D71 
    foreign key (ts_apptype_id) 
    references ts_app_types on delete cascade;

-- add new security tables
create table ts_operators
(
  ts_id int8 not null,
  version_info int8 not null,
  ts_username varchar(200) not null,
  ts_password varchar(200) not null,
  ts_first_name varchar(200) not null,
  ts_last_name varchar(200) not null,
  ts_email_address varchar(200) not null,
  ts_phone_number varchar(200),
  ts_creation_time timestamptz,
  ts_active bool not null,
  ts_soft_delete bool not null,
  primary key (ts_id)
);
create table ts_operator_role_map
(
  ts_operator_id int8 not null,
  ts_role_id int8 not null,
  version_info int8 not null,
  ts_create_date timestamptz not null,
  primary key (ts_operator_id, ts_role_id)
);
create table ts_roles
(
  ts_id int8 not null,
  version_info int8 not null,
  ts_name varchar(200) not null,
  ts_soft_delete bool not null,
  primary key (ts_id)
);
alter table ts_operator_role_map
    add constraint FK123456789ABCDEF0
    foreign key (ts_role_id)
    references ts_roles on delete cascade;
alter table ts_operator_role_map
    add constraint FK123456789ABCDEF1
    foreign key (ts_operator_id)
    references ts_operators on delete cascade;

-- insert cemadmin and cemsystem in ts_operators
insert into ts_operators (ts_id, version_info, ts_username, ts_password, ts_first_name, ts_last_name, ts_email_address, ts_phone_number, ts_creation_time, ts_active, ts_soft_delete) values (0, 1, 'cemsystem', '', 'CEM', 'System', 'cem-support@wilytech.com', '1 888 GET WILY (1-888-438-9459)', '2006-01-01 00:00:00.000-00', TRUE, FALSE);
insert into ts_operators (ts_id, version_info, ts_username, ts_password, ts_first_name, ts_last_name, ts_email_address, ts_phone_number, ts_creation_time, ts_active, ts_soft_delete) values (1, 1, 'cemadmin', '91c98dad1f8a1b601e682c06c4362983', 'CEM', 'Administrator', 'cem-support@wilytech.com', '1 888 GET WILY (1-888-438-9459)', '2006-01-01 00:00:00.000-00', TRUE, FALSE);

-- insert default roles into ts_roles
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (1, 1, 'ROLE_ADMINISTRATOR', FALSE);
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (2, 1, 'ROLE_OPERATOR', FALSE);

-- assign the cemadmin the default roles
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date) values (1, 1, 1, '2006-01-01 00:00:00.000-00');
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date) values (1, 2, 1, '2006-01-01 00:00:00.000-00');

-- Disable all monitors, because the timconfig file format is changing.
-- In the future, the Tess uninstall will check that no monitors are enabled.
\echo Disabling monitors
update ts_monitors set ts_enabled=false;

-- rename some columns (see bug 2152)
alter table ts_trancomps drop column ts_collect_stats;
alter table ts_transets rename column ts_collect_stats to ts_collect_tranunit_stats;
alter table ts_tranunits rename column ts_collect_stats to ts_collect_trancomp_stats;

-- add table to save 'late' stats for daily aggregation if shutdown occurs
create table ts_stats_tran_user_interval (
    ts_id int8 not null unique,
    version_info int8 not null,
    ts_version int4 not null,
    ts_tranunit_id int8 null,
    ts_transet_id int8 not null,
    ts_transet_incarnation_id int8 not null,
    ts_user_id int8 not null,
    ts_user_incarnation_id int8 not null,
    ts_interval_start_time timestamp with time zone not null,
    ts_interval_wire_time int4 not null,
    ts_total_transactions int4 not null,
    ts_bad_transactions int4 not null,
    ts_opportunities int4 not null,
    ts_defects int4 not null,
    ts_data_type int2 not null,
    ts_tth_type int4 not null,
    ts_tth_lower_spec int4 not null,
    ts_tth_upper_spec int4 not null,
    ts_tth_b0 int4 not null,
    ts_tth_b1 int4 not null,
    ts_tth_b2 int4 not null,
    ts_tth_b3 int4 not null,
    ts_tth_b4 int4 not null,
    ts_tth_b5 int4 not null,
    ts_tth_b6 int4 not null,
    ts_tth_b7 int4 not null,
    ts_tth_b8 int4 not null,
    ts_tth_b9 int4 not null,
    ts_tth_b10 int4 not null,
    ts_tth_b11 int4 not null,
    ts_tth_b12 int4 not null,
    ts_tth_b13 int4 not null,
    ts_tth_b14 int4 not null,
    ts_tth_b15 int4 not null,
    ts_tth_b16 int4 not null,
    ts_tth_b17 int4 not null,
    ts_tth_b18 int4 not null,
    ts_tth_b19 int4 not null,
    ts_tth_b20 int4 not null,
    ts_tth_b21 int4 not null,
    ts_tth_b22 int4 not null,
    ts_tth_b23 int4 not null,
    ts_tth_c0 int4 not null,
    ts_tth_c1 int4 not null,
    ts_tth_c2 int4 not null,
    ts_tth_c3 int4 not null,
    ts_tth_c4 int4 not null,
    ts_tth_c5 int4 not null,
    ts_tth_c6 int4 not null,
    ts_tth_c7 int4 not null,
    ts_tth_c8 int4 not null,
    ts_tth_c9 int4 not null,
    ts_tth_c10 int4 not null,
    ts_tth_c11 int4 not null,
    ts_tth_c12 int4 not null,
    ts_tth_c13 int4 not null,
    ts_tth_c14 int4 not null,
    ts_tth_c15 int4 not null,
    ts_tth_c16 int4 not null,
    ts_tth_c17 int4 not null,
    ts_tth_c18 int4 not null,
    ts_tth_c19 int4 not null,
    ts_tth_c20 int4 not null,
    ts_tth_c21 int4 not null,
    ts_tth_c22 int4 not null,
    ts_tth_c23 int4 not null,
    ts_tth_max int4 not null,
    ts_tth_total_count int4 not null,
    ts_tth_sum_of_squares int8 not null,
    ts_tth_sum_of_values int8 not null,
    ts_tph_type int4 not null,
    ts_tph_lower_spec int4 not null,
    ts_tph_upper_spec int4 not null,
    ts_tph_b0 int4 not null,
    ts_tph_b1 int4 not null,
    ts_tph_b2 int4 not null,
    ts_tph_b3 int4 not null,
    ts_tph_b4 int4 not null,
    ts_tph_b5 int4 not null,
    ts_tph_b6 int4 not null,
    ts_tph_b7 int4 not null,
    ts_tph_b8 int4 not null,
    ts_tph_b9 int4 not null,
    ts_tph_b10 int4 not null,
    ts_tph_b11 int4 not null,
    ts_tph_b12 int4 not null,
    ts_tph_b13 int4 not null,
    ts_tph_b14 int4 not null,
    ts_tph_b15 int4 not null,
    ts_tph_b16 int4 not null,
    ts_tph_b17 int4 not null,
    ts_tph_b18 int4 not null,
    ts_tph_b19 int4 not null,
    ts_tph_b20 int4 not null,
    ts_tph_b21 int4 not null,
    ts_tph_b22 int4 not null,
    ts_tph_b23 int4 not null,
    ts_tph_c0 int4 not null,
    ts_tph_c1 int4 not null,
    ts_tph_c2 int4 not null,
    ts_tph_c3 int4 not null,
    ts_tph_c4 int4 not null,
    ts_tph_c5 int4 not null,
    ts_tph_c6 int4 not null,
    ts_tph_c7 int4 not null,
    ts_tph_c8 int4 not null,
    ts_tph_c9 int4 not null,
    ts_tph_c10 int4 not null,
    ts_tph_c11 int4 not null,
    ts_tph_c12 int4 not null,
    ts_tph_c13 int4 not null,
    ts_tph_c14 int4 not null,
    ts_tph_c15 int4 not null,
    ts_tph_c16 int4 not null,
    ts_tph_c17 int4 not null,
    ts_tph_c18 int4 not null,
    ts_tph_c19 int4 not null,
    ts_tph_c20 int4 not null,
    ts_tph_c21 int4 not null,
    ts_tph_c22 int4 not null,
    ts_tph_c23 int4 not null,
    ts_tph_max int4 not null,
    ts_tph_total_count int4 not null,
    ts_tph_sum_of_squares int8 not null,
    ts_tph_sum_of_values int8 not null,
    ts_tsh_type int4 not null,
    ts_tsh_lower_spec int4 not null,
    ts_tsh_upper_spec int4 not null,
    ts_tsh_b0 int4 not null,
    ts_tsh_b1 int4 not null,
    ts_tsh_b2 int4 not null,
    ts_tsh_b3 int4 not null,
    ts_tsh_b4 int4 not null,
    ts_tsh_b5 int4 not null,
    ts_tsh_b6 int4 not null,
    ts_tsh_b7 int4 not null,
    ts_tsh_b8 int4 not null,
    ts_tsh_b9 int4 not null,
    ts_tsh_b10 int4 not null,
    ts_tsh_b11 int4 not null,
    ts_tsh_b12 int4 not null,
    ts_tsh_b13 int4 not null,
    ts_tsh_b14 int4 not null,
    ts_tsh_b15 int4 not null,
    ts_tsh_b16 int4 not null,
    ts_tsh_b17 int4 not null,
    ts_tsh_b18 int4 not null,
    ts_tsh_b19 int4 not null,
    ts_tsh_b20 int4 not null,
    ts_tsh_b21 int4 not null,
    ts_tsh_b22 int4 not null,
    ts_tsh_b23 int4 not null,
    ts_tsh_c0 int4 not null,
    ts_tsh_c1 int4 not null,
    ts_tsh_c2 int4 not null,
    ts_tsh_c3 int4 not null,
    ts_tsh_c4 int4 not null,
    ts_tsh_c5 int4 not null,
    ts_tsh_c6 int4 not null,
    ts_tsh_c7 int4 not null,
    ts_tsh_c8 int4 not null,
    ts_tsh_c9 int4 not null,
    ts_tsh_c10 int4 not null,
    ts_tsh_c11 int4 not null,
    ts_tsh_c12 int4 not null,
    ts_tsh_c13 int4 not null,
    ts_tsh_c14 int4 not null,
    ts_tsh_c15 int4 not null,
    ts_tsh_c16 int4 not null,
    ts_tsh_c17 int4 not null,
    ts_tsh_c18 int4 not null,
    ts_tsh_c19 int4 not null,
    ts_tsh_c20 int4 not null,
    ts_tsh_c21 int4 not null,
    ts_tsh_c22 int4 not null,
    ts_tsh_c23 int4 not null,
    ts_tsh_max int4 not null,
    ts_tsh_total_count int4 not null,
    ts_tsh_sum_of_squares int8 not null,
    ts_tsh_sum_of_values int8 not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);

create index ts_stats_tran_user_interval_TranUnitIndex on ts_stats_tran_user_interval (ts_tranunit_id);
create index ts_stats_tran_user_interval_StartTimeIndex on ts_stats_tran_user_interval (ts_interval_start_time);

-- add audit tables
create table ts_audit_record_props 
(
	ts_id int8 not null unique, 
	version_info int8 not null, 
	ts_audit_record_id int8 not null, 
	ts_name varchar(200) not null, 
	ts_type varchar(200) not null, 
	ts_old_value varchar(10485760) not null, 
	ts_new_value varchar(10485760) not null, 
	ts_audit_record_props int8, 
	primary key (ts_id)
);
create table ts_audit_records 
(
	ts_id int8 not null unique, 
	version_info int8 not null, 
	ts_action varchar(200) not null, 
	ts_occur_date timestamp not null, 
	ts_operator_id int8 not null, 
	ts_object_key varchar(200), 
	ts_object_class varchar(200), 
	primary key (ts_id)
);

create index ts_audit_record_props_AuditIndex on ts_audit_record_props (ts_audit_record_id);
create index ts_audit_records_OperatorIndex on ts_audit_records (ts_operator_id);
create index ts_audit_records_KeyIndex on ts_audit_records (ts_object_key);

alter table ts_audit_record_props
    add constraint FKC35853A67ED614FE
    foreign key (ts_audit_record_id)
    references ts_audit_records;
alter table ts_audit_record_props
    add constraint FKC35853A64AFDC9FF
    foreign key (ts_audit_record_props)
    references ts_audit_records;
alter table ts_audit_records
    add constraint FKA05B6C1EB2BB7E4D
    foreign key (ts_operator_id)
    references ts_operators;

-- add incarnation ids for users
alter table ts_users add column ts_incarnation_id int8 not null default 0;
update ts_users set ts_incarnation_id = ts_id;
create unique index ts_users_IncarnationIndex on ts_users (ts_incarnation_id);

alter table ts_defects add column ts_user_incarnation_id int8 not null default 0;
update ts_defects set ts_user_incarnation_id = ts_user_id;

alter table ts_defects_interval add column ts_user_incarnation_id int8 not null default 0;
update ts_defects_interval set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transet_user_daily add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transet_user_daily set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transet_user_interval add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transet_user_interval set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transet_user_monthly add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transet_user_monthly set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transet_user_weekly add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transet_user_weekly set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transetgroup_user_daily add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transetgroup_user_daily set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transetgroup_user_interval add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transetgroup_user_interval set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transetgroup_user_monthly add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transetgroup_user_monthly set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_transetgroup_user_weekly add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_transetgroup_user_weekly set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_tranunit_user_daily add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_daily set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_tranunit_user_interval add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_interval set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_tranunit_user_monthly add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_monthly set ts_user_incarnation_id = ts_user_id;

alter table ts_stats_tranunit_user_weekly add column ts_user_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_weekly set ts_user_incarnation_id = ts_user_id;

alter table ts_usergroup_users_map add column ts_user_incarnation_id int8 not null default 0;
update ts_usergroup_users_map set ts_user_incarnation_id = ts_user_id;
alter table ts_usergroup_users_map drop constraint ts_usergroup_users_map_pkey;
alter table ts_usergroup_users_map add constraint ts_usergroup_users_map_pkey primary key (ts_user_id, ts_user_incarnation_id, ts_usergroup_id);

-- add incarnation ids for transets
alter table ts_transets add column ts_incarnation_id int8 not null default 0;
update ts_transets set ts_incarnation_id = ts_id;
create unique index ts_transets_IncarnationIndex on ts_transets (ts_incarnation_id);

alter table ts_biz_events add column ts_transet_incarnation_id int8 not null default 0;
update ts_biz_events set ts_transet_incarnation_id = ts_transet_id;

alter table ts_defects add column ts_transet_incarnation_id int8 not null default 0;
update ts_defects set ts_transet_incarnation_id = ts_transet_id;

alter table ts_defects_interval add column ts_transet_incarnation_id int8 not null default 0;
update ts_defects_interval set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_all_daily add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_all_daily set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_all_interval add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_all_interval set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_all_monthly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_all_monthly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_all_weekly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_all_weekly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_usergroup_daily add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_usergroup_daily set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_usergroup_interval add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_usergroup_interval set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_usergroup_monthly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_usergroup_monthly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_usergroup_weekly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_usergroup_weekly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_user_daily add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_user_daily set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_user_interval add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_user_interval set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_user_monthly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_user_monthly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_transet_user_weekly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_transet_user_weekly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_all_daily add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_all_daily set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_all_interval add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_all_interval set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_all_monthly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_all_monthly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_all_weekly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_all_weekly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_usergroup_daily add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_usergroup_daily set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_usergroup_interval add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_usergroup_interval set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_usergroup_monthly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_usergroup_monthly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_usergroup_weekly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_usergroup_weekly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_user_daily add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_daily set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_user_interval add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_interval set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_user_monthly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_monthly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_stats_tranunit_user_weekly add column ts_transet_incarnation_id int8 not null default 0;
update ts_stats_tranunit_user_weekly set ts_transet_incarnation_id = ts_transet_id;

alter table ts_transetgroup_transets_map add column ts_transet_incarnation_id int8 not null default 0;
update ts_transetgroup_transets_map set ts_transet_incarnation_id = ts_transet_id;
alter table ts_transetgroup_transets_map drop constraint ts_transetgroup_transets_map_pkey;
alter table ts_transetgroup_transets_map add constraint ts_transetgroup_transets_map_pkey primary key (ts_transet_id, ts_transet_incarnation_id, ts_transet_group_id);

-- add index to last aggregated row
create index ts_stats_transet_all_daily_LastAggregatedRowIndex on ts_stats_transet_all_daily (ts_last_aggregated_row);
create index ts_stats_transet_all_interval_LastAggregatedRowIndex on ts_stats_transet_all_interval (ts_last_aggregated_row);
create index ts_stats_transet_all_monthly_LastAggregatedRowIndex on ts_stats_transet_all_monthly (ts_last_aggregated_row);
create index ts_stats_transet_all_weekly_LastAggregatedRowIndex on ts_stats_transet_all_weekly (ts_last_aggregated_row);
create index ts_stats_transet_usergroup_daily_LastAggregatedRowIndex on ts_stats_transet_usergroup_daily (ts_last_aggregated_row);
create index ts_stats_transet_usergroup_interval_LastAggregatedRowIndex on ts_stats_transet_usergroup_interval (ts_last_aggregated_row);
create index ts_stats_transet_usergroup_monthly_LastAggregatedRowIndex on ts_stats_transet_usergroup_monthly (ts_last_aggregated_row);
create index ts_stats_transet_usergroup_weekly_LastAggregatedRowIndex on ts_stats_transet_usergroup_weekly (ts_last_aggregated_row);
create index ts_stats_transet_user_daily_LastAggregatedRowIndex on ts_stats_transet_user_daily (ts_last_aggregated_row);
create index ts_stats_transet_user_monthly_LastAggregatedRowIndex on ts_stats_transet_user_monthly (ts_last_aggregated_row);
create index ts_stats_transet_user_weekly_LastAggregatedRowIndex on ts_stats_transet_user_weekly (ts_last_aggregated_row);
create index ts_stats_transetgroup_all_daily_LastAggregatedRowIndex on ts_stats_transetgroup_all_daily (ts_last_aggregated_row);
create index ts_stats_transetgroup_all_interval_LastAggregatedRowIndex on ts_stats_transetgroup_all_interval (ts_last_aggregated_row);
create index ts_stats_transetgroup_all_monthly_LastAggregatedRowIndex on ts_stats_transetgroup_all_monthly (ts_last_aggregated_row);
create index ts_stats_transetgroup_all_weekly_LastAggregatedRowIndex on ts_stats_transetgroup_all_weekly (ts_last_aggregated_row);
create index ts_stats_transetgroup_usergroup_daily_LastAggregatedRowIndex on ts_stats_transetgroup_usergroup_daily (ts_last_aggregated_row);
create index ts_stats_transetgroup_usergroup_interval_LastAggregatedRowIndex on ts_stats_transetgroup_usergroup_interval (ts_last_aggregated_row);
create index ts_stats_transetgroup_usergroup_monthly_LastAggregatedRowIndex on ts_stats_transetgroup_usergroup_monthly (ts_last_aggregated_row);
create index ts_stats_transetgroup_usergroup_weekly_LastAggregatedRowIndex on ts_stats_transetgroup_usergroup_weekly (ts_last_aggregated_row);
create index ts_stats_transetgroup_user_daily_LastAggregatedRowIndex on ts_stats_transetgroup_user_daily (ts_last_aggregated_row);
create index ts_stats_transetgroup_user_interval_LastAggregatedRowIndex on ts_stats_transetgroup_user_interval (ts_last_aggregated_row);
create index ts_stats_transetgroup_user_monthly_LastAggregatedRowIndex on ts_stats_transetgroup_user_monthly (ts_last_aggregated_row);
create index ts_stats_transetgroup_user_weekly_LastAggregatedRowIndex on ts_stats_transetgroup_user_weekly (ts_last_aggregated_row);
create index ts_stats_tranunit_all_daily_LastAggregatedRowIndex on ts_stats_tranunit_all_daily (ts_last_aggregated_row);
create index ts_stats_tranunit_all_interval_LastAggregatedRowIndex on ts_stats_tranunit_all_interval (ts_last_aggregated_row);
create index ts_stats_tranunit_all_monthly_LastAggregatedRowIndex on ts_stats_tranunit_all_monthly (ts_last_aggregated_row);
create index ts_stats_tranunit_all_weekly_LastAggregatedRowIndex on ts_stats_tranunit_all_weekly (ts_last_aggregated_row);
create index ts_stats_tranunit_usergroup_daily_LastAggregatedRowIndex on ts_stats_tranunit_usergroup_daily (ts_last_aggregated_row);
create index ts_stats_tranunit_usergroup_interval_LastAggregatedRowIndex on ts_stats_tranunit_usergroup_interval (ts_last_aggregated_row);
create index ts_stats_tranunit_usergroup_monthly_LastAggregatedRowIndex on ts_stats_tranunit_usergroup_monthly (ts_last_aggregated_row);
create index ts_stats_tranunit_usergroup_weekly_LastAggregatedRowIndex on ts_stats_tranunit_usergroup_weekly (ts_last_aggregated_row);
create index ts_stats_tranunit_user_daily_LastAggregatedRowIndex on ts_stats_tranunit_user_daily (ts_last_aggregated_row);
create index ts_stats_tranunit_user_monthly_LastAggregatedRowIndex on ts_stats_tranunit_user_monthly (ts_last_aggregated_row);
create index ts_stats_tranunit_user_weekly_LastAggregatedRowIndex on ts_stats_tranunit_user_weekly (ts_last_aggregated_row);
create index ts_defects_TranSetIncarnationIdIndex on ts_defects (ts_transet_incarnation_id);
create index ts_defects_UserIncarnationIdIndex on ts_defects (ts_user_incarnation_id);

\echo Updating database version
update ts_domains set ts_db_versions='3.2.0';
