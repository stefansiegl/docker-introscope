create or replace view TSGrpSlaPerfTimeSlaVw AS
 (SELECT b.ts_transet_group_id AS TranSetGroupId, a.ts_tran_time_sla AS TranTimeSla
  FROM ts_transets a, ts_transetgroup_transets_map b
  WHERE a.ts_incarnation_id = b.ts_transet_incarnation_id AND a.ts_tran_time_sla_inherited = false AND a.ts_tran_time_sla >= 0 AND a.ts_soft_delete = false)
  UNION ALL
 (SELECT d.ts_transet_group_id AS TranSetGroupId, e.ts_tran_time_sla AS TranTimeSla
  FROM ts_transets c, ts_transetgroup_transets_map d, ts_tran_def_groups e
  WHERE c.ts_incarnation_id = d.ts_transet_incarnation_id AND c.ts_trandef_group_id = e.ts_id AND e.ts_tran_time_sla_inherited = false AND c.ts_tran_time_sla_inherited = true AND e.ts_tran_time_sla >= 0 AND c.ts_soft_delete = false)
  UNION ALL
 (SELECT g.ts_transet_group_id AS TranSetGroupId, i.ts_tran_tran_time_sla AS TranTimeSla
  FROM ts_transets f, ts_transetgroup_transets_map g, ts_tran_def_groups h, ts_domains i
  WHERE f.ts_incarnation_id = g.ts_transet_incarnation_id AND f.ts_trandef_group_id = h.ts_id AND h.ts_tran_time_sla_inherited = true AND h.ts_domain_id = i.ts_id AND f.ts_soft_delete = false);
  
ALTER TABLE ts_usergroup_id_parameters ALTER COLUMN ts_name TYPE varchar(500);

update ts_hourly_aggregation_log set ts_stats_date=date_trunc('hour',ts_start_time) - interval '1 hour' where ts_stats_date is null;
  
  -- initialize service desk settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.usd_user', '', 'servicedesk username', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.usd_host', '', 'servicedesk host', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.usd_port', '', 'servicedesk port', '8080', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.usd_password', '', 'servicedesk password', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.enableusdplugin', 'false', 'enable service desk plugin', 'false', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.issuecategory', '', 'category of issue', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.cem_host', '', 'cem host', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.cem_port', '', 'cem port', '8081', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.issuefilter','','issue filter','*/*',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.issuedescription','','issue description','',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.issuesummary','','issue summary','',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.enablelow','true','enable low severity','true',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.enablemoderate','true','enable moderate severity','true',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.enablesevere','true','enable severe severity','true',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.enablecritical','true','enable critical severity','true',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.incidentlink','http://[HOST]:[PORT]/wily/cem/tess/app/biz/bizEventDetail.html?pId=[INCIDENT_ID]','direct incident link','',false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (DEFAULT, 1, 'servicedesk.use_itil', 'true', 'use ITIL', 'true', false);

-- alter the defect table for TT 82918
ALTER TABLE ts_defects ADD COLUMN ts_transtrace_info int4 not null default -1;
 
--TT 82918 (clone of 81453) : update the ts_transtrace_info attribute of defects
--can skip it, as we don't really probe it, not much of value addition
UPDATE ts_defects SET ts_transtrace_info=0 where ts_defect_def_id IN (select ts_id from ts_defect_defs where ts_name != 'Slow Time');

--update the defects based on details captured in trans component details of defect
UPDATE ts_defects SET ts_transtrace_info=1 where ts_id IN (select distinct (ts_defect_id) from ts_tran_comp_details where ts_has_tran_trace=true);

--update the defects based on details captured in defect metadata of defect
UPDATE ts_defects SET ts_transtrace_info=1 where ts_transtrace_info = -1 AND ts_id IN (select distinct (ts_defect_id) from ts_defect_meta_values where ts_metakey_id=7 AND ts_value='true');

-- TT77817: frequency is the number of secs between inserts of new events into the database
alter table tang_event_types add column ts_frequency int4 not null default 0;
update tang_event_types set ts_frequency=30 where ts_id=4;
update tang_event_types set ts_frequency=60 where ts_id in (3,7,10,11,12,15,16,17,21,28,29,30,32);

--TT83723 - gaps in partitions due to create failures
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category, ts_frequency) values(31, 0, 'Partition creation failed', 'error', 'Administration', 600);
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category, ts_frequency) values(33, 0, 'Oracle tablespace low', 'warning', 'Processing', 3600);

--TT82872 - 403 Forbidden errors when a tim is disabled
alter table ts_monitors add column ts_polling bool not null default false;
update ts_monitors set ts_polling=ts_enabled;

create table ts_defect_aggregation_log
(
  ts_id bigint NOT NULL,
  version_info bigint NOT NULL,
  ts_interval timestamp,
  ts_processed_time timestamp with time zone not null,
  ts_defect_count int not null,
  ts_is_defect_reaggr boolean,
  ts_soft_delete boolean NOT NULL,
  primary key (ts_id)
);

CREATE SEQUENCE ts_defect_aggr_log_ts_id_sq;
ALTER SEQUENCE ts_defect_aggr_log_ts_id_sq OWNED BY ts_defect_aggregation_log.ts_id;
ALTER TABLE ts_defect_aggregation_log ALTER COLUMN ts_id SET DEFAULT nextval('ts_defect_aggr_log_ts_id_sq');
