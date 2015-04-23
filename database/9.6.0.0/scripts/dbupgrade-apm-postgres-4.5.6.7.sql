-- update database from 4.5.6.7 to 9.0.7.0 for APM 9.0.7.0

--renaming the tables

ALTER TABLE ts_stats_tran_user_interval	 RENAME TO ts_stats_t_us_interval;
ALTER TABLE ts_stats_transet_all_daily	RENAME TO ts_stats_ts_all_daily;
ALTER TABLE ts_stats_transet_all_interval RENAME TO ts_stats_ts_all_interval;
ALTER TABLE ts_stats_transet_all_monthly  RENAME TO ts_stats_ts_all_monthly;
ALTER TABLE ts_stats_transet_all_weekly	 RENAME TO ts_stats_ts_all_weekly;
ALTER TABLE ts_stats_transet_usergroup_daily RENAME TO 	ts_stats_ts_usgrp_daily;
ALTER TABLE ts_stats_transet_usergroup_interval	RENAME TO ts_stats_ts_usgrp_interval;
ALTER TABLE ts_stats_transet_usergroup_monthly	RENAME TO ts_stats_ts_usgrp_monthly;
ALTER TABLE ts_stats_transet_usergroup_weekly RENAME TO ts_stats_ts_usgrp_weekly;
ALTER TABLE ts_stats_transet_user_daily RENAME TO ts_stats_ts_us_daily;
ALTER TABLE ts_stats_transet_user_interval RENAME TO ts_stats_ts_us_interval;
ALTER TABLE ts_stats_transet_user_monthly RENAME TO ts_stats_ts_us_monthly;
ALTER TABLE ts_stats_transet_user_weekly RENAME TO ts_stats_ts_us_weekly;
ALTER TABLE ts_stats_transetgroup_all_daily RENAME TO 	ts_stats_tsgrp_all_daily;
ALTER TABLE ts_stats_transetgroup_all_interval RENAME TO ts_stats_tsgrp_all_interval;
ALTER TABLE ts_stats_transetgroup_all_monthly RENAME TO ts_stats_tsgrp_all_monthly;
ALTER TABLE ts_stats_transetgroup_all_weekly  RENAME TO ts_stats_tsgrp_all_weekly;
ALTER TABLE ts_stats_transetgroup_usergroup_daily RENAME TO ts_stats_tsgrp_usgrp_daily;
ALTER TABLE ts_stats_transetgroup_usergroup_interval RENAME TO ts_stats_tsgrp_usgrp_interval;
ALTER TABLE ts_stats_transetgroup_usergroup_monthly RENAME TO ts_stats_tsgrp_usgrp_monthly;
ALTER TABLE ts_stats_transetgroup_usergroup_weekly RENAME TO ts_stats_tsgrp_usgrp_weekly;
ALTER TABLE ts_stats_transetgroup_user_daily RENAME TO ts_stats_tsgrp_us_daily;
ALTER TABLE ts_stats_transetgroup_user_interval RENAME TO ts_stats_tsgrp_us_interval;
ALTER TABLE ts_stats_transetgroup_user_monthly RENAME TO ts_stats_tsgrp_us_monthly;
ALTER TABLE ts_stats_transetgroup_user_weekly RENAME TO ts_stats_tsgrp_us_weekly;
ALTER TABLE ts_stats_tranunit_all_daily RENAME TO ts_stats_tu_all_daily;
ALTER TABLE ts_stats_tranunit_all_interval RENAME TO ts_stats_tu_all_interval;
ALTER TABLE ts_stats_tranunit_all_monthly RENAME TO ts_stats_tu_all_monthly;
ALTER TABLE ts_stats_tranunit_all_weekly RENAME TO ts_stats_tu_all_weekly;
ALTER TABLE ts_stats_tranunit_usergroup_daily RENAME TO ts_stats_tu_usgrp_daily;
ALTER TABLE ts_stats_tranunit_usergroup_interval RENAME TO ts_stats_tu_usgrp_interval;
ALTER TABLE ts_stats_tranunit_usergroup_monthly RENAME TO ts_stats_tu_usgrp_monthly;
ALTER TABLE ts_stats_tranunit_usergroup_weekly RENAME TO ts_stats_tu_usgrp_weekly;
ALTER TABLE ts_stats_tranunit_user_daily RENAME TO ts_stats_tu_us_daily;
ALTER TABLE ts_stats_tranunit_user_interval RENAME TO ts_stats_tu_us_interval;
ALTER TABLE ts_stats_tranunit_user_monthly RENAME TO ts_stats_tu_us_monthly;
ALTER TABLE ts_stats_tranunit_user_weekly RENAME TO ts_stats_tu_us_weekly;
ALTER TABLE ts_interim_session_id_parameters RENAME TO ts_interim_session_id_params;


-- Eliminate duplicates in 'ts_user_def_groups' and 'ts_user_groups' by renaming them.
-- They need to be eliminated in order to apply unique constraint on ts_name column.
-- We rename only soft deleted rows because we assume there will be no duplicates within
-- rows which are not soft deleted since CEM doesn't allow duplicates in these rows.

UPDATE ts_user_def_groups SET ts_name = ts_name || '_' || ts_id WHERE ts_soft_delete='1' 
AND ts_name IN (SELECT ts_name FROM ts_user_def_groups GROUP BY ts_name HAVING count(*) > 1);

UPDATE ts_user_groups SET ts_name = ts_name || '_' || ts_id WHERE ts_soft_delete='1' 
AND ts_name IN (SELECT ts_name FROM ts_user_groups GROUP BY ts_name HAVING count(*) > 1);


-- set unique constraints for 'ts_user_def_groups' and 'ts_user_group

ALTER TABLE ts_user_def_groups ADD CONSTRAINT ts_user_def_groups_NameIdx UNIQUE(ts_name);
ALTER TABLE ts_user_groups ADD CONSTRAINT ts_user_groups_NameIdx UNIQUE(ts_name);

--existing script1



-- New table created for Business API
CREATE TABLE ts_attributes
(
  ts_id bigint NOT NULL,
  version_info bigint NOT NULL,
  ts_tran_type smallint NOT NULL,  
  ts_tran_id bigint NOT NULL,
  ts_collection_attr boolean NOT NULL,
  ts_category character varying(200) NOT NULL,
  ts_name character varying(200) NOT NULL,
  ts_type smallint NOT NULL,
  ts_soft_delete boolean NOT NULL DEFAULT false,
  CONSTRAINT ts_attributes_pkey PRIMARY KEY (ts_id)
);

alter table ts_defect_defs add column ts_attribute_id int8;
alter table ts_defect_defs add column ts_condition int2;
alter table ts_defect_defs 
    add constraint FK3216D15C9DCCA47 
    foreign key (ts_attribute_id) 
    references ts_attributes (ts_id)
	on update no action on delete cascade;

alter table ts_defects add column ts_errors_per_interval int4;
alter table ts_defects add column ts_responses_per_interval int4;
alter table ts_defects alter column ts_transaction_size drop not null;
alter table ts_defects alter column ts_transaction_time drop not null;
alter table ts_defects alter column ts_data_center_time drop not null;
alter table ts_defects alter column ts_server_port drop not null;

--Delete the LicenseComplianceReport type from ts_report_types as part of removing the Licensing from CEM for Tess on EM 
delete from ts_report_defs where ts_report_type_id in (select ts_id from ts_report_types where ts_name = 'LicenseComplianceReport');
delete from ts_report_type_param_values where ts_report_type_id in (select ts_id from ts_report_types where ts_name = 'LicenseComplianceReport');
delete from ts_report_types where ts_name = 'LicenseComplianceReport';

--Update SessionUsageReport since "LicenseComplianceReport" is removed from 5.0, the sequence number of sessionUsage is changed from 27 to 26
insert into ts_report_types values (26, 1, 'SessionUsageReport', false);
update ts_report_defs set ts_report_type_id=26 where ts_report_type_id=27;
update ts_report_type_param_values set ts_report_type_id=26 where ts_report_type_id=27;
delete from ts_report_types where ts_id = 27;


-- these will fail if tables already exists but no harm will be done
create table tang_config 
(
    ts_id int8 not null unique, 
    version_info int8 not null,   
    ts_key varchar(100) not null,
    ts_value varchar(2000) not null,
    ts_soft_delete bool not null default false,
    primary key (ts_id)
);

-- some cases of duplicate entries were found in tang_config
-- this will make sure duplicate rows are cleaned up 
DELETE FROM tang_config WHERE 	ctid NOT IN
(SELECT 	MAX(dup.ctid) FROM   		tang_config As dup 
GROUP BY 	dup.ts_key);

-- this is to update a tang_config table that already existed from before
-- and wasn't just created by this script. tang_config was an optional table in 4.5
alter table tang_config add column ts_id bigint;
alter table tang_config add column version_info int8 not null default 0;
alter table tang_config add column ts_soft_delete bool not null default false;

update tang_config set ts_id=1 where ts_key='database.schemaVersion';
update tang_config set ts_id=2 where ts_key='email.to';
update tang_config set ts_id=3 where ts_key='email.fromName';
update tang_config set ts_id=4 where ts_key='email.from';
update tang_config set ts_id=5 where ts_key='email.subject';
update tang_config set ts_id=6 where ts_key='email.smtpServer';
update tang_config set ts_id=7 where ts_key='email.smtpServer.port';
update tang_config set ts_id=8 where ts_key='email.smtpServer.requireAuthentication';
update tang_config set ts_id=9 where ts_key='email.smtpServer.username';
update tang_config set ts_id=10 where ts_key='email.smtpServer.password';
update tang_config set ts_id=11 where ts_key='email.message';
update tang_config set ts_id=12 where ts_key='snmp.trap.ipAddress';
update tang_config set ts_id=13 where ts_key='config.maxEvents';
update tang_config set ts_id=14 where ts_key='config.maxEventAge';
update tang_config set ts_id=15 where ts_key='config.mailSchedule';
update tang_config set ts_id=16 where ts_key='config.eventRules';
update tang_config set ts_id=17 where ts_key='config.eventRuleToIpAddress';
update tang_config set ts_id=18 where ts_key='config.eventRuleFromIpAddress';

alter table tang_config add primary key(ts_id);


create table tang_event_types 
(
    ts_id int8 not null unique,
    version_info int8 not null,
    ts_name varchar(100) not null,
    ts_severity varchar(20) not null,
    ts_category varchar(20),
    ts_soft_delete bool not null default false,
    primary key (ts_id)
);

create table tang_events
(
  ts_id int8 not null,
  version_info int8 not null,
  ts_type_id int8 not null,
  ts_info varchar(10000),
  ts_source_program varchar(32) not null,
  ts_source_ip_address varchar(39),
  ts_timestamp timestamp with time zone not null,
  ts_soft_delete bool not null default false
);

-- multi TESS related tables

create table ts_child_services_def
(
  ts_id bigint not null,
  version_info bigint not null,
  ts_parent_id bigint not null,
  ts_name varchar(200) not null,
  ts_description varchar(1000),
  ts_monitor_assignable boolean not null,
  ts_started boolean,
  ts_soft_delete boolean not null default false,
  primary key (ts_id)
);

create table ts_entity
(
  ts_id bigint not null,
  version_info bigint not null,
  ts_guid varchar(200) not null,
  ts_ip_address numeric not null,
  ts_ip_address_type int2 not null,
  ts_port int2 not null,
  ts_hostname varchar(200),
  ts_description varchar(200),
  ts_em_type varchar(20) not null,
  ts_ip_edit boolean not null default false,
  ts_soft_delete boolean not null default false,
  primary key (ts_id)
);

create table ts_entity_service
(
  ts_id bigint not null,
  version_info bigint not null,
  ts_entity_id bigint not null,
  ts_service_id bigint not null,
  ts_locked_by_entity bigint,
  ts_soft_delete bool not null default false,
  primary key (ts_id)
);

create table ts_monitor_child_service
(
  ts_id bigint not null,
  version_info bigint not null,
  ts_monitors_id bigint not null,
  ts_child_service_id bigint not null,
  ts_entity_service_id bigint not null,
  ts_enabled boolean DEFAULT true,
  ts_started int2 DEFAULT 0,
  ts_soft_delete boolean not null default false,
  primary key (ts_id)
);

create table ts_services_def
(
  ts_id bigint not null,
  version_info bigint not null,
  ts_name varchar(200) not null,
  ts_display_name varchar(200) not null,
  ts_description varchar(1000),
  ts_singleton bool not null default false,
  ts_required bool not null default false,
  ts_soft_delete bool not null default false,
  primary key (ts_id)
);

-- add constraints for multi TESS tables

alter table ts_child_services_def
    add constraint FK78097D6E27254A97
    foreign key (ts_parent_id)
    references ts_services_def (ts_id) on delete cascade;

alter table ts_entity_service
    add constraint FK78097D6E27154D97
    foreign key (ts_service_id)
    references ts_services_def on delete cascade;
	
alter table ts_entity_service
    add constraint FK79097D6E27167E11
    foreign key (ts_entity_id)
    references ts_entity on delete cascade;
	
alter table ts_monitor_child_service
    add constraint FK78097D6E35354E97
    foreign key (ts_child_service_id)
    references ts_child_services_def (ts_id) on delete cascade;
	
alter table ts_monitor_child_service
    add constraint FK64597D6E35354B97
    foreign key (ts_entity_service_id)
    references ts_entity_service (ts_id) on delete cascade;  

alter table ts_monitor_child_service
    add constraint FK67657D6E35354R97
    foreign key (ts_monitors_id)
    references ts_monitors (ts_id) on delete cascade;	

-- tang events 
	
alter table tang_events
    add constraint FKB4963DE5C6CF0E08
    foreign key (ts_type_id)
    references tang_event_types on delete cascade;   

-- upgrading the existing tang_event_types
alter table tang_event_types add column version_info int8 not null default 0;
alter table tang_event_types add column ts_soft_delete bool not null default false;

-- upgrading the existing tang_events
alter table tang_events add column version_info int8 not null default 0;
alter table tang_events add column ts_soft_delete bool not null default false;
ALTER TABLE tang_events ALTER COLUMN ts_source_ip_address TYPE character varying (39);

