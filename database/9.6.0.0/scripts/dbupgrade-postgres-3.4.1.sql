-- upgrade database from 3.4.1 to 3.4.2

-- add analysis report types
insert into ts_report_types values (24, 1, 'TranDefectTypeReport', false);
insert into ts_report_types values (25, 1, 'TranDefectFrequencyReport', false);

-- add analysis report param keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (26,'reportDimension','ReportDimension','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (27,'defectName','DefectName','java.lang.String','',FALSE, 1);

-- allow scheduling of time-series reports
update ts_report_type_param_values set ts_value='countReport.html' where ts_value='countComparisonReport.html';
update ts_report_type_param_values set ts_value='defectReport.html' where ts_value='defectComparisonReport.html';
update ts_report_type_param_values set ts_value='sizeReport.html' where ts_value='sizeComparisonReport.html';
update ts_report_type_param_values set ts_value='successRateReport.html' where ts_value='successRateComparisonReport.html';
update ts_report_type_param_values set ts_value='throughputReport.html' where ts_value='throughputComparisonReport.html';
update ts_report_type_param_values set ts_value='timeReport.html' where ts_value='timeComparisonReport.html';
update ts_report_type_param_values set ts_value='volumeReport.html' where ts_value='volumeComparisonReport.html';
update ts_report_type_param_values set ts_value='yieldReport.html' where ts_value='yieldComparisonReport.html';

-- add analysis report param types
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (127,1,26,16,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (128,1,26,17,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (129,1,26,18,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (130,1,26,19,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (131,1,26,20,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (132,1,26,21,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (133,1,26,22,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (134,1,26,23,'comparison',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (135,1,15,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (136,1,15,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (137,1,15,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (138,1,15,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (139,1,15,20,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (140,1,15,21,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (141,1,15,22,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (142,1,15,23,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (143,1,1,24,'defectTypeDefectComparisonReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (144,1,17,24,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (145,1,18,24,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (146,1,15,24,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (147,1,20,24,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (148,1,1,25,'defectFrequencyReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (149,1,17,25,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (150,1,18,25,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (151,1,15,25,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (152,1,20,25,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (153,1,27,25,'Slow Time',false);

-- add indexes for faster domainconfig creation
create index ts_defect_defs_TranunitIndex on ts_defect_defs (ts_tranunit_id);
create index ts_defect_defs_TransetIndex on ts_defect_defs (ts_transet_id);
create index ts_transets_AppIndex on ts_transets (ts_app_id);
create index ts_tranunits_TransetIndex on ts_tranunits (ts_transet_id);
create index ts_trancomps_TranunitIndex on ts_trancomps (ts_tranunit_id);

-- Updating database version
update ts_domains set ts_db_versions='4.0.2';
