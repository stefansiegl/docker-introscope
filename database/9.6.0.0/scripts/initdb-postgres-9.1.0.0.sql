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

insert into ts_domains(ts_id, ts_name, ts_ip_address, ts_port, ts_db_versions, ts_tran_importance_id, ts_user_importance_id, version_info, ts_dynamic_group_reassign) values (1, 'Local Domain', 0, 80, '9.1.0.0', 5, 5, 1, false);

-- insert rows into the AppDef auth types table
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(1, 'Application Specific', false, 1);
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(2, 'CA SiteMinder', false, 1);
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(3, 'NTLM Authentication', false, 1);
Insert into ts_app_auth_types(ts_id, ts_name, ts_soft_delete, version_info) values(4, 'Basic Authentication', false, 1);

-- insert rows into the AppDef auth types table
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(1, 'Unknown', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(2, 'Generic', false, 1);
Insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(3, 'Siebel', false, 1);

-- insert rows into the AppDef table
Insert into ts_apps(ts_id, ts_domain_id, ts_authtype_id, ts_apptype_id, ts_name, ts_description, ts_charset, ts_session_timeout, ts_user_processing_type, ts_case_senstv_url_host, ts_case_senstv_url_path, ts_case_senstv_query_name, ts_case_senstv_query_value, ts_case_senstv_cookie_name, ts_case_senstv_cookie_value,ts_case_senstv_post_name, ts_case_senstv_post_value, ts_case_senstv_login_name, ts_soft_delete, version_info) values(1, 1, 1, 2, 'Default Application', 'Default Application', 'ISO-8859-1', 60, 0, true, true, true, true, true, true, true, true, true, false, 1);
-- Set the sequence value to restart
-- Set it to the value '700000000000000000' for the StaggeredAPMUpgrade feature
ALTER SEQUENCE ts_apps_ts_id_sq RESTART WITH 700000000000000000;

insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (1, 1, '*password', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (2, 1, '*passcode', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (3, 1, '*ssn', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (4, 1, 'pin', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (5, 1, 'pw', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (6, 1, 'pass', false, 1);
insert into ts_private_parameters(ts_id, ts_domain_id, ts_parameter_pattern, ts_soft_delete, version_info) values (7, 1, '*access_id', false, 1);

-- predefined user definition groups
insert into ts_user_def_groups(ts_id, ts_domain_id, ts_name, ts_description, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_user_stats, ts_soft_delete, version_info) values (1, 1, 'All', 'Parent of all other groups', 5, true, 95, true, 4, true, 8000, true, false, false, 1);
insert into ts_user_def_groups(ts_id, ts_domain_id, ts_name, ts_description, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_user_stats, ts_soft_delete, version_info) values (2, 1, 'Unspecified Users', 'Unspecified users', 5, true, 95, true, 4, true, 8000, true, false, false, 1);
insert into ts_user_def_groups(ts_id, ts_domain_id, ts_name, ts_description, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_user_stats, ts_soft_delete, version_info) values (3, 1, 'New Users', 'Newly discovered users', 5, true, 95, true, 4, true, 8000, true, false, false, 1);

-- predefined user groups
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (1, 1, null, 'All', 'Parent of all other groups', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (2, 2, 1, 'Unspecified Users', 'Unspecified users', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);
insert into ts_user_groups(ts_id, ts_userdef_group_id, ts_parent_id, ts_name, ts_description, ts_subnet_mask, ts_subnet_address, ts_group_by_ip_enabled, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_soft_delete, version_info) values (3, 3, 1, 'New Users', 'Newly discovered users', null, null, false, 5, true, 95, true, 4, true, 8000, true, false, 1);

-- predefined users
insert into ts_users(ts_id, ts_incarnation_id, ts_userdef_group_id, ts_first_name, ts_last_name, ts_login_name,ts_last_active_time, ts_inactivation_time, ts_active, ts_importance_id, ts_importance_inherited, ts_success_rate_sla, ts_success_sla_inherited, ts_sigma_sla, ts_sigma_sla_inherited, ts_tran_time_sla, ts_tran_time_sla_inherited, ts_collect_stats, ts_collect_stats_inherited, ts_soft_delete, version_info) values (1, 1, 2, 'Unspecified', '', 'Unspecified',current_timestamp, null, true, 5, true, 95, true, 4, true, 8000, true, false, true, false, 1);

-- add the unspecified user to the unspecified users group
insert into ts_usergroup_users_map(ts_usergroup_id, ts_user_id, ts_user_incarnation_id, ts_create_date, ts_delete_date, ts_soft_delete, version_info) values (2, 1, 1, CURRENT_TIMESTAMP, null, false, 1);

-- add the login name for the unknown user
insert into ts_user_logins_map(ts_app_id, ts_apptype_id, ts_user_id, ts_login_name, ts_raw_login_name, ts_create_date, ts_delete_date, ts_soft_delete, version_info) values (1, 1, 1, 'Unspecified', 'Unspecified', CURRENT_TIMESTAMP, null, false, 1);

-- rows must be ordered by increasing severity
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info, ts_fromname, ts_fromaddress,  ts_subject, ts_message) values(1, 1, 'Moderate', 1000, 256*256*255+256*198+0, 'i_moderate.gif', null, false, false, 1, 'CA CEM Administrator', 'support@myCompany.com', 'CA CEM Incident EMail - Moderate Severity Notification', 'This email has been sent to you by CA CEM Incident Engine because an incident is moderate severity.\n\nCA CEM System Administrators can change CA CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n');
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info, ts_fromname, ts_fromaddress,  ts_subject, ts_message) values(2, 1, 'Severe', 2500, 256*256*230+256*120+0, 'i_severe.gif', null, false, false, 1, 'CA CEM Administrator', 'support@myCompany.com', 'CA CEM Incident EMail - Severe Severity Notification', 'This email has been sent to you by CA CEM Incident Engine because an incident is severe severity.\n\nCA CEM System Administrators can change CA CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n');
Insert into ts_impact_settings(ts_id, ts_domain_id, ts_name, ts_weight, ts_color, ts_bitmap, ts_action_cmd, ts_action_enabled, ts_soft_delete, version_info, ts_fromname, ts_fromaddress,  ts_subject, ts_message) values(3, 1, 'Critical', 5000, 256*256*180+256*40+40, 'i_critical.gif', null, false, false, 1, 'CA CEM Administrator', 'support@myCompany.com', 'CA CEM Incident EMail - Critical Severity Notification', 'This email has been sent to you by CA CEM Incident Engine because an incident is critical severity.\n\nCA CEM System Administrators can change CA CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n');


-- insert rows into the SiteMinder Group table
Insert into ts_sm_groups(ts_name, ts_cookie_name, ts_shared_secret, ts_enabled, ts_soft_delete, version_info) values('Default SiteMinder Group', 'SMSESSION', 'Enter Shared Secret here', false, false, 1);

-- insert rows into the SiteMinder Web Servers table
-- TT48829 TESS cannot send siteminderconfig to Tims
insert into ts_sm_web_servers(ts_sm_group_id, ts_name, ts_from_ip_address, ts_to_ip_address, ts_ip_address_type, ts_port, ts_soft_delete, version_info) values(1, 'Default SiteMinder Web Servers', 0, 4294967295, 1, 0, false, 1);
-- TT49944: Database upgrade scripts should include insert script for ipv6 address range
insert into ts_sm_web_servers(ts_sm_group_id, ts_name, ts_from_ip_address, ts_to_ip_address, ts_ip_address_type, ts_port, ts_soft_delete, version_info) values(1, 'Default SiteMinder Web Servers', 0, 340282366920938463463374607431768211455, 2, 0, false, 1);

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
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (14, 'Introscope', 'appServerTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (15, 'Introscope', 'brtaTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (16, 'Introscope', 'slowestLowestComponent', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (17, 'Introscope', 'slowestLowestComponentTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (18, 'Introscope', 'slowestLowestBackendComponent', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (19, 'Introscope', 'slowestLowestBackendComponentTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (20, 'Introscope', 'agentHost|agentProcess|agentName', 1, false, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (21, 'Introscope', 'IntroscopeTranTrace', 1, false, false, 1);

-- enable 'User-Agent' field for display
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (22, 'RequestHeader', 'User-Agent', 1, true, false, 1);

-- Set the sequence value to restart
ALTER SEQUENCE ts_defect_meta_keys_ts_id_sq RESTART WITH 600000000000000000;

-- insert rows into the Introscope Config table
insert into ts_introscope_configs(ts_enabled, ts_soft_delete, version_info) values(true, false, 1);
insert into ts_introscope_ems(version_info, ts_name, ts_description, ts_username, ts_password, ts_hostname, ts_em_version, ts_web_view_version, ts_web_start_version, ts_port, ts_web_view_port, ts_web_start_port, ts_has_web_view, ts_has_web_start, ts_tran_trace_duration, ts_tran_trace_threshold_percnt, ts_enabled, ts_soft_delete)
 values (1, '', '', '','','localhost', '9.1.0.0', '', '',5001, 8080, 8081, false, false, 30, 50, false, false);

-- insert Jasper Reports items into ts_settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1001, 1, 'reports.userImage', 'report-logo.gif', 'image shown at top of an exported report', 'wily_logo.gif', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1002, 1, 'reports.userFooterText', '', 'text put at the bottom of an exported report', '', false);

-- insert exported reports email items into ts_settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1003, 1, 'email.smtpServer.hostname', '', 'Host name of SMTP server used to email exported reports', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1004, 1, 'email.smtpServer.port', '25', 'TCP port of SMTP server used to email exported reports', '25', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1005, 1, 'email.fromAddress', '', 'From: address used to email exported reports', 'ca-cem-reports@mycompany.com', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1006, 1, 'email.fromName', '', 'From: name used to email exported reports', 'CA CEM Reports Engine', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1007, 1, 'email.subject', 'CA CEM Report', 'text used as Subject:', 'CA CEM Report', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1008, 1, 'email.message', 'This email has been sent to you by the CA CEM Reports Engine.\nThe report is attached in PDF format.\n', 'text used in email body', 'This email has been sent to you by the CA CEM Reports Engine.\nThe report is attached in PDF format.\n', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1009, 1, 'email.to', '', 'comma separated list of receipients', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1010, 1, 'email.smtpServer.requireAuthentication', 'false', 'enables SMTP server authentication', 'false', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1011, 1, 'email.smtpServer.username', '', 'SMTP user name used in authentication', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1012, 1, 'email.smtpServer.password', '', 'SMTP password used in authentication', '', false);

-- insert Browser Language Pattern into ts_settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1013, 1, 'browser.language.pattern', 'en-us,af*', 'Browser Language Pattern Filter for TIM Recorder', 'en-us,af*', false);

-- insert license key settings
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1014, 1, 'license.lastSuccessfulCheck', '', 'Last successful license check', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1016, 1, 'license.notification', 'enabled', 'Enables/disables license warning notification', 'enabled', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1017, 1, 'license.reserve', '5', 'License warning when (100-reserve)% of licensed concurrent sessions is less than actual concurrent sessions', '5', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1018, 1, 'license.emailAddresses', '', 'Email address notified if a license warning is needed', '', false);

-- scheduled reports items
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1015, 1, 'reports.subject', 'Automatically Generated CEM Report', 'text used as Subject: for scheduled reports', 'Automatically Generated CEM Report', false);

-- BizEvent Trigger and Ageout Rules
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete)
values (1020, 1, 'bizEvent.evaluationIntervalDuration', '5', 'How often should check BizEvents to trigger or age-out', '5', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete)
values (1021, 1, 'bizEvent.ageoutRule.inactivity.enabled', 'true', 'Aging-out BizEvents based on inactivity (no new defects) is enabled', 'true', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete)
values (1022, 1, 'bizEvent.ageoutRule.inactivity.minutesSinceLastDefect', '1440', 'Aging-out BizEvents based on inactivity (no new defects) is enabled', '1440', false);

-- New Setting to incicate the change the passwords to FIPS compliant
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1023, 1, 'resetPasswordToEncryptionFIPSCompliant', 'false', 'Operator password, Interscope password, SMTP password should be modified based on FIPS compliance if upgrade happens', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1024, 1, 'encryptDefectHttpInfo', 'pwyvbUr3NAa14sv+hEvjSg==', 'Defect http information has to be encrypted based on FIPS', '', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1025, 1, 'encryptSessionId', 'pwyvbUr3NAa14sv+hEvjSg==', 'Session Id has to be encrypted based on FIPS', '', false);

--bizEvent email settings from 4.5.3.0
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1026, 1, 'email.bizEvent.sendEmailOnOpen', 'false', 'Flag to indicate if email should be sent when an incident is opened', 'false', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1027, 1, 'email.bizEvent.fromAddress', 'support@myCompany.com', 'From: address to be used from which email to be sent', 'support@myCompany.com', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1028, 1, 'email.bizEvent.fromName', 'CA CEM Administrator', 'From: Name to be used to email incident status', 'CA CEM Administrator', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1029, 1, 'email.bizEvent.subject', 'CA CEM Incident EMail - Open Notification', 'Text to be used as subject', 'CA CEM Incident EMail - Open Notification', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1030, 1, 'email.bizEvent.message', 'This email has been sent to you by CA CEM Incident Engine because an incident has been opened.\n\nCA CEM System Administrators can change CA CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n', 'Text to be used as body', 'This email has been sent to you by CA CEM Incident Engine because an incident has been opened.\n\nCA CEM System Administrators can change CA CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1031, 1, 'email.bizEvent.toAddress', '', 'Comma seperated list of recipients', '', false);

-- initialize upgrade to TIM Monitoring
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1032, 1, 'upgradeToTimMonitoring', 'false', 'Boolean to indicate if upgrade to TIM monitoring is completed or not', '', false);    

-- Set the sequence value to start after the last ID value
SELECT setval('ts_settings_ts_id_sq', (select max(ts_id) from ts_settings));

-- insert cemadmin and cemsystem in ts_operators
insert into ts_operators (ts_id, version_info, ts_username, ts_password, ts_first_name, ts_last_name, ts_email_address, ts_phone_number, ts_creation_time, ts_active, ts_soft_delete) values (0, 1, 'cemsystem', '', 'CEM', 'System', 'TechnicalSupport@ca.com', '1 888 GET CA (1-888-438-9459)', '2006-01-01 00:00:00.000-00', TRUE, FALSE);
insert into ts_operators (ts_id, version_info, ts_username, ts_password, ts_first_name, ts_last_name, ts_email_address, ts_phone_number, ts_creation_time, ts_active, ts_soft_delete) values (1, 1, 'cemadmin', '91c98dad1f8a1b601e682c06c4362983', 'CEM', 'Administrator', 'TechnicalSupport@ca.com', '1 888 GET CA (1-888-438-9459)', '2006-01-01 00:00:00.000-00', TRUE, FALSE);


-- Set the sequence value to start after the last ID value
SELECT setval('ts_operators_ts_id_sq', (select max(ts_id) from ts_operators));

-- insert default roles into ts_roles
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (1, 1, 'ROLE_CONFIG_ADMINISTRATOR', FALSE);
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (2, 1, 'ROLE_OPERATOR', FALSE);
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (3, 1, 'ROLE_SYSTEM_ADMINISTRATOR', FALSE);
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (4, 1, 'ROLE_TRIAGE_OPERATOR', FALSE);

-- assign the cemadmin and cemop the default roles
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date, ts_soft_delete) values (1, 1, 1, '2006-01-01 00:00:00.000-00', false);
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date, ts_soft_delete) values (1, 2, 1, '2006-01-01 00:00:00.000-00', false);
insert into ts_operator_role_map (ts_operator_id, ts_role_id, version_info, ts_create_date, ts_soft_delete) values (1, 3, 1, '2006-01-01 00:00:00.000-00', false);