--deleting tang events and types that are no longer used in APM 9.0
delete from tang_events where ts_type_id = 1;
delete from tang_event_types where ts_name = 'CEM license expiration';

delete from tang_events where ts_type_id = 2;
delete from tang_event_types where ts_name = 'Database backup failure';

delete from tang_events where ts_type_id = 7;
delete from tang_event_types where ts_name = 'Disconnected from Introscope EM';

delete from tang_events where ts_type_id = 8;
delete from tang_event_types where ts_name = 'Connected to Introscope EM';

delete from tang_events where ts_type_id = 9;
delete from tang_event_types where ts_name = 'Tess cannot reach Introscope EM';

delete from tang_events where ts_type_id = 13;
delete from tang_event_types where ts_name = 'License violation';

delete from tang_events where ts_type_id = 19;
delete from tang_event_types where ts_name = 'Database space info 20% remaining';

delete from tang_events where ts_type_id = 20;
delete from tang_event_types where ts_name = 'Database space warning 5% remaining';


create table ts_monitor_types
(
  ts_id int8 NOT NULL unique,
  version_info int8 not null,
  ts_name character varying NOT NULL,
  ts_soft_delete boolean NOT NULL DEFAULT false,
  primary key (ts_id)
);


insert into ts_monitor_types(ts_id, version_info, ts_name) values(1, 5, 'TIM');
insert into ts_monitor_types(ts_id, version_info, ts_name) values(2, 5, 'Agent');


create table ts_protocols
(
  ts_id smallint NOT NULL,
  ts_name character varying(50) NOT NULL,
  ts_soft_delete boolean NOT NULL DEFAULT false,
  primary key (ts_id)
);

create table ts_tran_types
(
  ts_id smallint NOT NULL,
  ts_name character varying NOT NULL,
  ts_soft_delete boolean NOT NULL DEFAULT false,
  primary key (ts_id)
);

alter table ts_monitors add column ts_monitor_type int4 NOT NULL default 1;

-- the ts_monitors is now being used for both TIMs and Agents, the following fields are not applicable to agent monitors
alter table ts_monitors alter column ts_last_stats_file_id drop not null;
alter table ts_monitors alter column ts_domain_status_name drop not null;
alter table ts_monitors alter column ts_tim_status_name drop not null;
alter table ts_monitors alter column ts_tim_status_update_time drop not null;

alter table ts_monitors
    add constraint FK924B8A6AA179D180 
    foreign key (ts_monitor_type)
    references ts_monitor_types (ts_id);

-- add the following 2 columns to ts_recording_sessions for biz recording;
    
alter table ts_recording_sessions add column ts_selected_monitor_types varchar(100) not null default 1;
alter table ts_recording_sessions add column ts_agent_regex varchar(500);
alter table ts_recording_sessions add column ts_original_client_ip_address varchar(200);

-- changes to ts_attributes
alter table ts_attributes drop column ts_tran_id;
alter table ts_attributes add column ts_monitor_type smallint NOT NULL;
alter table ts_attributes add column ts_protocol_type smallint NOT NULL;

alter table ts_attributes
    add constraint FKF110A8825A698EC3
    foreign key (ts_monitor_type)
    references ts_monitor_types (ts_id);    
alter table ts_attributes
    add constraint FKF110A852EF375ED8
    foreign key (ts_protocol_type)
    references ts_protocols (ts_id);
alter table ts_attributes
    add constraint FKA110A752AF225ED0
    foreign key (ts_tran_type)
    references ts_tran_types (ts_id);

-- upgrading ts_introscope_configs
update ts_introscope_configs set ts_enabled=true;

--following changes are for the M2 feature.
CREATE TABLE ts_autogen_template
(
  ts_id bigint NOT NULL,
  ts_apps_id bigint NOT NULL,
  ts_name character varying(10485760) ,
  ts_description character varying(10485760) ,
  ts_enabled boolean DEFAULT false,
  ts_url_path character varying(10485760) ,
  ts_content_type character varying(10485760) DEFAULT 'text/html',
  version_info bigint NOT NULL,
  ts_soft_delete boolean DEFAULT false,
  primary key (ts_id)
);

create table ts_autogen_params (
    ts_id bigint NOT NULL,
    ts_template_id bigint NOT NULL,
    ts_param_type varchar(200) not null,
    ts_name varchar(20000) not null,
    ts_operator int2 not null,
    version_info int8 not null,
    ts_pattern varchar(1000),
    ts_required boolean default false,
    ts_include_identification   boolean default false,
    ts_soft_delete bool not null,
    primary key (ts_id, ts_param_type, ts_name)
);

alter table ts_autogen_params
  add constraint fked464au11a100010
  foreign key (ts_template_id)
  references ts_autogen_template(ts_id)
  on update no action on delete cascade;
  
alter table ts_autogen_template
  add constraint fked464au12a100010
  foreign key (ts_apps_id)
  references ts_apps(ts_id)
  on update no action on delete no action;

create table ts_bizdef_filters (
    ts_id int8 not null unique,  
    version_info int8 not null,
    ts_trandef_groups_id int8 not null,
    ts_monitor_name_filter varchar(500) not null,
    ts_filter_type int not null,
    ts_monitor_type int4 not null,
    ts_isregex bool not null,
    ts_soft_delete boolean DEFAULT false,
    primary key (ts_id)
);
alter table ts_bizdef_filters 
    add constraint fk3216d15c22b94axl 
    foreign key (ts_trandef_groups_id) 
    references ts_tran_def_groups on delete cascade;
alter table ts_bizdef_filters 
    add constraint fk3216d15c22b94bxl 
    foreign key (ts_monitor_type) 
    references ts_monitor_types;
    
-- upgrading ts_domains, ts_attributes, 
alter table ts_domains add column ts_max_bus_trans int8 default 0;
alter table ts_domains add column ts_auto_sync_monitors int8 default 15;
alter table ts_domains add column ts_autogen_def_enabled boolean default false;
alter table ts_domains add column ts_autogen_disable_interval int8 default 30;
alter table ts_domains add column ts_path_param_seperator character(1) DEFAULT ' '::bpchar;
alter table ts_domains add column ts_autogen_status boolean default false;
alter table ts_domains add column ts_autogen_urlmonitor boolean default false;
alter table ts_domains add column ts_capture_full_defect_details boolean NOT NULL default false;
update ts_domains set ts_transaction_defect_delete = 30 where ts_transaction_defect_delete > 30;

alter table ts_trancomps add column ts_pending boolean default false;
alter table ts_trancomps add column ts_creation_date timestamp;

-- change to ts_apps, ts_recording_sessions, ts_recording_components to add character encoding specification
alter table ts_apps add column ts_charset varchar(30) NOT NULL DEFAULT 'ISO-8859-1';
alter table ts_recording_components add column ts_charset varchar(30) NOT NULL DEFAULT 'ISO-8859-1';
alter table ts_recording_sessions add column ts_charset varchar(30) NOT NULL DEFAULT 'ISO-8859-1';

-- upgrading ts_transets to adding ts_autogen_request_count and ts_autogen_template_id columns
alter table ts_transets add column ts_autogen_request_count bigint;
alter table ts_transets add column ts_autogen_template_id bigint;

-- upgrading ts_params to adding ts_autogen_sequence column
alter table ts_params add column ts_autogen_sequence int2;

-- upgrading ts_audit_records
alter table ts_audit_records alter column ts_operator_id drop not null;
alter table ts_audit_records add column ts_operator_name varchar(200) not null DEFAULT 'cemsystem';
alter table ts_audit_records drop constraint FKA05B6C1EB2BB7E4D;
drop index ts_audit_records_OperatorIndex;
create index ts_audit_records_OperatorIndex on ts_audit_records (ts_operator_name);
-- update ts_operator_name with the name of the operator
update ts_audit_records set ts_operator_name = ts_operators.ts_username from ts_operators
where ts_audit_records.ts_operator_id = ts_operators.ts_id;
-- End upgrading ts_audit_records

--60530  4.5->9.0:ERROR: alter table ts_transets drop constraint FK865CB7BC1F3F4799; 
--60531  4.5->9.0:ERROR: alter table ts_transets drop constraint FK865CB7BC1F3F479A;
--CREATE OR REPLACE FUNCTION execute(TEXT) RETURNS VOID AS $$
--BEGIN EXECUTE $1; END;
--$$ LANGUAGE plpgsql STRICT;
 
-- upgrading ts_report_def_param_values
-- update ts_value with the username of the operator
UPDATE ts_report_def_param_values SET ts_value = ts_operators.ts_username from ts_operators 
where ts_operators.ts_id::character varying = ts_report_def_param_values.ts_value 
and ts_report_def_param_values.ts_param_key_id='2';
-- End upgrading ts_report_def_param_values 

-- upgrading ts_transets
alter table ts_transets alter column ts_creator_id drop not null;
alter table ts_transets add column ts_creator_name varchar(200) not null DEFAULT 'cemsystem';

alter table ts_transets drop constraint FK865CB7BC1F3F4799;
--select execute($$alter table ts_transets drop constraint FK865CB7BC1F3F4799$$) where exists (
--select pc.conname from pg_constraint pc , pg_class pcl where pc.conname = 'FK865CB7BC1F3F4799'
--	and pcl.relname = 'ts_transets'	and pcl.oid = pc.conrelid );

alter table ts_transets alter column ts_last_modifier_id drop not null;
alter table ts_transets add column ts_last_modifier_name varchar(200) not null DEFAULT 'cemsystem';

alter table ts_transets drop constraint FK865CB7BC1F3F479A;
--select execute($$alter table ts_transets drop constraint FK865CB7BC1F3F479A$$) where exists (
--select pc.conname from pg_constraint pc , pg_class pcl where pc.conname = 'FK865CB7BC1F3F479A'
--	and pcl.relname = 'ts_transets'	and pcl.oid = pc.conrelid );

-- update ts_creator_name with the name of the operator
update ts_transets set ts_creator_name = ts_operators.ts_username from ts_operators
where ts_transets.ts_creator_id = ts_operators.ts_id;
-- update ts_last_modifier_name with the name of the operator
update ts_transets set ts_last_modifier_name = ts_operators.ts_username from ts_operators
where ts_transets.ts_last_modifier_id = ts_operators.ts_id;
-- End upgrading ts_transets


-- introducing hourly aggregation table
CREATE TABLE ts_hourly_aggregation_log
(
  ts_id bigint NOT NULL,
  version_info bigint NOT NULL,
  ts_start_time timestamp without time zone NOT NULL,
  ts_end_time timestamp without time zone,
  ts_completed boolean,
  ts_soft_delete boolean NOT NULL,
  primary key (ts_id)
);



--update tang_event_types table to rename TESS to Enterprise Manager
update tang_event_types
set ts_name='Enterprise Manager cannot reach TIM'
where ts_name='Tess cannot reach Tim';

update tang_event_types
set ts_name='Enterprise Manager restarted'
where ts_name='Tess restarted';

update tang_event_types
set ts_name='TIM restarted'
where ts_name='Tim restarted';

update tang_event_types
set ts_name='Business application name is not valid'
where ts_name='Application name is not valid';

update tang_event_types
set ts_name='Transaction definitions dropped'
where ts_name='Transaction Definitions dropped';

update ts_introscope_ems set ts_tran_trace_duration = 30;
update ts_introscope_ems set ts_tran_trace_threshold_percentage = 50;


--renaming the columns

ALTER TABLE ts_domains RENAME COLUMN ts_infrastructure_event_ageout TO ts_infrastruct_event_ageout;
ALTER TABLE ts_domains RENAME COLUMN ts_infrastructure_defect_delete TO ts_infrastruct_defect_delete;
ALTER TABLE ts_domains RENAME COLUMN ts_usergroup_interval_stats_discard_time TO ts_usgrp_intrvl_st_dscrd_time;
ALTER TABLE ts_domains RENAME COLUMN ts_usergroup_daily_stats_discard_time TO ts_usgrp_dly_st_dscrd_time;
ALTER TABLE ts_domains RENAME COLUMN ts_usergroup_weekly_stats_discard_time TO ts_usgrp_wkly_st_dscrd_time;
ALTER TABLE ts_domains RENAME COLUMN ts_ignore_apps_in_user_recognition	TO ts_ignore_apps_in_user_recogn;
ALTER TABLE ts_domains RENAME COLUMN ts_filter_defects_subnets_enabled TO ts_filter_defects_subnets_on;
ALTER TABLE ts_domains RENAME COLUMN ts_new_ip_user_groups_enabled TO ts_new_ip_us_grps_enabled;
ALTER TABLE ts_domains RENAME COLUMN ts_stats_interval_duration_mins TO ts_stats_intrvl_duration_mins;

ALTER TABLE ts_introscope_ems RENAME COLUMN ts_tran_trace_threshold_percentage TO ts_tran_trace_threshold_percnt;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_url_host      TO   ts_case_senstv_url_host;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_url_path      TO   ts_case_senstv_url_path;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_query_name    TO   ts_case_senstv_query_name;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_query_value   TO   ts_case_senstv_query_value;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_cookie_name   TO   ts_case_senstv_cookie_name;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_cookie_value  TO   ts_case_senstv_cookie_value;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_post_name     TO   ts_case_senstv_post_name;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_post_value    TO   ts_case_senstv_post_value;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_login_name    TO   ts_case_senstv_login_name;

--Dropping constraints 
--(changing postgres schema to make it synchronized with oracle schema. Reason to change it for oracle -see TT issue 62079)

