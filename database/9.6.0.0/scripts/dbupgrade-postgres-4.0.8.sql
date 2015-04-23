-- upgrade database from 4.0.8 to 4.0.9

-- fix bug 1410 - 404 errors on save user quality report
-- fix bug 1411 - missing tabs on saved user group P/Q report
update ts_report_type_param_values set ts_value='userPerformanceReport.html' where ts_value='userGroupPerformanceReport.html';
update ts_report_type_param_values set ts_value='userQualityReport.html' where ts_value='userGroupQualityReport';
update ts_report_def_param_values set ts_value='userPerformanceReport.html' where ts_value='userGroupPerformanceReport.html';
update ts_report_def_param_values set ts_value='userQualityReport.html' where ts_value='userGroupQualityReport';

-- bug fix 1428 adding reportDimension to Transaction Defect Frequency even though it does not need it
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (155,1,26,25,'timeSeries',false);

-- bug 1409 retrying this update even through it should have been done as part of 3.3.4 to 3.4.0
update ts_report_type_param_values set ts_value='tranPerformanceReport.html' where ts_value='tranSetGroupPerformaceReport.html';


-- Updating database version
update ts_domains set ts_db_versions='4.0.9';
