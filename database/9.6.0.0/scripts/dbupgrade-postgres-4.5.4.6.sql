-- update database from 4.5.4.6 to 5.0.0.0 for APM 9.0

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
alter table ts_domains add column ts_capture_comprehensive_defect_details boolean NOT NULL default false;
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
CREATE OR REPLACE FUNCTION execute(TEXT) RETURNS VOID AS $$
BEGIN EXECUTE $1; END;
$$ LANGUAGE plpgsql STRICT;
 
-- upgrading ts_report_def_param_values
-- update ts_value with the username of the operator
UPDATE ts_report_def_param_values SET ts_value = ts_operators.ts_username from ts_operators 
where ts_operators.ts_id::character varying = ts_report_def_param_values.ts_value 
and ts_report_def_param_values.ts_param_key_id='2';
-- End upgrading ts_report_def_param_values 

-- upgrading ts_transets
alter table ts_transets alter column ts_creator_id drop not null;
alter table ts_transets add column ts_creator_name varchar(200) not null DEFAULT 'cemsystem';

select execute($$alter table ts_transets drop constraint FK865CB7BC1F3F4799$$) where exists (
select pc.conname from pg_constraint pc , pg_class pcl where pc.conname = 'FK865CB7BC1F3F4799'
	and pcl.relname = 'ts_transets'	and pcl.oid = pc.conrelid );

alter table ts_transets alter column ts_last_modifier_id drop not null;
alter table ts_transets add column ts_last_modifier_name varchar(200) not null DEFAULT 'cemsystem';

select execute($$alter table ts_transets drop constraint FK865CB7BC1F3F479A$$) where exists (
select pc.conname from pg_constraint pc , pg_class pcl where pc.conname = 'FK865CB7BC1F3F479A'
	and pcl.relname = 'ts_transets'	and pcl.oid = pc.conrelid );
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

-- add indexes for stats processing
create index ts_stats_transetgroup_user_daily_UserIncarnationIdIndex on ts_stats_transetgroup_user_daily (ts_user_incarnation_id);
create index ts_stats_transetgroup_user_monthly_UserIncarnationIdIndex on ts_stats_transetgroup_user_monthly (ts_user_incarnation_id);
create index ts_stats_transetgroup_user_weekly_UserIncarnationIdIndex on ts_stats_transetgroup_user_weekly (ts_user_incarnation_id);
create index ts_stats_transet_user_interval_TranSetIncarnationIdIndex on ts_stats_transet_user_interval (ts_transet_incarnation_id);
create index ts_stats_transet_user_monthly_TranSetIncarnationIdIndex on ts_stats_transet_user_monthly (ts_transet_incarnation_id);
create index ts_stats_transet_user_weekly_TranSetIncarnationIdIndex on ts_stats_transet_user_weekly (ts_transet_incarnation_id);

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

insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(29, 0, 'TIM deleted some of its data files because disk space was low', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(30, 0, 'Enterprise Manager deleted some TIM data files because the lag-time threshold was met', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(31, 0, 'Enterprise Manager deleted some data files because the lag-time threshold was met', 'informational', 'Administration');


CREATE INDEX ts_defects_userincarnationidindex ON ts_defects USING btree (ts_user_incarnation_id ASC NULLS LAST) TABLESPACE pg_default;
CREATE INDEX ts_defects_eventindex ON ts_defects USING btree (ts_biz_event_id);
CREATE INDEX ts_biz_events_versioninfoindex ON ts_biz_events USING btree (version_info ASC NULLS LAST) TABLESPACE pg_default;

update ts_introscope_ems set ts_tran_trace_duration = 30;
update ts_introscope_ems set ts_tran_trace_threshold_percentage = 50;

-- This statement always should be at the end to upgrade to 5.0 , please do not move it to some other place --
-- Updating database version
update ts_domains set ts_db_versions='5.0.0.0';