ALTER TABLE ts_user_sessions_map DROP CONSTRAINT ts_user_sessions_map_pkey;
ALTER TABLE ts_user_sessions_map ADD CONSTRAINT ts_user_sessions_map_ukey UNIQUE(ts_app_id, ts_session_id, ts_interim_session_id);
ALTER TABLE ts_user_sessions_map ALTER COLUMN ts_interim_session_id DROP NOT NULL;
ALTER TABLE ts_audit_record_props ALTER COLUMN 	ts_old_value DROP NOT NULL;
ALTER TABLE ts_audit_record_props ALTER COLUMN 	ts_new_value DROP NOT NULL;
ALTER TABLE ts_introscope_ems ALTER COLUMN 	ts_web_view_version DROP NOT NULL;
ALTER TABLE ts_operators ALTER COLUMN ts_password DROP NOT NULL;
ALTER TABLE ts_plugin_url_filter ALTER COLUMN ts_url_filter DROP NOT NULL;
ALTER TABLE ts_params ALTER COLUMN ts_original_value DROP NOT NULL;
ALTER TABLE ts_settings ALTER COLUMN ts_value DROP NOT NULL;
ALTER TABLE ts_trancomps ALTER COLUMN ts_url DROP NOT NULL;
ALTER TABLE ts_users ALTER COLUMN ts_first_name DROP NOT NULL;
ALTER TABLE ts_users ALTER COLUMN ts_last_name DROP NOT NULL;
ALTER TABLE ts_web_servers ALTER COLUMN ts_mac_address DROP NOT NULL;
ALTER TABLE tang_config ALTER COLUMN ts_value DROP NOT NULL;


--auto script

-- tang_events

ALTER TABLE tang_events ALTER COLUMN ts_source_ip_address TYPE VARCHAR(39);

-- tang_event_types

ALTER TABLE tang_event_types ALTER COLUMN version_info DROP DEFAULT;

-- ts_apps

ALTER TABLE ts_apps ALTER COLUMN ts_case_senstv_url_host SET DEFAULT TRUE;
ALTER TABLE ts_apps ALTER COLUMN ts_case_senstv_cookie_name SET DEFAULT TRUE;

-- ts_attributes

ALTER TABLE ts_attributes ALTER COLUMN ts_tran_type TYPE INT8;
ALTER TABLE ts_attributes ALTER COLUMN ts_protocol_type TYPE INT8;


-- ts_defect_defs
ALTER TABLE ts_defect_defs ALTER COLUMN ts_attribute_id SET NOT NULL;

-- ts_domains

ALTER TABLE ts_domains ALTER COLUMN ts_interval_stats_discard_time SET DEFAULT 3;
ALTER TABLE ts_domains ALTER COLUMN ts_daily_stats_discard_time SET DEFAULT 15;
ALTER TABLE ts_domains ALTER COLUMN ts_weekly_stats_discard_time SET DEFAULT 27;
ALTER TABLE ts_domains ALTER COLUMN ts_usgrp_intrvl_st_dscrd_time SET DEFAULT 3;
ALTER TABLE ts_domains ALTER COLUMN ts_usgrp_dly_st_dscrd_time SET DEFAULT 15;
ALTER TABLE ts_domains ALTER COLUMN ts_usgrp_wkly_st_dscrd_time SET DEFAULT 27;

-- ts_introscope_ems

ALTER TABLE ts_introscope_ems ALTER COLUMN ts_tran_trace_duration SET DEFAULT 30;
ALTER TABLE ts_introscope_ems ALTER COLUMN ts_tran_trace_threshold_percnt SET DEFAULT 50;

-- ts_monitors

ALTER TABLE ts_monitors ALTER COLUMN ts_synchronized DROP NOT NULL;

-- ts_protocols

ALTER TABLE ts_protocols ALTER COLUMN ts_id TYPE BIGINT;

-- ts_transets

ALTER TABLE ts_transets ALTER COLUMN ts_total_captures TYPE INT4;


-- ts_tran_types

ALTER TABLE ts_tran_types ALTER COLUMN ts_id TYPE int8;

--auto script

--existing script1

--adding new indexes

create index ts_st_tgrp_us_dly_UsrIncIdIdx on ts_stats_tsgrp_us_daily (ts_user_incarnation_id);
create index ts_st_tsgrp_us_mtly_UsrInIdIdx on ts_stats_tsgrp_us_monthly (ts_user_incarnation_id);
create index ts_st_tsgrp_us_wkly_UsrInIdIdx on ts_stats_tsgrp_us_weekly (ts_user_incarnation_id);
create index ts_st_ts_us_itvl_TSIncIdIdx on ts_stats_ts_us_interval (ts_transet_incarnation_id);
create index ts_st_ts_us_mtly_TSIncIdIdx on ts_stats_ts_us_monthly (ts_transet_incarnation_id);
create index ts_st_ts_us_wkly_TSIncIdIdx on ts_stats_ts_us_weekly (ts_transet_incarnation_id);
CREATE INDEX ts_defects_UserIncIdIdx ON ts_defects USING btree (ts_user_incarnation_id ASC NULLS LAST) TABLESPACE pg_default;
CREATE INDEX ts_defects_eventIdx ON ts_defects USING btree (ts_biz_event_id);
CREATE INDEX ts_biz_events_versioninfoIdx ON ts_biz_events USING btree (version_info ASC NULLS LAST) TABLESPACE pg_default;


--renaming the indexes

