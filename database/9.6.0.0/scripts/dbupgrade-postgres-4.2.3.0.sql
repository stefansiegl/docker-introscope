-- update database from 4.2.3.0 to 4.5.0.0

-- TT51414: invalid values for sigma sla due to lack of validation on domain page
update ts_domains set ts_tran_sigma_sla = 0.8406 where ts_tran_sigma_sla < 0.8406;
update ts_domains set ts_user_sigma_sla = 0.8406 where ts_tran_sigma_sla < 0.8406;
update ts_domains set ts_tran_sigma_sla = 6.26 where ts_tran_sigma_sla > 6.26;
update ts_domains set ts_user_sigma_sla = 6.26 where ts_tran_sigma_sla > 6.26;

update ts_tran_def_groups set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_tran_def_groups set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_trancomps set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_trancomps set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_transet_groups set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_transet_groups set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_transet_usergroup_slas set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_transet_usergroup_slas set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_transets set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_transets set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_tranunits set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_tranunits set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_user_def_groups set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_user_def_groups set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_user_groups set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_user_groups set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;
update ts_users set ts_sigma_sla = 0.8406 where ts_sigma_sla < 0.8406;
update ts_users set ts_sigma_sla = 6.26 where ts_sigma_sla > 6.26;

-- this table is a duplicate of ts_transet_usergroup_slas and is never accessed by tess
drop table ts_usergroup_transet_slas;

-- TT48235: defining correlational slas very slow
alter table ts_transet_usergroup_slas drop constraint FK7E37E448E92C7899;
alter table ts_transet_usergroup_slas drop constraint FK7E37E448E92C789A;
alter table ts_transet_usergroup_slas
    add constraint FK7E37E448E92C7899
    foreign key (ts_usergroup_id) 
    references ts_user_groups on delete cascade;
alter table ts_transet_usergroup_slas
    add constraint FK7E37E448E92C789A
    foreign key (ts_transet_id) 
    references ts_transets on delete cascade;

--TT50781: no business process drop down on correlational sla report under MyReports
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (160,1,17,15,'0',false);

-- TT49944: Database upgrade scripts should include insert script for ipv6 address range
insert into ts_sm_web_servers(ts_id, ts_sm_group_id, ts_name, ts_from_ip_address, ts_to_ip_address, ts_ip_address_type, ts_port, ts_soft_delete, version_info) values(3, 1, 'Default SiteMinder Web Servers', 0, 340282366920938463463374607431768211455, 2, 0, false, 1);

--TT48829: TESS cannot send siteminderconfig to Tims
update ts_sm_web_servers set ts_ip_address_type=1 where ts_ip_address_type is null;

-- add new header name parameter (TT42637)
alter table ts_defect_defs add column ts_header_name varchar(200);

-- cols needed for transaction management
alter table ts_transets add column ts_creator_id int8 not null default 1;
alter table ts_transets add column ts_last_modifier_id int8 not null default 1;
alter table ts_transets add column ts_creation_date timestamp;
alter table ts_transets add column ts_last_modified_date timestamp;
alter table ts_transets add column ts_total_captures int8;
alter table ts_transets add column ts_last_capture_date timestamp;
alter table ts_recording_components add column ts_plugin_params varchar(10485760);

-- fix for bug 2235
alter table ts_domains add column ts_dynamic_group_reassign bool not null default false;

-- fix for TT50350 - validation fails
alter table ts_domains alter column ts_it_value type numeric(12,2);
alter table ts_domains alter column ts_business_value type numeric(12,2);
alter table ts_domains alter column ts_user_minute_cost type numeric(12,2);
alter table ts_transets alter column ts_it_value type numeric(12,2);
alter table ts_transets alter column ts_business_value type numeric(12,2);
alter table ts_transets alter column ts_user_minute_cost type numeric(12,2);
alter table ts_tran_def_groups alter column ts_it_value type numeric(12,2);
alter table ts_tran_def_groups alter column ts_business_value type numeric(12,2);
alter table ts_tran_def_groups alter column ts_user_minute_cost type numeric(12,2);

-- updates for "Changes since last sync" feature
alter table ts_monitors add column ts_domain_status_update_time timestamp not null default CURRENT_TIMESTAMP;
alter table ts_monitors add column ts_tim_status_update_time timestamp not null default CURRENT_TIMESTAMP;

