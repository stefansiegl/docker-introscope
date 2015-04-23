-- upgrade database from 4.0.2 to 4.0.3

-- fix bug 1066: defect reports have both (all) dimensions
update ts_report_type_param_values set ts_value='comparison,timeSeries' where ts_id=128;
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (154,1,26,24,'comparison,timeSeries',false);

-- fix bug 1072: 404 error using defect-type defect report from dashboard
update ts_report_type_param_values set ts_value='defectReport.html' where ts_id=143;

-- speed up login name processing if lots of user groups
create index ts_user_groups_GroupByIndex on ts_user_groups(ts_group_by_ip_enabled);

-- speed up enforcement of session license limit
create index ts_user_sessions_map_LastUpdateIndex on ts_user_sessions_map (ts_last_update);

-- these will be missing in dbs created by installing tess versions 3.2 or 3.3
-- for dbs created prior to 3.2, these 2 statements will cause errors that are ignored
create unique index ts_transets_IncarnationIndex on ts_transets (ts_incarnation_id);
create unique index ts_users_IncarnationIndex on ts_users (ts_incarnation_id);

-- Updating database version
update ts_domains set ts_db_versions='4.0.3';