ALTER INDEX	  ts_audit_record_props_AuditIndex  	RENAME TO	 ts_audit_record_props_AuditIdx ;
ALTER INDEX	  ts_audit_records_KeyIndex  	RENAME TO	  ts_audit_records_KeyIdx ;
ALTER INDEX	  ts_audit_records_OperatorIndex  	RENAME TO	  ts_audit_records_OperatorIdx ;
ALTER INDEX	  ts_biz_events_DefectIndex  	RENAME TO	  ts_biz_events_DefectIdx;
ALTER INDEX	  ts_biz_events_StatusIndex  	RENAME TO	  ts_biz_events_StatusIdx;
ALTER INDEX	  ts_biz_events_TransetIncarnationIdIndex  	RENAME TO	  ts_biz_events_TSIncrnIdIdx;
ALTER INDEX	  ts_biz_events_TransetIdIndex  	RENAME TO	  ts_biz_events_TSIdIdx;
ALTER INDEX	  ts_cached_reports_EndTimeIndex  	RENAME TO	  ts_cached_reports_EndTimeIdx;
ALTER INDEX	  ts_cached_reports_LastAccessTimeIndex  	RENAME TO	  ts_cached_rprts_LstAcsTimeIdx;
ALTER INDEX	  ts_cached_reports_ReportPathIndex  	RENAME TO	  ts_cached_reports_RprtPathIdx;
ALTER INDEX	  ts_cached_reports_StartTimeIndex  	RENAME TO	  ts_cached_reports_StTimeIdx;
ALTER INDEX	  ts_defect_defs_TranunitIndex  	RENAME TO	  ts_defect_defs_TranunitIdx;
ALTER INDEX	  ts_defect_defs_TransetIndex  	RENAME TO	  ts_defect_defs_TSIdx;
ALTER INDEX	  ts_defects_interval_DateIndex  	RENAME TO	  ts_defects_interval_DateIdx;
ALTER INDEX	  ts_defects_interval_DefectIndex  	RENAME TO	  ts_defects_interval_DefectIdx;
ALTER INDEX	  ts_defects_interval_EventIndex  	RENAME TO	  ts_defects_interval_EventIdx;
ALTER INDEX	  ts_defects_interval_TranSetIndex  	RENAME TO	  ts_defects_interval_TSIdx;
ALTER INDEX	  ts_defects_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_defects_itvl_TSIncrnIdIdx;
ALTER INDEX	  ts_defects_interval_UserIndex  	RENAME TO	  ts_defects_itvl_UserIdx;
ALTER INDEX	  ts_defects_interval_UserIncarnationIdIndex  	RENAME TO	  ts_defects_itvl_UserIncIdIdx;
ALTER INDEX	  ts_login_id_parameters_AppIdIndex  	RENAME TO	  ts_login_id_parms_AppIdIdx;
ALTER INDEX	  ts_operator_role_map_OperatorIdIndex  	RENAME TO	  ts_oper_role_map_OperIdIdx;
ALTER INDEX	  ts_operator_role_map_RoleIdIndex  	RENAME TO	  ts_operator_role_map_RoleIdIdx;
ALTER INDEX	  ts_params_TranCompIdIndex  	RENAME TO	  ts_params_TranCompIdIdx;
ALTER INDEX	  ts_recording_components_RecordingIdIndex  	RENAME TO	  ts_record_components_RecordIdx;
ALTER INDEX	  ts_recording_components_SequenceNumberIndex  	RENAME TO	  ts_recording_comp_SeqNumberIdx;
ALTER INDEX	  ts_report_def_param_value_ParamKeyIndex  	RENAME TO	  ts_rprt_def_prm_val_PrmKeyIdx;
ALTER INDEX	  ts_report_def_param_value_ReportDefIndex  	RENAME TO	  ts_rprt_def_prm_val_RprtDefIdx;
ALTER INDEX	  ts_report_type_param_value_ParamKeyIndex  	RENAME TO	  ts_rprt_type_prm_val_PrmKeyIdx;
ALTER INDEX	  ts_report_type_param_value_ReportTypeIndex  	RENAME TO	  ts_rprttype_prmval_RprtTypeIdx;
ALTER INDEX	  ts_session_id_parameters_AppIdIndex  	RENAME TO	  ts_session_id_parms_AppIdIdx;
ALTER INDEX	  ts_settings_KeyIndex  	RENAME TO	  ts_settings_KeyIdx;
ALTER INDEX	  ts_sm_policy_servers_SmGroupIdIndex  	RENAME TO	  ts_sm_plcy_servers_SmGrpIdIdx;
ALTER INDEX	  ts_sm_web_servers_SmGroupIdIndex  	RENAME TO	  ts_sm_web_servers_SmGroupIdIdx;
ALTER INDEX	  ts_stats_transet_all_daily_DayIndex  	RENAME TO	  ts_st_ts_all_dly_DayIdx;
ALTER INDEX	  ts_stats_transet_all_daily_HourIndex  	RENAME TO	  ts_st_ts_all_dly_HourIdx;
ALTER INDEX	  ts_stats_transet_all_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_all_dly_LAggRow;
ALTER INDEX	  ts_stats_transet_all_daily_MonthIndex  	RENAME TO	  ts_st_ts_all_dly_MonthIdx;
ALTER INDEX	  ts_stats_transet_all_daily_StartTimeIndex  	RENAME TO	  ts_st_ts_all_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_all_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_dly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_all_daily_TranSetIndex  	RENAME TO	  ts_st_ts_all_dly_TSIdx;
ALTER INDEX	  ts_stats_transet_all_daily_WeekIndex  	RENAME TO	  ts_st_ts_all_dly_WeekIdx;
ALTER INDEX	  ts_stats_transet_all_daily_YearIndex  	RENAME TO	  ts_st_ts_all_dly_YearIdx;
ALTER INDEX	  ts_stats_transet_all_interval_DayIndex  	RENAME TO	  ts_st_ts_all_itvl_DayIdx;
ALTER INDEX	  ts_stats_transet_all_interval_HourIndex  	RENAME TO	  ts_st_ts_all_itvl_HourIdx;
ALTER INDEX	  ts_stats_transet_all_interval_LastAggregatedRowIndex	RENAME TO	  ts_st_ts_all_itvl_LastAggRwIdx;
ALTER INDEX	  ts_stats_transet_all_interval_MonthIndex  	RENAME TO	  ts_st_ts_all_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transet_all_interval_StartTimeIndex  	RENAME TO	  ts_st_ts_all_itvl_StTimeIdx;
ALTER INDEX	  ts_stats_transet_all_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_itvl_TSInIdIdx;
ALTER INDEX	  ts_stats_transet_all_interval_TranSetIndex  	RENAME TO	  ts_st_ts_all_itvl_TSIdx ;
ALTER INDEX	  ts_stats_transet_all_interval_WeekIndex  	RENAME TO	  ts_st_ts_all_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_transet_all_interval_YearIndex  	RENAME TO	  ts_st_ts_all_itvl_YearIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_DayIndex  	RENAME TO	  ts_st_ts_all_mtly_DayIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_HourIndex  	RENAME TO	  ts_st_ts_all_mtly_HourIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_all_mtly_LastAggRwIdx;
ALTER INDEX	  ts_stats_transet_all_monthly_MonthIndex  	RENAME TO	  ts_st_ts_all_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_StartTimeIndex  	RENAME TO	  ts_st_ts_all_mtly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_mtly_TSInIdIdx;
ALTER INDEX	  ts_stats_transet_all_monthly_TranSetIndex  	RENAME TO	  ts_st_ts_all_mtly_TSIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_WeekIndex  	RENAME TO	  ts_st_ts_all_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_YearIndex  	RENAME TO	  ts_st_ts_all_mtly_YearIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_DayIndex  	RENAME TO	  ts_st_ts_all_wkly_DayIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_HourIndex  	RENAME TO	  ts_st_ts_all_wkly_HourIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_all_wkly_LastAggRwIdx;
ALTER INDEX	  ts_stats_transet_all_weekly_MonthIndex  	RENAME TO	  ts_st_ts_all_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_StartTimeIndex  	RENAME TO	  ts_st_ts_all_wkly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_wkly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_transet_all_weekly_TranSetIndex  	RENAME TO	ts_st_ts_all_wkly_TSIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_WeekIndex  	RENAME TO	  ts_st_ts_all_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_YearIndex  	RENAME TO	  ts_st_ts_all_wkly_YearIdx ;
ALTER INDEX	  ts_stats_transetgroup_all_daily_DayIndex  	RENAME TO	  ts_st_tsgrp_all_dly_DayIdx ;
ALTER INDEX	  ts_stats_transetgroup_all_daily_HourIndex  	RENAME TO	  ts_st_tsgrp_all_dly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_dly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_dly_MonthIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_daily_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_dly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_dly_WeekIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_daily_YearIndex  	RENAME TO	  ts_st_tsgrp_all_dly_YearIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_interval_DayIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_DayIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_interval_HourIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_LAgRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_YearIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_DayIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_HourIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_LAgRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_YearIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_DayIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_HourIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_LAgRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_YearIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_DayIndex  	RENAME TO	  ts_st_tsgrp_us_dly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_HourIndex  	RENAME TO	  ts_st_tsgrp_us_dly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_dly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_dly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_us_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_dly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_UserIndex  	RENAME TO	  ts_st_tsgrp_us_dly_UserIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_dly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_YearIndex  	RENAME TO	  ts_st_tsgrp_us_dly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_LAgRwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_STimeIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_UsGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_WeekIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_HrIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_LARwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_MnthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_StTmIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_TSGpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_UsGpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_WeekIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_LARwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_MnthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_STmIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_TSGIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_UsGIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_WeekIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_WkIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_YrIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_LARwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_MnthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_STmIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_TSGIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_UGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_WeekIndex  	RENAME TO	ts_st_tsgrp_usgrp_wkly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_DayIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_HourIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_StartIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_StartIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_UserIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_UserIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_YearIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_DayIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_HourIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_UserIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_UserIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_YearIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_YearIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_DayIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_DayIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_HourIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_HourIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_STimeIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_UserIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_UserIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_YearIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_DayIndex  	RENAME TO	  ts_st_ts_us_dly_DayIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_HourIndex  	RENAME TO	  ts_st_ts_us_dly_HourIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_us_dly_LAggRow;
ALTER INDEX	  ts_stats_transet_user_daily_MonthIndex  	RENAME TO	  ts_st_ts_us_dly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_StartTimeIndex  	RENAME TO	  ts_st_ts_us_dly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_dly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_transet_user_daily_TranSetIndex  	RENAME TO	  ts_st_ts_us_dly_TSIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_dly_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_daily_UserIndex  	RENAME TO	  ts_st_ts_us_dly_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_WeekIndex  	RENAME TO	  ts_st_ts_us_dly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_YearIndex  	RENAME TO	  ts_st_ts_us_dly_YearIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_DayIndex  	RENAME TO	  ts_st_ts_usgrp_dly_DayIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_HourIndex  	RENAME TO	  ts_st_ts_usgrp_dly_HourIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_dly_LAggRowIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_MonthIndex  	RENAME TO	  ts_st_ts_usgrp_dly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_dly_TSIncrIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_dly_TSIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_UserGroupIndex  	RENAME TO	  ts_st_ts_usgrp_dly_UserGrpIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_dly_WeekIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_YearIndex  	RENAME TO	  ts_st_ts_usgrp_dly_YearIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_DayIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_DayIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_GroupIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_GroupIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_HourIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_HourIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_LAggRowIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_MonthIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_STimeIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_TSIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_YearIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_YearIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_DayIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_DayIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_HourIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_HourIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_LAggRowIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_MonthIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_MonthIdx 	;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_STimeIdx 	;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_TSIdx 	;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_UserGroupIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_UserGrpIdx;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_WeekIdx;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_YearIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_YearIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_DayIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_DayIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_HourIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_HourIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_LAggRow;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_MonthIndex  	RENAME TO	ts_st_ts_usgrp_wkly_MonthIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_TSIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_UserGroupIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_UsGrpIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_YearIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_DayIndex  	RENAME TO	  ts_st_ts_us_itvl_DayIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_HourIndex  	RENAME TO	  ts_st_ts_us_itvl_HourIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_MonthIndex  	RENAME TO	  ts_st_ts_us_itvl_MonthIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_StartTime  	RENAME TO	  ts_st_ts_us_itvl_StTime ;
ALTER INDEX	  ts_stats_transet_user_interval_TranSetIndex  	RENAME TO	  ts_st_ts_us_itvl_TSIdx 	;
ALTER INDEX	  ts_stats_transet_user_interval_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_itvl_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_interval_UserIndex  	RENAME TO	  ts_st_ts_us_itvl_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_WeekIndex  	RENAME TO	  ts_st_ts_us_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_YearIndex  	RENAME TO	  ts_st_ts_us_itvl_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_DayIndex  	RENAME TO	  ts_st_ts_us_mtly_DayIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_HourIndex  	RENAME TO	  ts_st_ts_us_mtly_HourIdx ;
ALTER INDEX	 ts_stats_transet_user_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_us_mtly_LAggRow;
ALTER INDEX	  ts_stats_transet_user_monthly_MonthIndex  	RENAME TO	  ts_st_ts_us_mtly_MonthIdx 	;
ALTER INDEX	  ts_stats_transet_user_monthly_StartTimeIndex  	RENAME TO	  ts_st_ts_us_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_user_monthly_TranSetIndex  	RENAME TO	  ts_st_ts_us_mtly_TSIdx 	;
ALTER INDEX	  ts_stats_transet_user_monthly_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_mtly_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_monthly_UserIndex  	RENAME TO	  ts_st_ts_us_mtly_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_WeekIndex  	RENAME TO	  ts_st_ts_us_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_YearIndex  	RENAME TO	  ts_st_ts_us_mtly_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_DayIndex  	RENAME TO	  ts_st_ts_us_wkly_DayIdx;
ALTER INDEX	  ts_stats_transet_user_weekly_HourIndex  	RENAME TO	  ts_st_ts_us_wkly_HourIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_us_wkly_LAggRow;
ALTER INDEX	  ts_stats_transet_user_weekly_MonthIndex  	RENAME TO	  ts_st_ts_us_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_StartTimeIndex  	RENAME TO	  ts_st_ts_us_wkly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_TranSetIndex  	RENAME TO	  ts_st_ts_us_wkly_TSIdx 	;
ALTER INDEX	  ts_stats_transet_user_weekly_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_wkly_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_weekly_UserIndex  	RENAME TO	  ts_st_ts_us_wkly_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_WeekIndex  	RENAME TO	  ts_st_ts_us_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_YearIndex  	RENAME TO	  ts_st_ts_us_wkly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_DayIndex  	RENAME TO	  ts_st_tu_all_dly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_HourIndex  	RENAME TO	  ts_st_tu_all_dly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_dly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_daily_MonthIndex  	RENAME TO	  ts_st_tu_all_dly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_StartTimeIndex  	RENAME TO	  ts_st_tu_all_dly_StTimeIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_dly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_daily_TranSetIndex  	RENAME TO	  ts_st_tu_all_dly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_TranUnitIndex  	RENAME TO	  ts_st_tu_all_dly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_WeekIndex  	RENAME TO	  ts_st_tu_all_dly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_YearIndex  	RENAME TO	  ts_st_tu_all_dly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_DayIndex  	RENAME TO	  ts_st_tu_all_itvl_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_HourIndex  	RENAME TO	  ts_st_tu_all_itvl_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_itvl_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_interval_MonthIndex  	RENAME TO	  ts_st_tu_all_itvl_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_StartTimeIndex  	RENAME TO	  ts_st_tu_all_itvl_StTimeIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_itvl_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_interval_TranSetIndex  	RENAME TO	  ts_st_tu_all_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_TranUnitIndex  	RENAME TO	  ts_st_tu_all_itvl_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_WeekIndex  	RENAME TO	  ts_st_tu_all_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_YearIndex  	RENAME TO	  ts_st_tu_all_itvl_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_DayIndex  	RENAME TO	  ts_st_tu_all_mtly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_HourIndex  	RENAME TO	  ts_st_tu_all_mtly_HourIdx;
ALTER INDEX	  ts_stats_tranunit_all_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_mtly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_monthly_MonthIndex  	RENAME TO	  ts_st_tu_all_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_StartTimeIndex  	RENAME TO	  ts_st_tu_all_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_all_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_mtly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_monthly_TranSetIndex  	RENAME TO	  ts_st_tu_all_mtly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_TranUnitIndex  	RENAME TO	  ts_st_tu_all_mtly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_WeekIndex  	RENAME TO	  ts_st_tu_all_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_YearIndex  	RENAME TO	  ts_st_tu_all_mtly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_DayIndex  	RENAME TO	  ts_st_tu_all_wkly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_HourIndex  	RENAME TO	  ts_st_tu_all_wkly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_wkly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_weekly_MonthIndex  	RENAME TO	  ts_st_tu_all_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_StartTimeIndex  	RENAME TO	  ts_st_tu_all_wkly_StTimeIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_wkly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_weekly_TranSetIndex  	RENAME TO	  ts_st_tu_all_wkly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_TranUnitIndex  	RENAME TO	  ts_st_tu_all_wkly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_WeekIndex  	RENAME TO	  ts_st_tu_all_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_YearIndex  	RENAME TO	  ts_st_tu_all_wkly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_DayIndex  	RENAME TO	  ts_st_tu_us_dly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_HourIndex  	RENAME TO	  ts_st_tu_us_dly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_us_dly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_user_daily_MonthIndex  	RENAME TO	  ts_st_tu_us_dly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_StartTime  	RENAME TO	  ts_st_tu_us_dly_StTime ;
ALTER INDEX	  ts_stats_tranunit_user_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_dly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_daily_TranSetIndex  	RENAME TO	  ts_st_tu_us_dly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_TranUnitIndex  	RENAME TO	  ts_st_tu_us_dly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_dly_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_daily_UserIndex  	RENAME TO	  ts_st_tu_us_dly_UserIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_WeekIndex  	RENAME TO	  ts_st_tu_us_dly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_YearIndex  	RENAME TO	  ts_st_tu_us_dly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_DayIndex  	RENAME TO	  ts_st_tu_usgrp_dly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_HourIndex  	RENAME TO	  ts_st_tu_usgrp_dly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_dly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_dly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_dly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_dly_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_TranSetIndex  	RENAME TO	  ts_st_tu_usgrp_dly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_dly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_dly_UsGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_dly_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_YearIndex  	RENAME TO	  ts_st_tu_usgrp_dly_YearIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_DayIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_HourIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_LAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_MonthIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_TranSetIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_UsGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_YearIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_YearIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_DayIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_DayIdx;
ALTER INDEX	ts_stats_tranunit_usergroup_monthly_HourIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_HourIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_LastAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_MonthIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_TranSetIndex  	RENAME TO	ts_st_tu_usgrp_mtly_TSIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_TUIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_UserGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_WeekIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_YearIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_YearIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_DayIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_DayIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_HourIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_HourIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_MonthIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_TranSetIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_TSIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_TUIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_UserGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_YearIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_YearIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_DayIndex  	RENAME TO	  ts_st_tu_us_itvl_DayIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_HourIndex  	RENAME TO	  ts_st_tu_us_itvl_HourIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_MonthIndex  	RENAME TO	  ts_st_tu_us_itvl_MonthIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_StartTime  	RENAME TO	  ts_st_tu_us_itvl_StTime;
ALTER INDEX	  ts_stats_tranunit_user_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_itvl_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_TranSetIndex  	RENAME TO	  ts_st_tu_us_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_user_interval_TranUnitIndex  	RENAME TO	  ts_st_tu_us_itvl_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_user_interval_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_itvl_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_UserIndex  	RENAME TO	  ts_st_tu_us_itvl_UserIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_WeekIndex  	RENAME TO	  ts_st_tu_us_itvl_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_YearIndex  	RENAME TO	  ts_st_tu_us_itvl_YearIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_DayIndex  	RENAME TO	  ts_st_tu_us_mtly_DayIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_HourIndex  	RENAME TO	  ts_st_tu_us_mtly_HourIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_us_mtly_LAggRow ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_MonthIndex  	RENAME TO	  ts_st_tu_us_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_StartTime  	RENAME TO	  ts_st_tu_us_mtly_StTime ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_mtly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_TranSetIndex  	RENAME TO	  ts_st_tu_us_mtly_TSIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_TranUnitIndex  	RENAME TO	  ts_st_tu_us_mtly_TUIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_mtly_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_UserIndex  	RENAME TO	  ts_st_tu_us_mtly_UserIdx ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_WeekIndex  	RENAME TO	  ts_st_tu_us_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_YearIndex  	RENAME TO	  ts_st_tu_us_mtly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_DayIndex  	RENAME TO	  ts_st_tu_us_wkly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_HourIndex  	RENAME TO	  ts_st_tu_us_wkly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_us_wkly_LastAggRow;
ALTER INDEX	  ts_stats_tranunit_user_weekly_MonthIndex  	RENAME TO	  ts_st_tu_us_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_StartTime  	RENAME TO	  ts_st_tu_us_wkly_StTime ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_wkly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_weekly_TranSetIndex  	RENAME TO	  ts_st_tu_us_wkly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_TranUnitIndex  	RENAME TO	  ts_st_tu_us_wkly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_wkly_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_weekly_UserIndex  	RENAME TO	  ts_st_tu_us_wkly_UserIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_WeekIndex  	RENAME TO	  ts_st_tu_us_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_YearIndex  	RENAME TO	  ts_st_tu_us_wkly_YearIdx ;
ALTER INDEX	  ts_stats_tran_user_interval_StartTimeIndex  	RENAME TO	  ts_st_t_us_itvl_StTimeIdx ;
ALTER INDEX	  ts_stats_tran_user_interval_TranSetIndex  	RENAME TO	  ts_st_t_us_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tran_user_interval_TranUnitIndex  	RENAME TO	  ts_st_t_us_itvl_TUIdx ;
ALTER INDEX	  ts_stats_tran_user_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_t_us_itvl_TSIncrnIdx;
ALTER INDEX	  ts_trancomps_TranunitIndex  	RENAME TO	  ts_trancomps_TranunitIdx ;
ALTER INDEX	  ts_transetgroup_transets_map_TranSetGroupIdIndex  	RENAME TO	  ts_tsgrp_ts_map_TSGroupIdIdx;
ALTER INDEX	  ts_transetgroup_transets_map_TranSetIdIndex  	RENAME TO	  ts_tsgrp_ts_map_TSIdIdx ;
ALTER INDEX	  ts_transetgroup_transets_map_TranSetIncarnationIndex  	RENAME TO	  ts_tsgrp_ts_map_TSIncrnIdx;
ALTER INDEX	  ts_transets_AppIndex  	RENAME TO	  ts_transets_AppIdx ;
ALTER INDEX	  ts_transets_IncarnationIndex  	RENAME TO	  ts_transets_IncrnIdx;
ALTER INDEX	  ts_tranunits_TransetIndex  	RENAME TO	  ts_tranunits_TsIdx ;
ALTER INDEX	  ts_user_groups_DefGroupIndex  	RENAME TO	  ts_user_groups_DefGroupIdx ;
ALTER INDEX	  ts_user_groups_GroupByIndex  	RENAME TO	  ts_user_groups_GroupByIdx ;
ALTER INDEX	  ts_usergroup_transets_slas_TranSetIndex  	RENAME TO	  ts_usgrp_ts_slas_TSIdx ;
ALTER INDEX	  ts_usergroup_transets_slas_UserGroupIndex  	RENAME TO	  ts_usgrp_ts_slas_UsGrpIdx ;
ALTER INDEX	  ts_usergroup_users_map_UserGroupIndex  	RENAME TO	  ts_usgrp_users_map_UsGrpIdx ;
ALTER INDEX	  ts_usergroup_users_map_UserIncarnationIndex  	RENAME TO	  ts_usgrp_users_map_UsIncIdx ;
ALTER INDEX	  ts_usergroup_users_map_UserIndex  	RENAME TO	  ts_usgrp_users_map_UserIdx ;
ALTER INDEX	  ts_user_logins_map_AppIndex  	RENAME TO	  ts_user_logins_map_AppIdx ;
ALTER INDEX	  ts_user_logins_map_NameIndex  	RENAME TO	  ts_user_logins_map_NameIdx ;
ALTER INDEX	  ts_user_logins_map_UserIndex  	RENAME TO	  ts_user_logins_map_UserIdx ;
ALTER INDEX	  ts_user_sessions_map_AppIndex  	RENAME TO	  ts_us_ses_map_AppIdx ;
ALTER INDEX	  ts_user_sessions_map_InterimSessionIdIndex  	RENAME TO	  ts_us_ses_map_InterimSesIdIdx;
ALTER INDEX	  ts_user_sessions_map_SessionIdIndex  	RENAME TO	  ts_us_ses_map_SessionIdIdx;
ALTER INDEX	  ts_users_IncarnationIndex  	RENAME TO	  ts_users_IncrnIdx ;
ALTER INDEX	  ts_users_UserDefGroupIndex  	RENAME TO	  ts_users_UserDefGroupIdx ;
ALTER INDEX	  ts_web_servers_MonitorIndex  	RENAME TO	  ts_web_servers_MonitorIdx ;


