-- upgrade database from 4.1.1 to 4.1.2

-- fix bug 1838 - license compliance reports can't be saved/scheduled
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (158,1,1,26,'licenseComplianceReport.html',false);

-- fix bug 1833 - web start root path corrupt due to bug 1506
update ts_introscope_ems set ts_web_start_root_path='/' where ts_web_start_root_path='/\\/';

-- Updating database version
update ts_domains set ts_db_versions='4.1.2';