-- New table for TranCompDetail
create table ts_tran_comp_details(
  	ts_id int8 NOT NULL,
  	version_id int8 NOT NULL,
  	ts_defect_id int8 NOT NULL,
  	ts_defect_date timestamptz NOT NULL,
  	ts_occurrence_date timestamptz NOT NULL,
  	ts_trancomp_id int8 NOT NULL,
  	ts_data_center_time int4 NOT NULL,
  	ts_start_time timestamptz,
  	ts_transaction_time int4,
  	ts_size int4,
  	ts_soft_delete bool NOT NULL,
  	primary key (ts_id)
);

-- column needed for partitioning (needed here for config import; also added by postgres install.sh)
alter table ts_defect_meta_values add column ts_defect_date timestamptz not null default now();

-- new tables for transaction recognition plugin
create table ts_plugin (
  ts_id bigint NOT NULL,
  version_info bigint NOT NULL,
  ts_soft_delete bool NOT NULL DEFAULT false,
  ts_name character varying(200) NOT NULL,
  ts_description character varying(10485760),
  ts_enabled bool NOT NULL DEFAULT false,
  ts_plugin_jar_name character varying(200) NOT NULL,
  CONSTRAINT ts_plugin_pkey PRIMARY KEY (ts_id)
);
create table ts_plugin_filter
(
  ts_id bigint NOT NULL,
  ts_plugin_id bigint NOT NULL,
  ts_name character varying(200) NOT NULL,
  ts_from_ip_address numeric,
  ts_to_ip_address numeric,
  ts_soft_delete bool NOT NULL DEFAULT false,
  version_info bigint NOT NULL,
  ts_port int4 NOT NULL DEFAULT 0,
  ts_ip_address_type int2,
  CONSTRAINT ts_plugin_filter_pkey PRIMARY KEY (ts_id)
);
create table ts_plugin_url_filter
(
  ts_id bigint NOT NULL,
  ts_plugin_id bigint NOT NULL,
  ts_url_filter character varying(200) NOT NULL,
  ts_soft_delete bool NOT NULL DEFAULT false,
  version_info bigint NOT NULL,
  ts_filter_type character varying(200) DEFAULT 0,
  CONSTRAINT ts_plugin_url_filter_pkey PRIMARY KEY (ts_id)
);

alter table ts_plugin_filter add constraint fked464pl1aa100000
        foreign key (ts_plugin_id) references ts_plugin (ts_id) on update no action on delete cascade;

alter table ts_plugin_url_filter add constraint fked464p11aa100010
        foreign key (ts_plugin_id) references ts_plugin (ts_id) on update no action on delete cascade;

-- TT 47795: disable incident generation rule 4 on the incident settings page 
update ts_settings set ts_value='false' where ts_key='bizEvent.triggerRule.compareDefectRateToNorm.enabled';
delete from ts_settings where ts_key='bizEvent.triggerRule.compareDefectRateToNorm.percentageIncreaseOverNorm';

create table ts_biz_event_subnets
(
  ts_biz_event_id bigint NOT NULL,
  ts_subnet numeric NOT NULL,
  version_info int8 NOT NULL,
  ts_count bigint NOT NULL,
  ts_subnet_string character varying(200),
  ts_soft_delete bool NOT NULL DEFAULT false,
  CONSTRAINT ts_biz_events_subnets_pkey PRIMARY KEY (ts_biz_event_id, ts_subnet)
);

alter table ts_biz_event_subnets add constraint fkf300a7854ad9ffd5
        foreign key (ts_biz_event_id) references ts_biz_events (ts_id) on update no action on delete cascade;

-- TT 47796: CEM User Group by IP Subnet
alter table ts_domains add column ts_defect_filter_subnet_mask character varying(200);
alter table ts_domains add column ts_filter_defects_subnets_enabled boolean not null default false;

-- TT 47463: CEM Unable to identify SessionID
alter table ts_domains add column ts_path_param_delimiters character varying(200);
alter table ts_recording_components add column ts_path_params varchar(10485760);

-- drop unused indexes 
drop index ts_defects_TranCompIndex;
drop index ts_defects_TranUnitIndex;
drop index ts_defects_interval_TranCompIndex;
drop index ts_defects_interval_TranUnitIndex;
drop index ts_user_logins_map_AppTypeIndex;
drop index ts_user_sessions_map_AppTypeIndex;
drop index ts_user_sessions_map_LastUpdateIndex;
drop index ts_user_sessions_map_UserIndex;

-- Updating database version
update ts_domains set ts_db_versions='4.5.0.0';