-- insert the report types
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (1, 1, 'BizValueReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (2, 1, 'ImpactLeadersReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (3, 1, 'TranPerformanceReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (4, 1, 'TranQualityReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (5, 1, 'TranSlaPerformanceReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (6, 1, 'TranSlaQualityReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (7, 1, 'TranTrendPerformanceReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (8, 1, 'TranTrendQualityReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (9, 1, 'UserPerformanceReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (10, 1, 'UserQualityReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (11, 1, 'UserSlaPerformanceReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (12, 1, 'UserSlaQualityReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (13, 1, 'UserTrendPerformanceReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (14, 1, 'UserTrendQualityReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (15, 1, 'CorrelationalSlaReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (16, 1, 'TranCountReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (17, 1, 'TranDefectReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (18, 1, 'TranSizeReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (19, 1, 'TranSuccessRateReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (20, 1, 'TranThroughputReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (21, 1, 'TranTimeReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (22, 1, 'TranVolumeReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (23, 1, 'TranYieldReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (24, 1, 'TranDefectTypeReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (25, 1, 'TranDefectFrequencyReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (26, 1, 'SessionUsageReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (27, 1, 'IncidentsDataReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (28, 1, 'DefectsDataReport', false);
insert into ts_report_types(ts_id, version_info, ts_name, ts_soft_delete) values (29, 1, 'StatisticsDataReport', false);

-- Set the sequence value to start after the last ID value
SELECT setval('ts_report_types_ts_id_sq', (select max(ts_id) from ts_report_types));

-- insert the report param keys. 
-- NOTE: make sure the order of the insert statements to the ts_report_param_keys do not change
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (1,'url','','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (2,'owner','','com.timestock.tess.data.objects.Operator','',FALSE, 1);
-- email info keys
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (3,'fromName','','java.lang.String','CA CEM Reports Engine',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (4,'fromAddress','','java.lang.String','TechnicalSupport@ca.com',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (5,'to','','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (6,'subject','','java.lang.String','CA CEM Report',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (7,'message','','java.lang.String','This email has been sent to you by the CA CEM Reports Engine.\nThe report is attached in PDF format.\n',FALSE, 1);
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
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (26,'reportDimension','ReportDimension','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (27,'defectName','DefectName','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (28,'apps','AppsId','com.timestock.tess.data.objects.AppDef','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (29,'fromDate_text','FromDate','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (30,'toDate_text','ToDate','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (31,'sMetaKeys','MetaKeys','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (32,'sIncludeComponentTimingInfo','IncludeComponentTimingInfo','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (33,'sDefectType','DefectType','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (34,'sContentError','ContentError','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (35,'sRange','Range','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (36,'sLastXMinutes','LastXMinutes','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (37,'sLastNDefects','LastNDefects','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (38,'sAggregationType','AggregationType','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (39,'sInterval','Interval','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (40,'sThroughputValue','ThroughputValue','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (41,'sSizeValue','SizeValue','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (42,'sTimeValue','TimeValue','java.lang.String','',FALSE, 1);
insert into ts_report_param_keys (ts_id,ts_name,ts_query_string_name,ts_value_type,ts_default_value,ts_soft_delete, version_info) values (43,'sUserGroupOrUser','UserGroupOrUser','java.lang.String','',FALSE, 1);


-- Set the sequence value to start after the last ID value
SELECT setval('ts_report_param_keys_ts_id_sq', (select max(ts_id) from ts_report_param_keys));

-- report type param values
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (1,1,1,1,'roiReportPerformance.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (2,1,17,1,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (3,1,20,1,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (4,1,1,2,'impactLeadersReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (5,1,20,2,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (6,1,1,3,'tranPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (7,1,17,3,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (8,1,20,3,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (9,1,1,4,'tranQualityReport.html',false);
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
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (123,1,24,7,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (124,1,25,7,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (25,1,1,8,'tranTrendQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (26,1,15,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (27,1,17,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (28,1,21,8,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (29,1,22,8,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (125,1,24,8,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (126,1,25,8,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (30,1,1,9,'userPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (31,1,15,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (32,1,17,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (33,1,18,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (34,1,20,9,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (35,1,1,10,'userQualityReport.html',false);
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
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (119,1,24,13,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (120,1,25,13,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (56,1,1,14,'userTrendQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (57,1,15,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (58,1,18,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (59,1,17,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (60,1,21,14,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (61,1,22,14,'Yesterday',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (121,1,24,14,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (122,1,25,14,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (62,1,1,15,'correlationalSlaReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (64,1,15,15,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (160,1,17,15,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (65,1,18,15,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (66,1,20,15,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (81,1,1,16,'countReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (82,1,17,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (83,1,20,16,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (84,1,1,17,'defectReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (85,1,17,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (86,1,20,17,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (102,1,1,18,'sizeReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (103,1,17,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (104,1,20,18,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (87,1,1,19,'successRateReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (88,1,17,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (89,1,20,19,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (90,1,1,20,'throughputReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (91,1,17,20,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (92,1,20,20,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (93,1,1,21,'timeReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (94,1,17,21,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (95,1,20,21,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (96,1,1,22,'volumeReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (97,1,17,22,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (98,1,20,22,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (99,1,1,23,'yieldReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (100,1,17,23,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (101,1,20,23,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (105,1,18,3,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (106,1,18,4,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (107,1,18,5,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (108,1,18,6,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (109,1,18,7,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (110,1,18,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (111,1,18,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (112,1,18,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (113,1,18,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (114,1,18,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (115,1,18,20,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (116,1,18,21,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (117,1,18,22,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (118,1,18,23,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (127,1,26,16,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (128,1,26,17,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (129,1,26,18,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (130,1,26,19,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (131,1,26,20,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (132,1,26,21,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (133,1,26,22,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (134,1,26,23,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (135,1,15,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (136,1,15,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (137,1,15,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (138,1,15,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (139,1,15,20,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (140,1,15,21,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (141,1,15,22,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (142,1,15,23,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (143,1,1,24,'defectReport.html',false);
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
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (154,1,26,24,'comparison,timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (155,1,26,25,'timeSeries',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (156,1,1,26,'sessionUsageReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (157,1,20,26,'LastWeek',false);
-- Removed the LicenseComplianceReport type from ts_report_types as part of removing the Licensing from CEM for Tess on EM
-- insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (158,1,1,26,'licenseComplianceReport.html',false);
-- insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (159,1,20,26,'LastWeek',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (161,1,28,1,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (162,1,28,3,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (163,1,28,4,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (164,1,28,5,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (165,1,28,6,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (166,1,28,7,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (167,1,28,8,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (168,1,28,9,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (169,1,28,10,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (170,1,28,11,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (171,1,28,12,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (172,1,28,13,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (173,1,28,14,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (174,1,28,15,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (175,1,28,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (176,1,28,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (177,1,28,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (178,1,28,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (179,1,28,20,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (180,1,28,21,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (181,1,28,22,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (182,1,28,23,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (183,1,28,24,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (184,1,28,25,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (185,1,1,27,'incidentsDataReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (186,1,29,27,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (187,1,30,27,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (188,1,1,28,'defectsDataReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (189,1,28,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (190,1,18,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (191,1,17,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (192,1,15,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (193,1,31,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (194,1,32,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (195,1,33,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (196,1,34,28,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (197,1,35,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (198,1,36,28,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (199,1,37,28,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (200,1,29,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (201,1,30,28,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (202,1,1,29,'statisticsDataReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (203,1,28,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (204,1,18,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (205,1,17,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (206,1,38,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (207,1,39,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (208,1,29,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (209,1,30,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (210,1,40,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (211,1,41,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (212,1,42,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (213,1,43,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (214,1,15,29,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (215,1,16,29,'0',false);


-- Set the sequence value to start after the last ID value
SELECT setval('ts_rprt_type_prm_val_ts_id_sq', (select max(ts_id) from ts_report_type_param_values));

-- insert tang_config

insert into tang_config(ts_id, version_info, ts_key, ts_value) values(1, '0','database.schemaVersion', '10');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(2, '0','email.to', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(3, '0','email.fromName', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(4, '0','email.from', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(5, '0','email.subject', 'CA CEM Event');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(6, '0','email.smtpServer', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(7, '0','email.smtpServer.port', '25');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(8, '0','email.smtpServer.requireAuthentication', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(9, '0','email.smtpServer.username', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(10, '0','email.smtpServer.password', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(11, '0','email.message', 'This email has been sent to you by the CA CEM Events Engine.\n\nEvent Type ID: <id>\nEvent Name: <name>\nEvent Severity: <severity>\nEvent Category: <category>\nEvent Source: <source>\nEvent Source IP Address: <ipaddress>\nEvent Description: <desc>\nEvent Time: <time>\n');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(12, '0','snmp.trap.ipAddress', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(13, '0','config.maxEvents', '1000');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(14, '0','config.maxEventAge', '604800');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(15, '0','config.mailSchedule', '0');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(16, '0','config.eventRules', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(17, '0','config.eventRuleToIpAddress', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(18, '0','config.eventRuleFromIpAddress', '');

--insert tang_event_types
--not inserting some of the tang_event_types with ts_id (1,2,7,8 and 13) as they are no longer valid event types as Tess 
--is on EM and not renaming the ts_id for the tang_event_types in a sequence as this will involve lot of rework.

insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(3, 0, 'Enterprise Manager cannot reach TIM', 'error', 'Communications');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(4, 0, 'No network data', 'warning', 'Communications');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(5, 0, 'Enterprise Manager restarted', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(6, 0, 'TIM restarted', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(9, 0, 'Introscope unreachable', 'error', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(10, 0, 'User group limit reached', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(11, 0, 'Logins dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(12, 0, 'Defects dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(14, 0, 'Business application name is not valid', 'error', 'CA APM TG');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(15, 0, 'CA APM TG Agent is down', 'warning', 'CA APM TG');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(16, 0, 'CA APM TG Agent is up', 'informational', 'CA APM TG');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(17, 0, 'Duplicate session ids detected', 'warning', 'Monitoring');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(18, 0, 'HTTP Analyzer plug-in error', 'error', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(21, 0, 'Discovered transactions dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(22, 0, 'TIM Collection Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(23, 0, 'TIM Collection Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(24, 0, 'Stats Aggregation Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(25, 0, 'Stats Aggregation Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(26, 0, 'Database Cleanup Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(27, 0, 'Database Cleanup Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(28, 0, 'Limit exceeded adding new components', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(29, 0, 'TIM deleted some of its data files because disk space was low', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(30, 0, 'Enterprise Manager deleted some TIM data files because the lag-time threshold was met', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(32, 0, 'Errors processing statistics file(s).  See EM log for details.', 'error', 'Processing');

-- insert services_defs
insert into ts_services_def(ts_id, version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (1, 1, 'TIM.Collection.Svc', 'TIM Collection Service', 'The service includes: Login Processing, Defect Processing, Recording Processing, TANG Event Processing, Hourly Statistics Processing, BT Statistics Processing, Transaction Analysis Service', true, false, false);
insert into ts_services_def(ts_id, version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (2, 1, 'Stats.Aggregation.Svc', 'Stats Aggregation Service', 'The service aggregates the statistics on a daily basis, runs against the database', true, false, false);
insert into ts_services_def(ts_id, version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (3, 1, 'DB.Cleanup.Svc', 'DB Cleanup Service', 'The service cleans up aged out data from the database', true, false, false);

-- insert child_services_def
insert into ts_child_services_def(ts_id, version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 1, 'Login.Collection.Service', 'Login Collection Service', false, null, false);
insert into ts_child_services_def(ts_id, version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (2, 1, 1, 'Defect.Collection.Service', 'Defect Collection Service', false, null, false);
insert into ts_child_services_def(ts_id, version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (3, 1, 1, 'Recording.Collection.Service', 'Recording Collection Service', false, null, false);
insert into ts_child_services_def(ts_id, version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (4, 1, 1, 'Events.Collection.Service', 'Events Collection Service', false, null, false);
insert into ts_child_services_def(ts_id, version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (5, 1, 1, 'Hourly.Collection.Service', 'Hourly Collection Service', false, null, false);
insert into ts_child_services_def(ts_id, version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (6, 1, 1, 'Transaction.Discovery.Collection.Service', 'Transaction Discovery Collection Service', true, false, false);
insert into ts_child_services_def(ts_id, version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (7, 1, 1, 'RTTM.Collection.Service', 'RTTM Collection Service', true, true, false);

-- initialize ts_tran_types
insert into ts_tran_types(ts_id, ts_name) values(1, 'Component');
insert into ts_tran_types(ts_id, ts_name) values(2, 'Transaction');
insert into ts_tran_types(ts_id, ts_name) values(3, 'Business Transaction');

-- initialize ts_monitor_types with known types
insert into ts_monitor_types(ts_id, version_info, ts_name) values(1, 5, 'TIM');
insert into ts_monitor_types(ts_id, version_info, ts_name) values(2, 5, 'Agent');

-- initialize ts_protocols
insert into ts_protocols(ts_id, ts_name) values(1, 'http');

-- initialize ts_attributes
-- each attribute is specifically and directly referred to in the code. The ids are expected to be as specified below.
-- No reordering of entries should be done to this table without changing the code where the ids below
-- are referenced.  This is unlike other tables where the ids are auto-generated.
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(1, 1, 3, true, 'CEM', 'Transaction Time', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(2, 1, 3, true, 'CEM', 'Throughput', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(3, 1, 3, true, 'CEM', 'Transaction Size', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(4, 1, 3, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(5, 1, 2, true, 'CEM', 'Transaction Time', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(6, 1, 2, true, 'CEM', 'Throughput', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(7, 1, 2, true, 'CEM', 'Transaction Size', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(8, 1, 2, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(9, 1, 1, true, 'CEM', 'HTTP Code', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(10, 1, 1, true, 'CEM', 'Content Text', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(11, 1, 1, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(12, 1, 1, true, 'CEM', 'HTTP Response Header Text', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(13, 1, 2, true, 'ISCP', 'Response Time', 2, 2, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(14, 1, 2, true, 'ISCP', 'Errors Per Interval', 2, 2, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(15, 1, 2, true, 'ISCP', 'Response Per Interval', 2, 2, 1, false);

-- Set the sequence value to start after the last ID value
SELECT setval('ts_attributes_ts_id_sq', (select max(ts_id) from ts_attributes));
