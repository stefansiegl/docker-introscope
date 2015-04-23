Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(1, 'Ignore', 0, false, 1);
Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(2, 'Minimum', 1, false, 1);
Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(3, 'Very Low', 2, false, 1);
Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(4, 'Low', 3, false, 1);
Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(5, 'Medium (Default)', 4, false, 1);
Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(6, 'High', 5, false, 1);
Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(7, 'Critical', 6, false, 1);
Insert into ts_tran_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(8, 'Trigger Immediately', 7, false, 1);

Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(1, 'Ignore', 0, false, 1);
Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(2, 'Minimum', 1, false, 1);
Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(3, 'Very Low', 2, false, 1);
Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(4, 'Low', 3, false, 1);
Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(5, 'Medium (Default)', 4, false, 1);
Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(6, 'High', 5, false, 1);
Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(7, 'Critical', 6, false, 1);
Insert into ts_defect_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(8, 'Trigger Immediately', 7, false, 1);

Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(1, 'Ignore', 0, false, 1);
Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(2, 'Minimum', 1, false, 1);
Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(3, 'Very Low', 2, false, 1);
Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(4, 'Low', 3, false, 1);
Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(5, 'Medium (Default)', 4, false, 1);
Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(6, 'High', 5, false, 1);
Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(7, 'Critical', 6, false, 1);
Insert into ts_user_importances(ts_id, ts_name, ts_weight, ts_soft_delete, version_info) values(8, 'Trigger Immediately', 7, false, 1);

\echo 'Info: importances tables initialized.'
\echo ''

insert into ts_domains(ts_id, ts_name, ts_ip_address, ts_port, ts_db_versions, ts_tran_importance_id, ts_user_importance_id, version_info) values (1, 'Local Domain', 0, 80, '3.3.4', 5, 5, 1);
\echo 'Info: domains table initialized.'
\echo ''

-- insert rows into the AppDef auth types table
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(1, 'Application Specific', false, 1);
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(2, 'eTrust SiteMinder', false, 1);
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(3, 'NTLM Authentication', false, 1);
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(4, 'Basic Authentication', false, 1);

\echo 'Info: application authorization types table initialized.'
\echo ''