--upgrading the sequences

ALTER SEQUENCE tang_events_ts_id_seq RENAME TO  	tang_events_ts_id_sq;  

--upgrading the views

ALTER VIEW TranSetGroupSlaPerformanceTimeSlaView RENAME TO TSGrpSlaPerfTimeSlaVw;
ALTER VIEW UserGroupSlaPerformanceTimeSlaView RENAME TO UsGrpSlaPerfTimeSlaVw;
ALTER VIEW view_biz_event_metadata RENAME TO vw_biz_event_metadata;
ALTER VIEW view_defect_app_server_time RENAME TO vw_defect_app_server_time;
ALTER VIEW view_defect_brta_time RENAME TO vw_defect_brta_time;
ALTER VIEW view_defect_slowest_lowest_comp_time	 RENAME TO vw_defect_slowlow_comptime;
ALTER VIEW view_defect_slowest_lowest_back_comp_time RENAME TO 	vw_defect_slowlow_backcomptime;

--creating sequences

-- This file creates the sequences required for the 
-- Primary Key generation of the tables
CREATE SEQUENCE tang_events_ts_id_sq; 
ALTER SEQUENCE tang_events_ts_id_sq OWNED BY tang_events.ts_id;
ALTER TABLE tang_events ALTER COLUMN ts_id SET DEFAULT nextval('tang_events_ts_id_sq');

CREATE SEQUENCE ts_app_auth_types_ts_id_sq; 
ALTER SEQUENCE ts_app_auth_types_ts_id_sq OWNED BY ts_app_auth_types.ts_id;
ALTER TABLE ts_app_auth_types ALTER COLUMN ts_id SET DEFAULT nextval('ts_app_auth_types_ts_id_sq');

CREATE SEQUENCE ts_app_types_ts_id_sq;
ALTER SEQUENCE ts_app_types_ts_id_sq OWNED BY ts_app_types.ts_id;
ALTER TABLE ts_app_types ALTER COLUMN ts_id SET DEFAULT nextval('ts_app_types_ts_id_sq');

CREATE SEQUENCE ts_apps_ts_id_sq;
ALTER SEQUENCE ts_apps_ts_id_sq OWNED BY ts_apps.ts_id;
ALTER TABLE ts_apps ALTER COLUMN ts_id SET DEFAULT nextval('ts_apps_ts_id_sq');
-- This is for the StaggeredAPMUpgrade feature ... to avoid conflicts when merging DBs
ALTER SEQUENCE ts_apps_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_attributes_ts_id_sq;
ALTER SEQUENCE ts_attributes_ts_id_sq OWNED BY ts_attributes.ts_id;
ALTER TABLE ts_attributes ALTER COLUMN ts_id SET DEFAULT nextval('ts_attributes_ts_id_sq');

CREATE SEQUENCE ts_audit_rcrd_props_ts_id_sq ;
ALTER SEQUENCE ts_audit_rcrd_props_ts_id_sq  OWNED BY ts_audit_record_props.ts_id;
ALTER TABLE ts_audit_record_props ALTER COLUMN ts_id SET DEFAULT nextval('ts_audit_rcrd_props_ts_id_sq ');

CREATE SEQUENCE ts_audit_records_ts_id_sq ;
ALTER SEQUENCE ts_audit_records_ts_id_sq  OWNED BY ts_audit_records.ts_id;
ALTER TABLE ts_audit_records ALTER COLUMN ts_id SET DEFAULT nextval('ts_audit_records_ts_id_sq ');

CREATE SEQUENCE ts_autogen_tmplt_ts_id_sq;
ALTER SEQUENCE ts_autogen_tmplt_ts_id_sq OWNED BY ts_autogen_template.ts_id;
ALTER TABLE ts_autogen_template ALTER COLUMN ts_id SET DEFAULT nextval('ts_autogen_tmplt_ts_id_sq');

CREATE SEQUENCE ts_biz_events_ts_id_sq;
ALTER SEQUENCE ts_biz_events_ts_id_sq OWNED BY ts_biz_events.ts_id;
ALTER TABLE ts_biz_events ALTER COLUMN ts_id SET DEFAULT nextval('ts_biz_events_ts_id_sq');

CREATE SEQUENCE ts_cached_reports_ts_id_sq;
ALTER SEQUENCE ts_cached_reports_ts_id_sq OWNED BY ts_cached_reports.ts_id;
ALTER TABLE ts_cached_reports ALTER COLUMN ts_id SET DEFAULT nextval('ts_cached_reports_ts_id_sq');

CREATE SEQUENCE ts_child_servc_def_ts_id_sq;
ALTER SEQUENCE ts_child_servc_def_ts_id_sq OWNED BY ts_child_services_def.ts_id;
ALTER TABLE ts_child_services_def ALTER COLUMN ts_id SET DEFAULT nextval('ts_child_servc_def_ts_id_sq');

CREATE SEQUENCE ts_concur_sessions_ts_id_sq;
ALTER SEQUENCE ts_concur_sessions_ts_id_sq OWNED BY ts_concurrent_sessions.ts_id;
ALTER TABLE ts_concurrent_sessions ALTER COLUMN ts_id SET DEFAULT nextval('ts_concur_sessions_ts_id_sq');

CREATE SEQUENCE ts_defect_defs_ts_id_sq;
ALTER SEQUENCE ts_defect_defs_ts_id_sq OWNED BY ts_defect_defs.ts_id;
ALTER TABLE ts_defect_defs ALTER COLUMN ts_id SET DEFAULT nextval('ts_defect_defs_ts_id_sq');
ALTER SEQUENCE ts_defect_defs_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_bizdef_filters_ts_id_sq;
ALTER SEQUENCE ts_bizdef_filters_ts_id_sq OWNED BY ts_bizdef_filters.ts_id;
ALTER TABLE ts_bizdef_filters ALTER COLUMN ts_id SET DEFAULT nextval('ts_bizdef_filters_ts_id_sq');

CREATE SEQUENCE ts_defect_importance_ts_id_sq;
ALTER SEQUENCE ts_defect_importance_ts_id_sq OWNED BY ts_defect_importances.ts_id;
ALTER TABLE ts_defect_importances ALTER COLUMN ts_id SET DEFAULT nextval('ts_defect_importance_ts_id_sq');

CREATE SEQUENCE ts_defect_meta_keys_ts_id_sq; 
ALTER SEQUENCE ts_defect_meta_keys_ts_id_sq OWNED BY ts_defect_meta_keys.ts_id;
ALTER TABLE ts_defect_meta_keys ALTER COLUMN ts_id SET DEFAULT nextval('ts_defect_meta_keys_ts_id_sq');

CREATE SEQUENCE ts_dfct_meta_values_ts_id_sq;
ALTER SEQUENCE ts_dfct_meta_values_ts_id_sq OWNED BY ts_defect_meta_values.ts_id;
ALTER TABLE ts_defect_meta_values ALTER COLUMN ts_id SET DEFAULT nextval('ts_dfct_meta_values_ts_id_sq');

CREATE SEQUENCE ts_defects_ts_id_sq;
ALTER SEQUENCE ts_defects_ts_id_sq OWNED BY ts_defects.ts_id;
ALTER TABLE ts_defects ALTER COLUMN ts_id SET DEFAULT nextval('ts_defects_ts_id_sq');

CREATE SEQUENCE ts_defects_itvl_ts_id_sq;
ALTER SEQUENCE ts_defects_itvl_ts_id_sq OWNED BY ts_defects_interval.ts_id;
ALTER TABLE ts_defects_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_defects_itvl_ts_id_sq');

CREATE SEQUENCE ts_domains_ts_id_sq;
ALTER SEQUENCE ts_domains_ts_id_sq OWNED BY ts_domains.ts_id;
ALTER TABLE ts_domains ALTER COLUMN ts_id SET DEFAULT nextval('ts_domains_ts_id_sq');

CREATE SEQUENCE ts_entity_ts_id_sq;
ALTER SEQUENCE ts_entity_ts_id_sq OWNED BY ts_entity.ts_id;
ALTER TABLE ts_entity ALTER COLUMN ts_id SET DEFAULT nextval('ts_entity_ts_id_sq');

CREATE SEQUENCE ts_entity_service_ts_id_sq;
ALTER SEQUENCE ts_entity_service_ts_id_sq OWNED BY ts_entity_service.ts_id;
ALTER TABLE ts_entity_service ALTER COLUMN ts_id SET DEFAULT nextval('ts_entity_service_ts_id_sq');

CREATE SEQUENCE ts_hourly_aggr_log_ts_id_sq;
ALTER SEQUENCE ts_hourly_aggr_log_ts_id_sq OWNED BY ts_hourly_aggregation_log.ts_id;
ALTER TABLE ts_hourly_aggregation_log ALTER COLUMN ts_id SET DEFAULT nextval('ts_hourly_aggr_log_ts_id_sq');

CREATE SEQUENCE ts_impact_settings_ts_id_sq; 
ALTER SEQUENCE ts_impact_settings_ts_id_sq OWNED BY ts_impact_settings.ts_id;
ALTER TABLE ts_impact_settings ALTER COLUMN ts_id SET DEFAULT nextval('ts_impact_settings_ts_id_sq');

CREATE SEQUENCE ts_introscope_cfgs_ts_id_sq; 
ALTER SEQUENCE ts_introscope_cfgs_ts_id_sq OWNED BY ts_introscope_configs.ts_id;
ALTER TABLE ts_introscope_configs ALTER COLUMN ts_id SET DEFAULT nextval('ts_introscope_cfgs_ts_id_sq');
 
CREATE SEQUENCE ts_introscope_ems_ts_id_sq;
ALTER SEQUENCE ts_introscope_ems_ts_id_sq OWNED BY ts_introscope_ems.ts_id;
ALTER TABLE ts_introscope_ems ALTER COLUMN ts_id SET DEFAULT nextval('ts_introscope_ems_ts_id_sq');

CREATE SEQUENCE ts_license_compl_ts_id_sq; 
ALTER SEQUENCE ts_license_compl_ts_id_sq OWNED BY ts_license_compliance.ts_id;
ALTER TABLE ts_license_compliance ALTER COLUMN ts_id SET DEFAULT nextval('ts_license_compl_ts_id_sq');

CREATE SEQUENCE ts_monitors_ts_id_sq; 
ALTER SEQUENCE ts_monitors_ts_id_sq OWNED BY ts_monitors.ts_id;
ALTER TABLE ts_monitors ALTER COLUMN ts_id SET DEFAULT nextval('ts_monitors_ts_id_sq');
ALTER SEQUENCE ts_monitors_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_montr_child_srvc_ts_id_sq;
ALTER SEQUENCE ts_montr_child_srvc_ts_id_sq OWNED BY ts_monitor_child_service.ts_id;
ALTER TABLE ts_monitor_child_service ALTER COLUMN ts_id SET DEFAULT nextval('ts_montr_child_srvc_ts_id_sq');

CREATE SEQUENCE ts_monitor_types_ts_id_sq; 
ALTER SEQUENCE ts_monitor_types_ts_id_sq OWNED BY ts_monitor_types.ts_id;
ALTER TABLE ts_monitor_types ALTER COLUMN ts_id SET DEFAULT nextval('ts_monitor_types_ts_id_sq');

CREATE SEQUENCE ts_operators_ts_id_sq;
ALTER SEQUENCE ts_operators_ts_id_sq OWNED BY ts_operators.ts_id;
ALTER TABLE ts_operators ALTER COLUMN ts_id SET DEFAULT nextval('ts_operators_ts_id_sq');

CREATE SEQUENCE ts_plugin_ts_id_sq;
ALTER SEQUENCE ts_plugin_ts_id_sq OWNED BY ts_plugin.ts_id;
ALTER TABLE ts_plugin ALTER COLUMN ts_id SET DEFAULT nextval('ts_plugin_ts_id_sq');

CREATE SEQUENCE ts_plugin_filter_ts_id_sq;
ALTER SEQUENCE ts_plugin_filter_ts_id_sq OWNED BY ts_plugin_filter.ts_id;
ALTER TABLE ts_plugin_filter ALTER COLUMN ts_id SET DEFAULT nextval('ts_plugin_filter_ts_id_sq');

CREATE SEQUENCE ts_plugin_url_filter_ts_id_sq;	
ALTER SEQUENCE ts_plugin_url_filter_ts_id_sq OWNED BY ts_plugin_url_filter.ts_id;
ALTER TABLE ts_plugin_url_filter ALTER COLUMN ts_id SET DEFAULT nextval('ts_plugin_url_filter_ts_id_sq');

