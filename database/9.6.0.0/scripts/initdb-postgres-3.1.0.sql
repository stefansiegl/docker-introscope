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

insert into ts_domains(ts_id, ts_name, ts_ip_address, ts_port, ts_db_versions, ts_tran_importance_id, ts_user_importance_id, version_info) values (1, 'Local Domain', 0, 80, '3.1.0', 5, 5, 1);
\echo 'Info: domains table initialized.'
\echo ''

-- insert rows into the AppDef types table
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(1, 'Application Specific', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(2, 'Netegrity SiteMinder', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(3, 'NTLM Authentication', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(4, 'Basic Authentication', false, 1);

\echo 'Info: application types table initialized.'
\echo ''

-- insert rows into the AppDef table
Insert into ts_apps(ts_id, ts_domain_id, ts_apptype_id, ts_name, ts_description, ts_user_processing_type, ts_case_sensitivity_url_host, ts_case_sensitivity_url_path, ts_case_sensitivity_query_name, ts_case_sensitivity_query_value, ts_case_sensitivity_cookie_name, ts_case_sensitivity_cookie_value, ts_case_sensitivity_post_name, ts_case_sensitivity_post_value, ts_case_sensitivity_login_name, ts_soft_delete, version_info) values(1, 1, 1, 'Default Application', 'Default Application', 0, false, true, true, true, false, true, true, true, true, false, 1);

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
insert into ts_users(ts_id, ts_userdef_group_id, ts_first_name, ts_last_name, ts_last_active_time, ts_inactivation_time, ts_active, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_stats, ts_collect_stats_inherited, ts_soft_delete, version_info) values (1, 2, 'Unspecified', '', current_timestamp, null, true, 5, true, 95, true, 4, true, 8000, true, false, true, false, 1);

-- predefined user groups
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (1, 1, null, 'All', 'Parent of all other groups', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (2, 2, 1, 'Unspecified Users', 'Unspecified users', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (3, 3, 1, 'New Users', 'Newly discovered users', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);

-- add the unspecified user to the unspecified users group
insert into ts_usergroup_users_map(ts_usergroup_id, ts_user_id, ts_create_date, ts_delete_date, ts_soft_delete, version_info) values (2, 1, CURRENT_TIMESTAMP, null, false, 1);

-- add the login name for the unknown user
insert into ts_user_logins_map(ts_app_id, ts_user_id, ts_login_name, ts_raw_login_name, ts_create_date, ts_delete_date, ts_soft_delete, version_info) values (1, 1, 'Unspecified', 'Unspecified', CURRENT_TIMESTAMP, null, false, 1);

\echo 'Info: End Users information initialized.'
\echo ''


-- rows must be ordered by increasing severity
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info) values(1, 1, 'Moderate', 1000, 256*256*255+256*198+0, 'impact-yellow.gif', null, false, false, 1);
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info) values(2, 1, 'Severe', 2500, 256*256*230+256*120+0, 'impact-orange.gif', null, false, false, 1);
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info) values(3, 1, 'Critical', 5000, 256*256*180+256*40+40, 'impact-red.gif', null, false, false, 1);


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
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1004, 1, 'email.smtpServer.port', '', 'TCP port of SMTP server used to email exported reports', '25', false);
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


\echo 'Info: settings table initialized.'
\echo ''
