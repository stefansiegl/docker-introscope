-- upgrade database from 3.3.4 to 3.4.0

-- add session timeout per app
ALTER TABLE ts_apps ADD COLUMN ts_session_timeout int not null default 60;

-- allow user recognition to ignore the application
ALTER TABLE ts_domains ADD COLUMN ts_ignore_apps_in_user_recognition bool not null default false;

-- server think time feature
alter table ts_defects add column ts_data_center_time int4;

-- XML support changes
alter table ts_interim_session_id_parameters alter column ts_name type varchar(20000);
alter table ts_login_id_parameters alter column ts_name type varchar(20000);
alter table ts_params alter column ts_name type varchar(20000);
alter table ts_session_id_parameters alter column ts_name type varchar(20000);
alter table ts_trancomps add column ts_recording_component_id int8;
alter table ts_trancomps 
    add constraint FK445D393922B94AEF
    foreign key (ts_recording_component_id) 
    references ts_recording_components;

-- add table for usergroup identification
create table ts_usergroup_id_parameters (
    ts_app_id int8 not null,
    ts_type varchar(200) not null,
    ts_name varchar(200) not null,
    ts_description varchar(10485760),
    version_info int8 not null,
    ts_offset int4 not null,
    ts_length int4 not null,
    ts_soft_delete bool not null,
    primary key (ts_app_id, ts_type, ts_name)
);
alter table ts_usergroup_id_parameters 
    add constraint FK2999D77892916D71
    foreign key (ts_app_id) 
    references ts_apps on delete cascade;

-- add analysis report types
insert into ts_report_types values (16, 1, 'TranCountReport', false);
insert into ts_report_types values (17, 1, 'TranDefectReport', false);
insert into ts_report_types values (18, 1, 'TranSizeReport', false);
insert into ts_report_types values (19, 1, 'TranSuccessRateReport', false);
insert into ts_report_types values (20, 1, 'TranThroughputReport', false);
insert into ts_report_types values (21, 1, 'TranTimeReport', false);
insert into ts_report_types values (22, 1, 'TranVolumeReport', false);
insert into ts_report_types values (23, 1, 'TranYieldReport', false);

-- add analysis report params
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (81,1,1,16,'countComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (82,1,17,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (83,1,20,16,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (84,1,1,17,'defectComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (85,1,17,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (86,1,20,17,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (102,1,1,18,'sizeComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (103,1,17,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (104,1,20,18,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (87,1,1,19,'successRateComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (88,1,17,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (89,1,20,19,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (90,1,1,20,'throughputComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (91,1,17,20,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (92,1,20,20,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (93,1,1,21,'timeComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (94,1,17,21,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (95,1,20,21,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (96,1,1,22,'volumeComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (97,1,17,22,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (98,1,20,22,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (99,1,1,23,'yieldComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (100,1,17,23,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (101,1,20,23,'Today',false);

-- add transet parameter to selected reports
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (105,1,18,3,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (106,1,18,4,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (107,1,18,5,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (108,1,18,6,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (109,1,18,7,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (110,1,18,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (111,1,18,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (112,1,18,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (113,1,18,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (114,1,18,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (115,1,18,20,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (116,1,18,21,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (117,1,18,22,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (118,1,18,23,'0',false);

-- BizEvent Trigger and Ageout Rules
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) 
values (1020, 1, 'bizEvent.evaluationIntervalDuration', '5', 'How often should check BizEvents to trigger or age-out', '5', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) 
values (1021, 1, 'bizEvent.ageoutRule.inactivity.enabled', 'true', 'Aging-out BizEvents based on inactivity (no new defects) is enabled', 'true', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) 
values (1022, 1, 'bizEvent.ageoutRule.inactivity.minutesSinceLastDefect', '1440', 'Aging-out BizEvents based on inactivity (no new defects) is enabled', '1440', false);

--modify the introscope table
ALTER TABLE ts_introscope_ems ADD COLUMN ts_username varchar(200) default 'Admin';
ALTER TABLE ts_introscope_ems ADD COLUMN ts_password varchar(200);
ALTER TABLE ts_introscope_ems ADD COLUMN ts_web_view_hostname varchar(200);
update ts_introscope_ems set ts_web_view_hostname = ts_hostname;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_web_view_port int not null default 8080;
update ts_introscope_ems set ts_web_view_port=ts_port;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_web_view_root_path varchar(300);
update ts_introscope_ems set ts_web_view_root_path=ts_root_path;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_web_start_hostname varchar(200);
update ts_introscope_ems set ts_web_start_hostname = ts_hostname;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_web_start_port int not null default 8081;
update ts_introscope_ems set ts_web_start_port=ts_port;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_web_start_root_path varchar(300);
update ts_introscope_ems set ts_web_start_root_path=ts_root_path;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_web_start_version varchar(200);
ALTER TABLE ts_introscope_ems ADD COLUMN ts_has_web_start bool NOT NULL default false;
ALTER TABLE ts_introscope_ems DROP COLUMN ts_root_path;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_tran_trace_duration int4 not null default 120;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_tran_trace_threshold_percentage int4 not null default 25;
ALTER TABLE ts_introscope_ems ADD COLUMN ts_backend_list varchar(20000) default 'Backends|*,JDBC|*';

-- update due to making P/Q reports act like SLA/Trend reports
update ts_report_type_param_values set ts_value='tranPerformanceReport.html' where ts_value='tranSetGroupPerformanceReport.html';
update ts_report_type_param_values set ts_value='tranQualityReport.html' where ts_value='tranSetGroupQualityReport.html';
update ts_report_def_param_values set ts_value='tranPerformanceReport.html' where ts_value='tranSetGroupPerformanceReport.html';
update ts_report_def_param_values set ts_value='tranQualityReport.html' where ts_value='tranSetGroupQualityReport.html';

-- Updating database version
update ts_domains set ts_db_versions='3.4.0';