CREATE SEQUENCE ts_private_params_ts_id_sq; 
ALTER SEQUENCE ts_private_params_ts_id_sq OWNED BY ts_private_parameters.ts_id;
ALTER TABLE ts_private_parameters ALTER COLUMN ts_id SET DEFAULT nextval('ts_private_params_ts_id_sq');

CREATE SEQUENCE ts_protocols_ts_id_sq; 
ALTER SEQUENCE ts_protocols_ts_id_sq OWNED BY ts_protocols.ts_id;
ALTER TABLE ts_protocols ALTER COLUMN ts_id SET DEFAULT nextval('ts_protocols_ts_id_sq');

CREATE SEQUENCE ts_record_components_ts_id_sq; 
ALTER SEQUENCE ts_record_components_ts_id_sq OWNED BY ts_recording_components.ts_id;
ALTER TABLE ts_recording_components ALTER COLUMN ts_id SET DEFAULT nextval('ts_record_components_ts_id_sq');
ALTER SEQUENCE ts_record_components_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_record_sessions_ts_id_sq;
ALTER SEQUENCE ts_record_sessions_ts_id_sq OWNED BY ts_recording_sessions.ts_id;
ALTER TABLE ts_recording_sessions ALTER COLUMN ts_id SET DEFAULT nextval('ts_record_sessions_ts_id_sq');
ALTER SEQUENCE ts_record_sessions_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_rprt_def_parm_val_ts_id_sq; 
ALTER SEQUENCE ts_rprt_def_parm_val_ts_id_sq OWNED BY ts_report_def_param_values.ts_id;
ALTER TABLE ts_report_def_param_values ALTER COLUMN ts_id SET DEFAULT nextval('ts_rprt_def_parm_val_ts_id_sq');

CREATE SEQUENCE ts_report_defs_ts_id_sq;
ALTER SEQUENCE ts_report_defs_ts_id_sq OWNED BY ts_report_defs.ts_id;
ALTER TABLE ts_report_defs ALTER COLUMN ts_id SET DEFAULT nextval('ts_report_defs_ts_id_sq');

CREATE SEQUENCE ts_report_param_keys_ts_id_sq;
ALTER SEQUENCE ts_report_param_keys_ts_id_sq OWNED BY ts_report_param_keys.ts_id;
ALTER TABLE ts_report_param_keys ALTER COLUMN ts_id SET DEFAULT nextval('ts_report_param_keys_ts_id_sq');

CREATE SEQUENCE ts_rprt_type_prm_val_ts_id_sq;
ALTER SEQUENCE ts_rprt_type_prm_val_ts_id_sq OWNED BY ts_report_type_param_values.ts_id;
ALTER TABLE ts_report_type_param_values ALTER COLUMN ts_id SET DEFAULT nextval('ts_rprt_type_prm_val_ts_id_sq');

CREATE SEQUENCE ts_report_types_ts_id_sq; 
ALTER SEQUENCE ts_report_types_ts_id_sq OWNED BY ts_report_types.ts_id;
ALTER TABLE ts_report_types ALTER COLUMN ts_id SET DEFAULT nextval('ts_report_types_ts_id_sq');

CREATE SEQUENCE ts_roles_ts_id_sq;
ALTER SEQUENCE ts_roles_ts_id_sq OWNED BY ts_roles.ts_id;
ALTER TABLE ts_roles ALTER COLUMN ts_id SET DEFAULT nextval('ts_roles_ts_id_sq');

CREATE SEQUENCE ts_services_def_ts_id_sq;
ALTER SEQUENCE ts_services_def_ts_id_sq OWNED BY ts_services_def.ts_id;
ALTER TABLE ts_services_def ALTER COLUMN ts_id SET DEFAULT nextval('ts_services_def_ts_id_sq');

CREATE SEQUENCE ts_session_usage_dly_ts_id_sq;
ALTER SEQUENCE ts_session_usage_dly_ts_id_sq OWNED BY ts_session_usage_daily.ts_id;
ALTER TABLE ts_session_usage_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_session_usage_dly_ts_id_sq');

CREATE SEQUENCE ts_ses_usage_itvl_ts_id_sq; 
ALTER SEQUENCE ts_ses_usage_itvl_ts_id_sq OWNED BY ts_session_usage_interval.ts_id;
ALTER TABLE ts_session_usage_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_ses_usage_itvl_ts_id_sq');

CREATE SEQUENCE ts_ses_usage_mtly_ts_id_sq;
ALTER SEQUENCE ts_ses_usage_mtly_ts_id_sq OWNED BY ts_session_usage_monthly.ts_id;
ALTER TABLE ts_session_usage_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_ses_usage_mtly_ts_id_sq');

CREATE SEQUENCE ts_ses_usage_wkly_ts_id_sq;
ALTER SEQUENCE ts_ses_usage_wkly_ts_id_sq OWNED BY ts_session_usage_weekly.ts_id;
ALTER TABLE ts_session_usage_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_ses_usage_wkly_ts_id_sq');

CREATE SEQUENCE ts_settings_ts_id_sq;
ALTER SEQUENCE ts_settings_ts_id_sq OWNED BY ts_settings.ts_id;
ALTER TABLE ts_settings ALTER COLUMN ts_id SET DEFAULT nextval('ts_settings_ts_id_sq');

CREATE SEQUENCE ts_sm_groups_ts_id_sq;
ALTER SEQUENCE ts_sm_groups_ts_id_sq OWNED BY ts_sm_groups.ts_id;
ALTER TABLE ts_sm_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_sm_groups_ts_id_sq');

CREATE SEQUENCE ts_sm_policy_servers_ts_id_sq;
ALTER SEQUENCE ts_sm_policy_servers_ts_id_sq OWNED BY ts_sm_policy_servers.ts_id;
ALTER TABLE ts_sm_policy_servers ALTER COLUMN ts_id SET DEFAULT nextval('ts_sm_policy_servers_ts_id_sq');

CREATE SEQUENCE ts_sm_web_servers_ts_id_sq; 
ALTER SEQUENCE ts_sm_web_servers_ts_id_sq OWNED BY ts_sm_web_servers.ts_id;
ALTER TABLE ts_sm_web_servers ALTER COLUMN ts_id SET DEFAULT nextval('ts_sm_web_servers_ts_id_sq');
                
CREATE SEQUENCE ts_stat_t_us_itvl_id_sq;
ALTER SEQUENCE ts_stat_t_us_itvl_id_sq OWNED BY ts_stats_t_us_interval.ts_id;
ALTER TABLE ts_stats_t_us_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_t_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_all_dly_id_sq;
ALTER SEQUENCE ts_stat_ts_all_dly_id_sq OWNED BY ts_stats_ts_all_daily.ts_id;
ALTER TABLE ts_stats_ts_all_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_all_dly_id_sq');

CREATE SEQUENCE ts_stat_ts_a_itvl_id_sq;
ALTER SEQUENCE ts_stat_ts_a_itvl_id_sq OWNED BY ts_stats_ts_all_interval.ts_id;
ALTER TABLE ts_stats_ts_all_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_a_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_all_mtly_id_sq; 
ALTER SEQUENCE ts_stat_ts_all_mtly_id_sq OWNED BY ts_stats_ts_all_monthly.ts_id;
ALTER TABLE ts_stats_ts_all_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_all_mtly_id_sq');

CREATE SEQUENCE ts_stat_ts_all_wkly_id_sq; 
ALTER SEQUENCE ts_stat_ts_all_wkly_id_sq OWNED BY ts_stats_ts_all_weekly.ts_id;
ALTER TABLE ts_stats_ts_all_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_all_wkly_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_dly_id_sq; 
ALTER SEQUENCE ts_stat_ts_usgrp_dly_id_sq OWNED BY ts_stats_ts_usgrp_daily.ts_id;
ALTER TABLE ts_stats_ts_usgrp_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_dly_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_itvl_id_sq; 
ALTER SEQUENCE ts_stat_ts_usgrp_itvl_id_sq OWNED BY ts_stats_ts_usgrp_interval.ts_id;
ALTER TABLE ts_stats_ts_usgrp_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_mtly_id_sq;
ALTER SEQUENCE ts_stat_ts_usgrp_mtly_id_sq OWNED BY ts_stats_ts_usgrp_monthly.ts_id;
ALTER TABLE ts_stats_ts_usgrp_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_mtly_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_wkly_id_sq;
ALTER SEQUENCE ts_stat_ts_usgrp_wkly_id_sq OWNED BY ts_stats_ts_usgrp_weekly.ts_id;
ALTER TABLE ts_stats_ts_usgrp_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_wkly_id_sq');

CREATE SEQUENCE ts_stat_ts_us_dly_id_sq; 
ALTER SEQUENCE ts_stat_ts_us_dly_id_sq OWNED BY ts_stats_ts_us_daily.ts_id;
ALTER TABLE ts_stats_ts_us_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_dly_id_sq');

CREATE SEQUENCE ts_stat_ts_us_itvl_id_sq; 
ALTER SEQUENCE ts_stat_ts_us_itvl_id_sq OWNED BY ts_stats_ts_us_interval.ts_id;
ALTER TABLE ts_stats_ts_us_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_us_mtly_id_sq;
ALTER SEQUENCE ts_stat_ts_us_mtly_id_sq OWNED BY ts_stats_ts_us_monthly.ts_id;
ALTER TABLE ts_stats_ts_us_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_mtly_id_sq');

CREATE SEQUENCE ts_stat_ts_us_wkly_id_sq;
ALTER SEQUENCE ts_stat_ts_us_wkly_id_sq OWNED BY ts_stats_ts_us_weekly.ts_id;
ALTER TABLE ts_stats_ts_us_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_wkly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_dly_id_sq; 
ALTER SEQUENCE ts_stat_tsgrp_all_dly_id_sq OWNED BY ts_stats_tsgrp_all_daily.ts_id;
ALTER TABLE ts_stats_tsgrp_all_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_dly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_itvl_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_all_itvl_id_sq OWNED BY ts_stats_tsgrp_all_interval.ts_id;
ALTER TABLE ts_stats_tsgrp_all_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_itvl_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_mtly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_all_mtly_id_sq OWNED BY ts_stats_tsgrp_all_monthly.ts_id;
ALTER TABLE ts_stats_tsgrp_all_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_mtly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_wkly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_all_wkly_id_sq OWNED BY ts_stats_tsgrp_all_weekly.ts_id;
ALTER TABLE ts_stats_tsgrp_all_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_wkly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_dly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_usgrp_dly_id_sq OWNED BY ts_stats_tsgrp_usgrp_daily.ts_id;
ALTER TABLE ts_stats_tsgrp_usgrp_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_dly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_itvl_id_sq; 
ALTER SEQUENCE ts_stat_tsgrp_usgrp_itvl_id_sq OWNED BY ts_stats_tsgrp_usgrp_interval.ts_id;
ALTER TABLE ts_stats_tsgrp_usgrp_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_itvl_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_mtly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_usgrp_mtly_id_sq OWNED BY ts_stats_tsgrp_usgrp_monthly.ts_id;
ALTER TABLE ts_stats_tsgrp_usgrp_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_mtly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_wkly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_usgrp_wkly_id_sq OWNED BY ts_stats_tsgrp_usgrp_weekly.ts_id;
ALTER TABLE ts_stats_tsgrp_usgrp_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_wkly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_dly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_us_dly_id_sq OWNED BY ts_stats_tsgrp_us_daily.ts_id;
ALTER TABLE ts_stats_tsgrp_us_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_dly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_itvl_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_us_itvl_id_sq OWNED BY ts_stats_tsgrp_us_interval.ts_id;
ALTER TABLE ts_stats_tsgrp_us_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_mtly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_us_mtly_id_sq OWNED BY ts_stats_tsgrp_us_monthly.ts_id;
ALTER TABLE ts_stats_tsgrp_us_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_mtly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_wkly_id_sq; 
ALTER SEQUENCE ts_stat_tsgrp_us_wkly_id_sq OWNED BY ts_stats_tsgrp_us_weekly.ts_id;
ALTER TABLE ts_stats_tsgrp_us_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_wkly_id_sq');

CREATE SEQUENCE ts_stat_tu_all_dly_id_sq;
ALTER SEQUENCE ts_stat_tu_all_dly_id_sq OWNED BY ts_stats_tu_all_daily.ts_id;
ALTER TABLE ts_stats_tu_all_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_dly_id_sq');

CREATE SEQUENCE ts_stat_tu_all_itvl_id_sq; 
ALTER SEQUENCE ts_stat_tu_all_itvl_id_sq OWNED BY ts_stats_tu_all_interval.ts_id;
ALTER TABLE ts_stats_tu_all_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_itvl_id_sq');

CREATE SEQUENCE ts_stat_tu_all_mtly_id_sq;
ALTER SEQUENCE ts_stat_tu_all_mtly_id_sq OWNED BY ts_stats_tu_all_monthly.ts_id;
ALTER TABLE ts_stats_tu_all_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_mtly_id_sq');

CREATE SEQUENCE ts_stat_tu_all_wkly_id_sq; 
ALTER SEQUENCE ts_stat_tu_all_wkly_id_sq OWNED BY ts_stats_tu_all_weekly.ts_id;
ALTER TABLE ts_stats_tu_all_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_wkly_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_dly_id_sq;
ALTER SEQUENCE ts_stat_tu_usgrp_dly_id_sq OWNED BY ts_stats_tu_usgrp_daily.ts_id;
ALTER TABLE ts_stats_tu_usgrp_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_dly_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_itvl_id_sq; 
ALTER SEQUENCE ts_stat_tu_usgrp_itvl_id_sq OWNED BY ts_stats_tu_usgrp_interval.ts_id;
ALTER TABLE ts_stats_tu_usgrp_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_itvl_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_mtly_id_sq; 
ALTER SEQUENCE ts_stat_tu_usgrp_mtly_id_sq OWNED BY ts_stats_tu_usgrp_monthly.ts_id;
ALTER TABLE ts_stats_tu_usgrp_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_mtly_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_wkly_id_sq;
ALTER SEQUENCE ts_stat_tu_usgrp_wkly_id_sq OWNED BY ts_stats_tu_usgrp_weekly.ts_id;
ALTER TABLE ts_stats_tu_usgrp_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_wkly_id_sq');

