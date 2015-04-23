-- upgrade database from 4.1.3 to 4.1.4

-- fix bug 1853 - IAE when generating session usage report from saved license compliance report
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (159,1,20,26,'LastWeek',false);

-- fix bug 2062 - selecting incident detail link causes exception
update ts_defects set ts_data_center_time = -1 where ts_data_center_time is null;
alter table ts_defects alter column ts_data_center_time set not null;

-- Updating database version
update ts_domains set ts_db_versions='4.1.4';
