-- upgrade database from 3.3.2 to 3.3.3

-- remove changes done for bug 731
delete from ts_report_defs where ts_report_type_id >= 16 and ts_report_type_id <= 19;
delete from ts_report_types where ts_id >= 16 and ts_id <= 19;

-- changes for bug 750
update ts_report_type_param_values set ts_value='tranPerformanceReport.html' where ts_value = 'tranSetGroupPerformanceReport.html';
update ts_report_type_param_values set ts_value='tranQualityReport.html' where ts_value = 'tranSetGroupQualityReport.html';

-- fix bug 751 My Report trend reports don't work
update ts_report_param_keys set ts_name='currentTimeframe' where ts_name='currentTimeFrame';
update ts_report_param_keys set ts_name='previousTimeframe' where ts_name='previousTimeFrame';

-- Updating database version
update ts_domains set ts_db_versions='3.3.3';