CREATE SEQUENCE ts_stat_tu_us_dly_id_sq; 
ALTER SEQUENCE ts_stat_tu_us_dly_id_sq OWNED BY ts_stats_tu_us_daily.ts_id;
ALTER TABLE ts_stats_tu_us_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_dly_id_sq');

CREATE SEQUENCE ts_stat_tu_us_itvl_id_sq;
ALTER SEQUENCE ts_stat_tu_us_itvl_id_sq OWNED BY ts_stats_tu_us_interval.ts_id;
ALTER TABLE ts_stats_tu_us_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_tu_us_mtly_id_sq; 
ALTER SEQUENCE ts_stat_tu_us_mtly_id_sq OWNED BY ts_stats_tu_us_monthly.ts_id;
ALTER TABLE ts_stats_tu_us_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_mtly_id_sq');

CREATE SEQUENCE ts_stat_tu_us_wkly_id_sq; 
ALTER SEQUENCE ts_stat_tu_us_wkly_id_sq OWNED BY ts_stats_tu_us_weekly.ts_id;
ALTER TABLE ts_stats_tu_us_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_wkly_id_sq');

CREATE SEQUENCE ts_tran_def_groups_ts_id_sq;
ALTER SEQUENCE ts_tran_def_groups_ts_id_sq OWNED BY ts_tran_def_groups.ts_id;
ALTER TABLE ts_tran_def_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_tran_def_groups_ts_id_sq');
ALTER SEQUENCE ts_tran_def_groups_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_tran_importances_ts_id_sq; 
ALTER SEQUENCE ts_tran_importances_ts_id_sq OWNED BY ts_tran_importances.ts_id;
ALTER TABLE ts_tran_importances ALTER COLUMN ts_id SET DEFAULT nextval('ts_tran_importances_ts_id_sq');

CREATE SEQUENCE ts_trancomps_ts_id_sq;
ALTER SEQUENCE ts_trancomps_ts_id_sq OWNED BY ts_trancomps.ts_id;
ALTER TABLE ts_trancomps ALTER COLUMN ts_id SET DEFAULT nextval('ts_trancomps_ts_id_sq');
ALTER SEQUENCE ts_trancomps_ts_id_sq RESTART WITH 700000000000000000;
 
CREATE SEQUENCE ts_tran_comp_details_ts_id_sq;
ALTER SEQUENCE ts_tran_comp_details_ts_id_sq OWNED BY ts_tran_comp_details.ts_id;
ALTER TABLE ts_tran_comp_details ALTER COLUMN ts_id SET DEFAULT nextval('ts_tran_comp_details_ts_id_sq'); 

CREATE SEQUENCE ts_transet_groups_ts_id_sq;
ALTER SEQUENCE ts_transet_groups_ts_id_sq OWNED BY ts_transet_groups.ts_id;
ALTER TABLE ts_transet_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_transet_groups_ts_id_sq');
ALTER SEQUENCE ts_transet_groups_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_transets_ts_id_sq;
ALTER SEQUENCE ts_transets_ts_id_sq OWNED BY ts_transets.ts_id;
ALTER TABLE ts_transets ALTER COLUMN ts_id SET DEFAULT nextval('ts_transets_ts_id_sq');
ALTER SEQUENCE ts_transets_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_tran_types_ts_id_sq; 
ALTER SEQUENCE ts_tran_types_ts_id_sq OWNED BY ts_tran_types.ts_id;
ALTER TABLE ts_tran_types ALTER COLUMN ts_id SET DEFAULT nextval('ts_tran_types_ts_id_sq');

CREATE SEQUENCE ts_tranunits_ts_id_sq; 
ALTER SEQUENCE ts_tranunits_ts_id_sq OWNED BY ts_tranunits.ts_id;
ALTER TABLE ts_tranunits ALTER COLUMN ts_id SET DEFAULT nextval('ts_tranunits_ts_id_sq');
ALTER SEQUENCE ts_tranunits_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_user_def_groups_ts_id_sq; 
ALTER SEQUENCE ts_user_def_groups_ts_id_sq OWNED BY ts_user_def_groups.ts_id;
ALTER TABLE ts_user_def_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_user_def_groups_ts_id_sq');

CREATE SEQUENCE ts_user_groups_ts_id_sq; 
ALTER SEQUENCE ts_user_groups_ts_id_sq OWNED BY ts_user_groups.ts_id;
ALTER TABLE ts_user_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_user_groups_ts_id_sq');

CREATE SEQUENCE ts_user_importances_ts_id_sq;
ALTER SEQUENCE ts_user_importances_ts_id_sq OWNED BY ts_user_importances.ts_id;
ALTER TABLE ts_user_importances ALTER COLUMN ts_id SET DEFAULT nextval('ts_user_importances_ts_id_sq');

CREATE SEQUENCE ts_users_ts_id_sq; 
ALTER SEQUENCE ts_users_ts_id_sq OWNED BY ts_users.ts_id;
ALTER TABLE ts_users ALTER COLUMN ts_id SET DEFAULT nextval('ts_users_ts_id_sq');

CREATE SEQUENCE ts_users_ts_incarnation_id_sq; 
SELECT setval('ts_users_ts_incarnation_id_sq', (select max(ts_incarnation_id) from ts_users));

CREATE SEQUENCE ts_web_servers_ts_id_sq; 
ALTER SEQUENCE ts_web_servers_ts_id_sq OWNED BY ts_web_servers.ts_id;
ALTER TABLE ts_web_servers ALTER COLUMN ts_id SET DEFAULT nextval('ts_web_servers_ts_id_sq');

CREATE SEQUENCE tang_config_ts_id_sq; 
ALTER SEQUENCE tang_config_ts_id_sq OWNED BY tang_config.ts_id;
ALTER TABLE tang_config ALTER COLUMN ts_id SET DEFAULT nextval('tang_config_ts_id_sq');

CREATE SEQUENCE tang_event_types_ts_id_sq; 
ALTER SEQUENCE tang_event_types_ts_id_sq OWNED BY tang_event_types.ts_id;
ALTER TABLE tang_event_types ALTER COLUMN ts_id SET DEFAULT nextval('tang_event_types_ts_id_sq');

--creating sequences

--master data



