-- Updating database version from 9.1.1.0 to 9.1.2.0

-- TT76814
create unique index ts_defects_reaggr_int_IntIdx on ts_defects_reaggr_intervals (ts_interval) where ts_processed_time is null;

-- allow tim to supply a unique id in SaaS mode
alter table ts_monitors add column ts_tim_id int8;
alter table ts_monitors add constraint ts_monitors_tim_id_unique unique (ts_tim_id);

-- allow for length increase of up to 16 bytes due to encryption
alter table ts_autogen_params alter column ts_pattern type varchar(1016);
alter table ts_params alter column ts_pattern type varchar(1016);
alter table ts_params alter column ts_original_value type varchar(1016);
alter table ts_trancomps alter column ts_name type varchar(216);
alter table ts_trancomps alter column ts_url type varchar(2116);
alter table ts_tran_def_groups alter column ts_name type varchar(216);
alter table ts_transet_groups alter column ts_name type varchar(216);
alter table ts_transets alter column ts_name type varchar(216);
alter table ts_tranunits alter column ts_name type varchar(216);
alter table ts_users alter column ts_first_name type varchar(216);
alter table ts_users alter column ts_last_name type varchar(216);
alter table ts_users alter column ts_login_name type varchar(216);
alter table ts_user_logins_map alter column ts_login_name type varchar(216);
alter table ts_user_logins_map alter column ts_raw_login_name type varchar(216);

ALTER TABLE APM_METRIC_PATH alter column METRIC_PATH type varchar(2000);

-- 78694: cleanup tang events
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) select 9, 0, 'Introscope unreachable', 'error', 'Administration' where not exists (select ts_id from tang_event_types where ts_id=9);
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) select 30, 0, 'Enterprise Manager deleted some TIM data files because the lag-time threshold was met', 'informational', 'Administration' where not exists (select ts_id from tang_event_types where ts_id=30);
delete from tang_event_types where ts_id in (1,2,7,8,13,19,20,31);