-- insert rows into the AppDef auth types table
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(1, 'Unknown', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(2, 'Generic', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(3, 'Siebel', false, 1);

\echo 'Info: application types table initialized.'
\echo ''

-- insert rows into the AppDef table
Insert into ts_apps(ts_id, ts_domain_id, ts_authtype_id, ts_apptype_id, ts_name, ts_description, ts_user_processing_type, ts_case_sensitivity_url_host, ts_case_sensitivity_url_path, ts_case_sensitivity_query_name, ts_case_sensitivity_query_value, ts_case_sensitivity_cookie_name, ts_case_sensitivity_cookie_value, ts_case_sensitivity_post_name, ts_case_sensitivity_post_value, ts_case_sensitivity_login_name, ts_soft_delete, version_info) values(1, 1, 1, 2, 'Default Application', 'Default Application', 0, false, true, true, true, false, true, true, true, true, false, 1);

\echo 'Info: application table initialized.'
\echo ''

insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (1, 1, '*password', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (2, 1, '*passcode', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (3, 1, '*ssn', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (4, 1, 'pin', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (5, 1, 'pw', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (6, 1, 'pass', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (7, 1, '*access_id', false, 1);
\echo 'Info: private parameters table initialized.'
\echo ''

-- predefined user definition groups
insert into ts_user_def_groups(ts_id, ts_domain_id, ts_name, ts_description, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_user_stats, ts_soft_delete, version_info) values (1, 1, 'All', 'Parent of all other groups', 5, true, 95, true, 4, true, 8000, true, false, false, 1);
insert into ts_user_def_groups(ts_id, ts_domain_id, ts_name, ts_description, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_user_stats, ts_soft_delete, version_info) values (2, 1, 'Unspecified Users', 'Unspecified users', 5, true, 95, true, 4, true, 8000, true, false, false, 1);
insert into ts_user_def_groups(ts_id, ts_domain_id, ts_name, ts_description, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_user_stats, ts_soft_delete, version_info) values (3, 1, 'New Users', 'Newly discovered users', 5, true, 95, true, 4, true, 8000, true, false, false, 1);

-- predefined users
insert into ts_users(ts_id, ts_incarnation_id, ts_userdef_group_id, ts_first_name, ts_last_name, ts_last_active_time, ts_inactivation_time, ts_active, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_stats, ts_collect_stats_inherited, ts_soft_delete, version_info) values (1, 1, 2, 'Unspecified', '', current_timestamp, null, true, 5, true, 95, true, 4, true, 8000, true, false, true, false, 1);

-- predefined user groups
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (1, 1, null, 'All', 'Parent of all other groups', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (2, 2, 1, 'Unspecified Users', 'Unspecified users', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (3, 3, 1, 'New Users', 'Newly discovered users', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);

-- add the unspecified user to the unspecified users group
insert into ts_usergroup_users_map(ts_usergroup_id, ts_user_id, ts_user_incarnation_id, ts_create_date, ts_delete_date, ts_soft_delete, version_info) values (2, 1, 1, CURRENT_TIMESTAMP, null, false, 1);

-- add the login name for the unknown user
insert into ts_user_logins_map(ts_app_id, ts_apptype_id, ts_user_id, ts_login_name, ts_raw_login_name, ts_create_date, ts_delete_date, ts_soft_delete, version_info) values (1, 1, 1, 'Unspecified', 'Unspecified', CURRENT_TIMESTAMP, null, false, 1);

\echo 'Info: End Users information initialized.'
\echo ''


-- rows must be ordered by increasing severity
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info) values(1, 1, 'Moderate', 1000, 256*256*255+256*198+0, 'i_moderate.gif', null, false, false, 1);
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info) values(2, 1, 'Severe', 2500, 256*256*230+256*120+0, 'i_severe.gif', null, false, false, 1);
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info) values(3, 1, 'Critical', 5000, 256*256*180+256*40+40, 'i_critical.gif', null, false, false, 1);


\echo 'Info: impact settings table initialized.'
\echo ''

-- insert rows into the SiteMinder Group table
Insert into ts_sm_groups(ts_id, ts_name, ts_cookie_name, ts_shared_secret, ts_enabled, ts_soft_delete, version_info) values(1, 'Default SiteMinder Group', 'SMSESSION', 'Enter Shared Secret here', false, false, 1);


\echo 'Info: SiteMinder Policy Group table initialized.'
\echo ''


-- insert rows into the SiteMinder Web Servers table
Insert into ts_sm_web_servers(ts_id, ts_sm_group_id, ts_name, ts_from_ip_address, ts_to_ip_address, ts_port, ts_soft_delete, version_info) values(1, 1, 'Default SiteMinder Web Servers', 0, 4294967295, 0, false, 1);


\echo 'Info: SiteMinder Web Servers table initialized.'
\echo ''

-- insert rows into defect meta keys table
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (1, 'Introscope', 'guid', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (2, 'Introscope', 'appServerIp', 3, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (3, 'Introscope', 'agentName', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (4, 'Introscope', 'servletName', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (5, 'Introscope', 'servletResponseTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (6, 'Introscope', 'hasGuidInfo', 2, false, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (7, 'Introscope', 'hasTranTrace', 2, false, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (8, 'Introscope', 'hasErrorTrace', 2, false, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (9, 'Introscope', 'agentHost', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (10, 'Introscope', 'agentProcess', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (11, 'Introscope', 'backendIpList', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (12, 'Siebel', '_sn', 1, false, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (13, 'Siebel', 'SWEUAID', 1, false, false, 1);

\echo 'Info: Defect Meta Keys table initialized.'
\echo ''

-- insert rows into the Introscope Config table
insert into ts_introscope_configs(ts_id, ts_enabled, ts_soft_delete, version_info) values(1, false, false, 1);
insert into ts_introscope_ems(ts_id, version_info, ts_name, ts_description, ts_hostname, ts_web_view_version, ts_root_path, ts_port, ts_has_web_view, ts_enabled, ts_soft_delete) values (1, 1, '', '', '', '', '', 80, false, false, false);

\echo 'Info: Introscope Config table initialized.'
\echo ''

-- insert Jasper Reports items into ts_settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1001, 1, 'reports.userImage', 'report-logo.gif', 'image shown at top of an exported report', 'wily_logo.gif', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1002, 1, 'reports.userFooterText', '', 'text put at the bottom of an exported report', '', false);

-- insert exported reports email items into ts_settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1003, 1, 'email.smtpServer.hostname', '', 'Host name of SMTP server used to email exported reports', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1004, 1, 'email.smtpServer.port', '25', 'TCP port of SMTP server used to email exported reports', '25', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1005, 1, 'email.fromAddress', '', 'From: address used to email exported reports', 'wily-cem-reports@mycompany.com', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1006, 1, 'email.fromName', '', 'From: name used to email exported reports', 'Wily CEM Reports Engine', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1007, 1, 'email.subject', 'Wily CEM Report via email', 'text used as Subject:', 'Wily CEM Report via email', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1008, 1, 'email.message', 'This email has been sent to you by the Wily CEM Reports Engine.\nThe report is attached in PDF format.\n', 'text used in email body', 'This email has been sent to you by the Wily CEM Reports Engine.\nThe report is attached in PDF format.\n', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1009, 1, 'email.to', '', 'comma separated list of receipients', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1010, 1, 'email.smtpServer.requireAuthentication', 'false', 'enables SMTP server authentication', 'false', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1011, 1, 'email.smtpServer.username', '', 'SMTP user name used in authentication', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1012, 1, 'email.smtpServer.password', '', 'SMTP password used in authentication', '', false);

-- insert Browser Language Pattern into ts_settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1013, 1, 'browser.language.pattern', 'en-us,af*', 'Browser Language Pattern Filter for TIM Recorder', 'en-us,af*', false);

-- insert license key settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1014, 1, 'license.lastSuccessfulCheck', '', 'Last successful license check', '', false);

-- scheduled reports items
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1015, 1, 'reports.subject', 'Automatically Generated CEM Report', 'text used as Subject: for scheduled reports', 'Automatically Generated CEM Report', false);


\echo 'Info: settings table initialized.'
\echo ''

-- insert cemadmin and cemsystem in ts_operators
insert into ts_operators (ts_id, version_info, ts_username, ts_password, ts_first_name, ts_last_name, ts_email_address, ts_phone_number, ts_creation_time, ts_active, ts_soft_delete) values (0, 1, 'cemsystem', '', 'CEM', 'System', 'support@wilytech.com', '1 888 GET WILY (1-888-438-9459)', '2006-01-01 00:00:00.000-00', TRUE, FALSE);
insert into ts_operators (ts_id, version_info, ts_username, ts_password, ts_first_name, ts_last_name, ts_email_address, ts_phone_number, ts_creation_time, ts_active, ts_soft_delete) values (1, 1, 'cemadmin', '91c98dad1f8a1b601e682c06c4362983', 'CEM', 'Administrator', 'support@wilytech.com', '1 888 GET WILY (1-888-438-9459)', '2006-01-01 00:00:00.000-00', TRUE, FALSE);
\echo 'Info: ts_operators table initialized.'
\echo ''

-- insert default roles into ts_roles
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (1, 1, 'ROLE_CONFIG_ADMINISTRATOR', FALSE);
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (2, 1, 'ROLE_OPERATOR', FALSE);
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (3, 1, 'ROLE_SYSTEM_ADMINISTRATOR', FALSE);
\echo 'Info: ts_roles table initialized.'
\echo ''

-- assign the cemadmin and cemop the default roles
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date) values (1, 1, 1, '2006-01-01 00:00:00.000-00');
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date) values (1, 2, 1, '2006-01-01 00:00:00.000-00');
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date) values (1, 3, 1, '2006-01-01 00:00:00.000-00');

\echo 'Info: ts_operator_role_map table initialized.'
\echo ''TranPerformanceReport

-- insert the report types
insert into ts_report_types values (1, 1, 'BizValueReport', false);
insert into ts_report_types values (2, 1, 'ImpactLeadersReport', false);
insert into ts_report_types values (3, 1, 'TranPerformanceReport', false);
insert into ts_report_types values (4, 1, 'TranQualityReport', false);
insert into ts_report_types values (5, 1, 'TranSlaPerformanceReport', false);
insert into ts_report_types values (6, 1, 'TranSlaQualityReport', false);
insert into ts_report_types values (7, 1, 'TranTrendPerformanceReport', false);
insert into ts_report_types values (8, 1, 'TranTrendQualityReport', false);
insert into ts_report_types values (9, 1, 'UserPerformanceReport', false);
insert into ts_report_types values (10, 1, 'UserQualityReport', false);
insert into ts_report_types values (11, 1, 'UserSlaPerformanceReport', false);
insert into ts_report_types values (12, 1, 'UserSlaQualityReport', false);
insert into ts_report_types values (13, 1, 'UserTrendPerformanceReport', false);
insert into ts_report_types values (14, 1, 'UserTrendQualityReport', false);
insert into ts_report_types values (15, 1, 'CorrelationalSlaReport', false);

-- insert the report param keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (1,'url','','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (2,'owner','','com.timestock.tess.data.objects.Operator','',FALSE, 1);
-- email info keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (3,'fromName','','java.lang.String','Wily CEM Reports Engine',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (4,'fromAddress','','java.lang.String','support@wilytech.com',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (5,'to','','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (6,'subject','','java.lang.String','Wily CEM Report via email',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (7,'message','','java.lang.String','This email has been sent to you by the Wily CEM Reports Engine.\nThe report is attached in PDF format.\n',FALSE, 1);
-- trigger info keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (8,'frequency','','java.lang.Integer','0',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (9,'dayOfWeek','','java.lang.Integer','1',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (10,'dayOfMonth','','java.lang.Integer','1',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (11,'hour','','java.lang.Integer','3',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (12,'minute','','java.lang.Integer','30',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (13,'second','','java.lang.Integer','0',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (14,'status','','java.lang.Integer','',FALSE, 1);
-- report filter keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (15,'userGroup','UserGroupId','com.timestock.tess.data.objects.UserGroup','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (16,'user','UserId','com.timestock.tess.data.objects.User','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (17,'tranSetGroup','TranSetGroupId','com.timestock.tess.data.objects.TranSetGroup','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (18,'tranSetDef','TranSetId','com.timestock.tess.data.objects.TranSetDef','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (19,'tranUnitDef','TranUnitId','com.timestock.tess.data.objects.TranUnitDef','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (20,'timeFrame','Timeframe','com.timestock.tess.util.TimeFrame','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (21,'currentTimeframe','CurrentTimeframe','com.timestock.tess.util.TimeFrame','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (22,'previousTimeframe','PreviousTimeframe','com.timestock.tess.util.TimeFrame','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (23,'reportDate','ReportDate','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (24,'currentReportDate','CurrentReportDate','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (25,'previousReportDate','PreviousReportDate','java.lang.String','',FALSE, 1);

-- report type param values
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (1,1,1,1,'roiReportPerformance.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (2,1,17,1,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (3,1,20,1,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (4,1,1,2,'impactLeadersReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (5,1,20,2,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (6,1,1,3,'tranSetGroupPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (7,1,17,3,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (8,1,20,3,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (9,1,1,4,'tranSetGroupQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (10,1,17,4,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (11,1,20,4,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (12,1,1,5,'tranSlaPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (13,1,15,5,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (14,1,17,5,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (15,1,20,5,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (16,1,1,6,'tranSlaQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (17,1,15,6,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (18,1,17,6,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (19,1,20,6,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (20,1,1,7,'tranTrendPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (21,1,15,7,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (22,1,17,7,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (23,1,21,7,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (24,1,22,7,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (25,1,1,8,'tranTrendQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (26,1,15,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (27,1,17,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (28,1,21,8,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (29,1,22,8,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (30,1,1,9,'userGroupPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (31,1,15,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (32,1,17,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (33,1,18,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (34,1,20,9,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (35,1,1,10,'userGroupQualityReport',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (36,1,15,10,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (37,1,17,10,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (38,1,18,10,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (39,1,20,10,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (40,1,1,11,'userSlaPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (41,1,15,11,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (42,1,17,11,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (43,1,18,11,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (44,1,20,11,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (45,1,1,12,'userSlaQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (46,1,17,12,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (47,1,15,12,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (48,1,18,12,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (49,1,20,12,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (50,1,1,13,'userTrendPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (51,1,17,13,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (52,1,15,13,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (53,1,18,13,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (54,1,21,13,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (55,1,22,13,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (56,1,1,14,'userTrendQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (57,1,15,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (58,1,18,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (59,1,17,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (60,1,21,14,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (61,1,22,14,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (62,1,1,15,'correlationalSlaReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (64,1,15,15,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (65,1,18,15,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (66,1,20,15,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (119,1,24,13,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (120,1,25,13,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (121,1,24,14,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (122,1,25,14,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (123,1,24,7,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (124,1,25,7,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (125,1,24,8,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (126,1,25,8,'',false);