-- insert services_defs
insert into ts_services_def(version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (1, 'TIM.Collection.Svc', 'TIM Collection Service', 'The service includes: Login Processing, Defect Processing, Recording Processing, TANG Event Processing, Hourly Statistics Processing, BT Statistics Processing, Transaction Analysis Service', true, false, false);
insert into ts_services_def(version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (1, 'Stats.Aggregation.Svc', 'Stats Aggregation Service', 'The service aggregates the statistics on a daily basis, runs against the database', true, false, false);
insert into ts_services_def(version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (1, 'DB.Cleanup.Svc', 'DB Cleanup Service', 'The service cleans up aged out data from the database', true, false, false);

-- insert child_services_def
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Login.Collection.Service', 'Login Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Defect.Collection.Service', 'Defect Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Recording.Collection.Service', 'Recording Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Events.Collection.Service', 'Events Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Hourly.Collection.Service', 'Hourly Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Transaction.Discovery.Collection.Service', 'Transaction Discovery Collection Service', true, false, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'RTTM.Collection.Service', 'RTTM Collection Service', true, true, false);

--insert tang_event_types
--not inserting some of the tang_event_types with ts_id (1,2,7,8 and 13) as they are no longer valid event types as Tess 
--is on EM and not renaming the ts_id for the tang_event_types in a sequence as this will involve lot of rework.

insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(21, 0, 'Discovered transactions dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(22, 0, 'TIM Collection Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(23, 0, 'TIM Collection Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(24, 0, 'Stats Aggregation Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(25, 0, 'Stats Aggregation Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(26, 0, 'Database Cleanup Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(27, 0, 'Database Cleanup Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(28, 0, 'Limit exceeded adding new components', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(29, 0, 'TIM deleted some of its data files because disk space was low', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(30, 0, 'Enterprise Manager deleted some TIM data files because the lag-time threshold was met', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(31, 0, 'Enterprise Manager deleted some data files because the lag-time threshold was met', 'informational', 'Administration');

insert into ts_protocols(ts_name) values('http');

insert into ts_tran_types(ts_name) values('Component');
insert into ts_tran_types(ts_name) values('Transaction');
insert into ts_tran_types(ts_name) values('Business Transaction');

-- initialize ts_attributes table
-- each attribute is specifically and directly referred to in the code. The ids are expected to be as specified below.
-- No reordering of entries should be done to this table without changing the code where the ids below
-- are referenced.  This is unlike other tables where the ids are auto-generated.
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(1, 1, 3, true, 'CEM', 'Transaction Time', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(2, 1, 3, true, 'CEM', 'Throughput', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(3, 1, 3, true, 'CEM', 'Transaction Size', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(4, 1, 3, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(5, 1, 2, true, 'CEM', 'Transaction Time', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(6, 1, 2, true, 'CEM', 'Throughput', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(7, 1, 2, true, 'CEM', 'Transaction Size', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(8, 1, 2, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(9, 1, 1, true, 'CEM', 'HTTP Code', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(10, 1, 1, true, 'CEM', 'Content Text', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(11, 1, 1, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(12, 1, 1, true, 'CEM', 'HTTP Response Header Text', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(13, 1, 2, true, 'ISCP', 'Response Time', 2, 2, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(14, 1, 2, true, 'ISCP', 'Errors Per Interval', 2, 2, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(15, 1, 2, true, 'ISCP', 'Response Per Interval', 2, 2, 1, false);

-- update existing defect definitions to refer to an attribute id
update ts_defect_defs set ts_attribute_id=1 where ts_type=1 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=1 where ts_type=2 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=2 where ts_type=3 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=2 where ts_type=4 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=3 where ts_type=5 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=3 where ts_type=6 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=4 where ts_type=9 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=5 where ts_type=1 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=5 where ts_type=2 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=6 where ts_type=3 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=6 where ts_type=4 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=7 where ts_type=5 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=7 where ts_type=6 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=8 where ts_type=9 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=9 where ts_type=8 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=9 where ts_type=8 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=9 where ts_type=8 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=10 where ts_type=10 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=11 where ts_type=11 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=11 where ts_type=16 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=11 where ts_type=17 and ts_tran_type=1;

-- this statement must be executed after the above 2 tables have been initialized 
-- thus its presence in this file vs the regular upgrade script
alter table ts_defect_defs alter column ts_attribute_id set not null;
-- initialize upgrade to TIM Monitoring
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1032, 1, 'upgradeToTimMonitoring', 'true', 'Boolean to indicate if upgrade to TIM monitoring is completed or not', '', false);


--master data
-- Updating sequences

SELECT setval('ts_app_auth_types_ts_id_sq', (select max(ts_id) from ts_app_auth_types));
SELECT setval('ts_app_types_ts_id_sq', (select max(ts_id) from ts_app_types));

SELECT setval('ts_apps_ts_id_sq', 
				(SELECT   
			      CASE 
			         WHEN max(ts_id) <  700000000000000000 THEN 700000000000000000-1
			         ELSE max(ts_id)
			      END
				 FROM ts_apps)
			 );

SELECT setval('ts_attributes_ts_id_sq', (select max(ts_id) from ts_attributes));
SELECT setval('ts_audit_rcrd_props_ts_id_sq', (select max(ts_id) from ts_audit_record_props));
SELECT setval('ts_audit_rcrd_props_ts_id_sq', (select max(ts_id) from ts_audit_record_props));
SELECT setval('ts_autogen_tmplt_ts_id_sq', (select max(ts_id) from ts_autogen_template));
SELECT setval('ts_biz_events_ts_id_sq', (select max(ts_id) from ts_biz_events)); 
SELECT setval('ts_cached_reports_ts_id_sq', (select max(ts_id) from ts_cached_reports)); 
SELECT setval('ts_child_servc_def_ts_id_sq', (select max(ts_id) from ts_child_services_def)); 
SELECT setval('ts_concur_sessions_ts_id_sq', (select max(ts_id) from ts_child_services_def)); 
SELECT setval('ts_defect_defs_ts_id_sq', (select max(ts_id) from ts_defect_defs)); 
SELECT setval('ts_bizdef_filters_ts_id_sq', (select max(ts_id) from ts_bizdef_filters)); 
SELECT setval('ts_defect_importance_ts_id_sq', (select max(ts_id) from ts_defect_importances)); 

-- Reset the sequence ts_defect_meta_keys_ts_id_sq
SELECT setval('ts_defect_meta_keys_ts_id_sq', 
				(SELECT   
			      CASE 
			         WHEN max(ts_id) <  600000000000000000 THEN 600000000000000000-1
			         ELSE max(ts_id)
			      END
				 FROM ts_defect_meta_keys)
			 );

SELECT setval('ts_dfct_meta_values_ts_id_sq', (select max(ts_id) from ts_defect_meta_values)); 
SELECT setval('ts_defects_ts_id_sq', (select max(ts_id) from ts_defects)); 
SELECT setval('ts_defects_itvl_ts_id_sq', (select max(ts_id) from ts_defects_interval)); 
SELECT setval('ts_domains_ts_id_sq', (select max(ts_id) from ts_domains));
SELECT setval('ts_entity_ts_id_sq', (select max(ts_id) from ts_entity));
SELECT setval('ts_entity_service_ts_id_sq', (select max(ts_id) from ts_entity_service));
SELECT setval('ts_hourly_aggr_log_ts_id_sq', (select max(ts_id) from ts_hourly_aggregation_log));
SELECT setval('ts_impact_settings_ts_id_sq', (select max(ts_id) from ts_impact_settings));
SELECT setval('ts_introscope_cfgs_ts_id_sq', (select max(ts_id) from ts_introscope_configs));
SELECT setval('ts_introscope_ems_ts_id_sq', (select max(ts_id) from ts_introscope_ems));
SELECT setval('ts_license_compl_ts_id_sq', (select max(ts_id) from ts_license_compliance));
SELECT setval('ts_monitors_ts_id_sq', (select max(ts_id) from ts_monitors));
SELECT setval('ts_montr_child_srvc_ts_id_sq', (select max(ts_id) from ts_monitor_child_service));
SELECT setval('ts_monitor_types_ts_id_sq', (select max(ts_id) from ts_monitor_types));
SELECT setval('ts_operators_ts_id_sq', (select max(ts_id) from ts_operators));
SELECT setval('ts_plugin_ts_id_sq', (select max(ts_id) from ts_plugin));
SELECT setval('ts_plugin_filter_ts_id_sq', (select max(ts_id) from ts_plugin_filter));
SELECT setval('ts_plugin_url_filter_ts_id_sq', (select max(ts_id) from ts_plugin_url_filter));
SELECT setval('ts_private_params_ts_id_sq', (select max(ts_id) from ts_private_parameters));
SELECT setval('ts_protocols_ts_id_sq', (select max(ts_id) from ts_protocols));
SELECT setval('ts_record_components_ts_id_sq', (select max(ts_id) from ts_recording_components));
SELECT setval('ts_record_sessions_ts_id_sq', (select max(ts_id) from ts_recording_sessions));
SELECT setval('ts_rprt_def_parm_val_ts_id_sq', (select max(ts_id) from ts_report_def_param_values));
SELECT setval('ts_report_defs_ts_id_sq', (select max(ts_id) from ts_report_defs));
SELECT setval('ts_report_param_keys_ts_id_sq', (select max(ts_id) from ts_report_param_keys));
SELECT setval('ts_rprt_type_prm_val_ts_id_sq', (select max(ts_id) from ts_report_type_param_values));
SELECT setval('ts_report_types_ts_id_sq', (select max(ts_id) from ts_report_types));
SELECT setval('ts_roles_ts_id_sq', (select max(ts_id) from ts_roles));
SELECT setval('ts_services_def_ts_id_sq', (select max(ts_id) from ts_services_def));
SELECT setval('ts_session_usage_dly_ts_id_sq', (select max(ts_id) from ts_session_usage_daily));
SELECT setval('ts_ses_usage_itvl_ts_id_sq', (select max(ts_id) from ts_session_usage_interval));
SELECT setval('ts_ses_usage_mtly_ts_id_sq', (select max(ts_id) from ts_session_usage_monthly));
SELECT setval('ts_ses_usage_wkly_ts_id_sq', (select max(ts_id) from ts_session_usage_weekly));
SELECT setval('ts_settings_ts_id_sq', (select max(ts_id) from ts_settings));
SELECT setval('ts_sm_groups_ts_id_sq', (select max(ts_id) from ts_sm_groups));
SELECT setval('ts_sm_policy_servers_ts_id_sq', (select max(ts_id) from ts_sm_policy_servers));
SELECT setval('ts_sm_web_servers_ts_id_sq', (select max(ts_id) from ts_sm_web_servers));
SELECT setval('ts_stat_t_us_itvl_id_sq', (select max(ts_id) from ts_stats_t_us_interval));
SELECT setval('ts_stat_ts_all_dly_id_sq', (select max(ts_id) from ts_stats_ts_all_daily));
SELECT setval('ts_stat_ts_a_itvl_id_sq', (select max(ts_id) from ts_stats_ts_all_interval));
SELECT setval('ts_stat_ts_all_mtly_id_sq', (select max(ts_id) from ts_stats_ts_all_monthly));
SELECT setval('ts_stat_ts_all_wkly_id_sq', (select max(ts_id) from ts_stats_ts_all_weekly));
SELECT setval('ts_stat_ts_usgrp_dly_id_sq', (select max(ts_id) from ts_stats_ts_usgrp_daily));
SELECT setval('ts_stat_ts_usgrp_itvl_id_sq', (select max(ts_id) from ts_stats_ts_usgrp_interval));
SELECT setval('ts_stat_ts_usgrp_mtly_id_sq', (select max(ts_id) from ts_stats_ts_usgrp_monthly));
SELECT setval('ts_stat_ts_usgrp_wkly_id_sq', (select max(ts_id) from ts_stats_ts_usgrp_weekly));
SELECT setval('ts_stat_ts_us_dly_id_sq', (select max(ts_id) from ts_stats_ts_us_daily));
SELECT setval('ts_stat_ts_us_itvl_id_sq', (select max(ts_id) from ts_stats_ts_us_interval));
SELECT setval('ts_stat_ts_us_mtly_id_sq', (select max(ts_id) from ts_stats_ts_us_monthly));
SELECT setval('ts_stat_ts_us_wkly_id_sq', (select max(ts_id) from ts_stats_ts_us_weekly));
SELECT setval('ts_stat_tsgrp_all_dly_id_sq', (select max(ts_id) from ts_stats_tsgrp_all_daily));
SELECT setval('ts_stat_tsgrp_all_itvl_id_sq', (select max(ts_id) from ts_stats_tsgrp_all_interval));
SELECT setval('ts_stat_tsgrp_all_mtly_id_sq', (select max(ts_id) from ts_stats_tsgrp_all_monthly));
SELECT setval('ts_stat_tsgrp_all_wkly_id_sq', (select max(ts_id) from ts_stats_tsgrp_all_weekly));
SELECT setval('ts_stat_tsgrp_usgrp_dly_id_sq', (select max(ts_id) from ts_stats_tsgrp_usgrp_daily));
SELECT setval('ts_stat_tsgrp_usgrp_itvl_id_sq', (select max(ts_id) from ts_stats_tsgrp_usgrp_interval));
SELECT setval('ts_stat_tsgrp_usgrp_mtly_id_sq', (select max(ts_id) from ts_stats_tsgrp_usgrp_monthly));
SELECT setval('ts_stat_tsgrp_usgrp_wkly_id_sq', (select max(ts_id) from ts_stats_tsgrp_usgrp_weekly));
SELECT setval('ts_stat_tsgrp_us_dly_id_sq', (select max(ts_id) from ts_stats_tsgrp_us_daily));
SELECT setval('ts_stat_tsgrp_us_itvl_id_sq', (select max(ts_id) from ts_stats_tsgrp_us_interval));
SELECT setval('ts_stat_tsgrp_us_mtly_id_sq', (select max(ts_id) from ts_stats_tsgrp_us_monthly));
SELECT setval('ts_stat_tsgrp_us_wkly_id_sq', (select max(ts_id) from ts_stats_tsgrp_us_weekly));
SELECT setval('ts_stat_tu_all_dly_id_sq', (select max(ts_id) from ts_stats_tu_all_daily));
SELECT setval('ts_stat_tu_all_itvl_id_sq', (select max(ts_id) from ts_stats_tu_all_interval));
SELECT setval('ts_stat_tu_all_mtly_id_sq', (select max(ts_id) from ts_stats_tu_all_monthly));
SELECT setval('ts_stat_tu_all_wkly_id_sq', (select max(ts_id) from ts_stats_tu_all_weekly));
SELECT setval('ts_stat_tu_usgrp_dly_id_sq', (select max(ts_id) from ts_stats_tu_usgrp_daily));
SELECT setval('ts_stat_tu_usgrp_itvl_id_sq', (select max(ts_id) from ts_stats_tu_usgrp_interval));
SELECT setval('ts_stat_tu_usgrp_mtly_id_sq', (select max(ts_id) from ts_stats_tu_usgrp_monthly));
SELECT setval('ts_stat_tu_usgrp_wkly_id_sq', (select max(ts_id) from ts_stats_tu_usgrp_weekly));
SELECT setval('ts_stat_tu_us_dly_id_sq', (select max(ts_id) from ts_stats_tu_us_daily));
SELECT setval('ts_stat_tu_us_itvl_id_sq', (select max(ts_id) from ts_stats_tu_us_interval));
SELECT setval('ts_stat_tu_us_mtly_id_sq', (select max(ts_id) from ts_stats_tu_us_monthly));
SELECT setval('ts_stat_tu_us_wkly_id_sq', (select max(ts_id) from ts_stats_tu_us_weekly));
SELECT setval('ts_tran_def_groups_ts_id_sq', (select max(ts_id) from ts_tran_def_groups));
SELECT setval('ts_tran_importances_ts_id_sq', (select max(ts_id) from ts_tran_importances));
SELECT setval('ts_trancomps_ts_id_sq', (select max(ts_id) from ts_trancomps));
SELECT setval('ts_tran_comp_details_ts_id_sq', (select max(ts_id) from ts_tran_comp_details));
SELECT setval('ts_transet_groups_ts_id_sq', (select max(ts_id) from ts_transet_groups));
SELECT setval('ts_transets_ts_id_sq', (select max(ts_id) from ts_transets));
SELECT setval('ts_tran_types_ts_id_sq', (select max(ts_id) from ts_tran_types));
SELECT setval('ts_tranunits_ts_id_sq', (select max(ts_id) from ts_tranunits));
SELECT setval('ts_user_def_groups_ts_id_sq', (select max(ts_id) from ts_user_def_groups));
SELECT setval('ts_user_groups_ts_id_sq', (select max(ts_id) from ts_user_groups));
SELECT setval('ts_user_importances_ts_id_sq', (select max(ts_id) from ts_user_importances));
SELECT setval('ts_users_ts_id_sq', (select max(ts_id) from ts_users));
SELECT setval('ts_users_ts_incarnation_id_sq', (select max(ts_incarnation_id) from ts_users));
SELECT setval('ts_web_servers_ts_id_sq', (select max(ts_id) from ts_web_servers));
SELECT setval('tang_config_ts_id_sq', (select max(ts_id) from tang_config));
SELECT setval('tang_event_types_ts_id_sq', (select max(ts_id) from tang_event_types));
SELECT setval('tang_events_ts_id_sq', (select max(ts_id) from tang_events));



--column length changes


-- tang_events
ALTER TABLE tang_events ALTER COLUMN ts_info TYPE VARCHAR(4000);

-- ts_apps
ALTER TABLE ts_apps ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_autogen_params
ALTER TABLE ts_autogen_params ALTER COLUMN ts_name TYPE VARCHAR(4000);

-- ts_biz_events
ALTER TABLE ts_biz_events ALTER COLUMN ts_cause TYPE VARCHAR(4000);
ALTER TABLE ts_biz_events ALTER COLUMN ts_resolution TYPE VARCHAR(4000);

-- ts_biz_event_subnets
ALTER TABLE ts_biz_event_subnets ALTER COLUMN ts_subnet TYPE NUMERIC(39,0);

-- ts_defects
ALTER TABLE ts_defects ALTER COLUMN ts_server_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_defects ALTER COLUMN ts_client_ip_address TYPE NUMERIC(39,0);

-- ts_defect_meta_keys
ALTER TABLE ts_defect_meta_keys ALTER COLUMN ts_name TYPE VARCHAR(4000);

-- ts_domains
ALTER TABLE ts_domains ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);

-- ts_entity
ALTER TABLE ts_entity ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);

-- ts_impact_settings
ALTER TABLE ts_impact_settings ALTER COLUMN ts_action_cmd TYPE VARCHAR(4000);

-- ts_interim_session_id_params
ALTER TABLE ts_interim_session_id_params ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_introscope_ems
ALTER TABLE ts_introscope_ems ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_login_id_parameters
ALTER TABLE ts_login_id_parameters ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_monitors
ALTER TABLE ts_monitors ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_monitors ALTER COLUMN ts_domain_status_code TYPE VARCHAR(4000);
ALTER TABLE ts_monitors ALTER COLUMN ts_tim_status_code TYPE VARCHAR(4000);

-- ts_monitor_types
ALTER TABLE ts_monitor_types ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_params
ALTER TABLE ts_params ALTER COLUMN ts_name TYPE VARCHAR(4000);

-- ts_plugin
ALTER TABLE ts_plugin ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_plugin_filter
ALTER TABLE ts_plugin_filter ALTER COLUMN ts_from_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_plugin_filter ALTER COLUMN ts_to_ip_address TYPE NUMERIC(39,0);

-- ts_recording_components
ALTER TABLE ts_recording_components ALTER COLUMN ts_comments TYPE VARCHAR(4000);
ALTER TABLE ts_recording_components ALTER COLUMN ts_server_ip_address TYPE NUMERIC(39,0);

-- ts_recording_sessions
ALTER TABLE ts_recording_sessions ALTER COLUMN ts_client_ip_address TYPE NUMERIC(39,0);

-- ts_report_def_param_values
ALTER TABLE ts_report_def_param_values ALTER COLUMN ts_value TYPE VARCHAR(4000);

-- ts_report_type_param_values
ALTER TABLE ts_report_type_param_values ALTER COLUMN ts_value TYPE VARCHAR(4000);

-- ts_services_def
ALTER TABLE ts_services_def ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_session_id_parameters
ALTER TABLE ts_session_id_parameters ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_sm_policy_servers
ALTER TABLE ts_sm_policy_servers ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);

-- ts_sm_web_servers
ALTER TABLE ts_sm_web_servers ALTER COLUMN ts_from_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_sm_web_servers ALTER COLUMN ts_to_ip_address TYPE NUMERIC(39,0);

-- ts_trancomps
ALTER TABLE ts_trancomps ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_transets
ALTER TABLE ts_transets ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_transet_groups
ALTER TABLE ts_transet_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_tranunits
ALTER TABLE ts_tranunits ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_tran_def_groups
ALTER TABLE ts_tran_def_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_tran_types
ALTER TABLE ts_tran_types ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_usergroup_id_parameters
ALTER TABLE ts_usergroup_id_parameters ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_user_def_groups
ALTER TABLE ts_user_def_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_user_groups
ALTER TABLE ts_user_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);
ALTER TABLE ts_user_groups ALTER COLUMN ts_subnet_mask TYPE NUMERIC(39,0);
ALTER TABLE ts_user_groups ALTER COLUMN ts_subnet_address TYPE NUMERIC(39,0);

-- ts_web_servers
ALTER TABLE ts_web_servers ALTER COLUMN ts_from_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_web_servers ALTER COLUMN ts_to_ip_address TYPE NUMERIC(39,0);

ALTER TABLE ts_biz_events ADD COLUMN ts_record_updated timestamp with time zone;

-- This statement always should be at the end to upgrade to 9.0.7.0 , please do not move it to some other place --
-- Updating database version from 4.5.6.7 to 9.0.7.0

update ts_domains set ts_db_versions='9.0.7.0';
