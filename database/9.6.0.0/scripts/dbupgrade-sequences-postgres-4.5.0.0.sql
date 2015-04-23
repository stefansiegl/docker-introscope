-- This file updates the sequences used for the 
-- Primary Key generation of the tables

SELECT setval('ts_autogen_template_ts_id_seq', (select max(ts_id) from ts_autogen_template));

SELECT setval('ts_app_auth_types_ts_id_seq', (select max(ts_id) from ts_app_auth_types));

SELECT setval('ts_app_types_ts_id_seq', (select max(ts_id) from ts_app_types));

SELECT setval('ts_apps_ts_id_seq', (select max(ts_id) from ts_apps));

SELECT setval('ts_audit_record_props_ts_id_seq', (select max(ts_id) from ts_audit_record_props));

SELECT setval('ts_audit_records_ts_id_seq', (select max(ts_id) from ts_audit_records));

SELECT setval('ts_biz_events_ts_id_seq', (select max(ts_id) from ts_biz_events));

SELECT setval('ts_cached_reports_ts_id_seq', (select max(ts_id) from ts_cached_reports));

SELECT setval('ts_concurrent_sessions_ts_id_seq', (select max(ts_id) from ts_concurrent_sessions));

SELECT setval('ts_defect_defs_ts_id_seq', (select max(ts_id) from ts_defect_defs));

SELECT setval('ts_defect_importances_ts_id_seq', (select max(ts_id) from ts_defect_importances));

SELECT setval('ts_defect_meta_keys_ts_id_seq', (select max(ts_id) from ts_defect_meta_keys));

SELECT setval('ts_defect_meta_values_ts_id_seq', (select max(ts_id) from ts_defect_meta_values));

SELECT setval('ts_defects_ts_id_seq', (select max(ts_id) from ts_defects));

SELECT setval('ts_defects_interval_ts_id_seq', (select max(ts_id) from ts_defects_interval));

SELECT setval('ts_domains_ts_id_seq', (select max(ts_id) from ts_domains));

SELECT setval('ts_entity_ts_id_seq', (select max(ts_id) from ts_entity));

SELECT setval('ts_entity_service_ts_id_seq', (select max(ts_id) from ts_entity_service));

SELECT setval('ts_impact_settings_ts_id_seq', (select max(ts_id) from ts_impact_settings));

SELECT setval('ts_introscope_configs_ts_id_seq', (select max(ts_id) from ts_introscope_configs));
 
SELECT setval('ts_introscope_ems_ts_id_seq', (select max(ts_id) from ts_introscope_ems));

SELECT setval('ts_license_compliance_ts_id_seq', (select max(ts_id) from ts_license_compliance));

SELECT setval('ts_monitors_ts_id_seq', (select max(ts_id) from ts_monitors));

SELECT setval('ts_monitor_types_ts_id_seq', (select max(ts_id) from ts_monitor_types));

SELECT setval('ts_operators_ts_id_seq', (select max(ts_id) from ts_autogen_template));

SELECT setval('ts_autogen_template_ts_id_seq', (select max(ts_id) from ts_plugin));

SELECT setval('ts_plugin_filter_ts_id_seq', (select max(ts_id) from ts_plugin_filter));

SELECT setval('ts_plugin_url_filter_ts_id_seq', (select max(ts_id) from ts_plugin_url_filter));

SELECT setval('ts_private_parameters_ts_id_seq', (select max(ts_id) from ts_private_parameters));

SELECT setval('ts_protocols_ts_id_seq', (select max(ts_id) from ts_protocols));

SELECT setval('ts_recording_components_ts_id_seq', (select max(ts_id) from ts_recording_components));

SELECT setval('ts_recording_sessions_ts_id_seq', (select max(ts_id) from ts_recording_sessions));

SELECT setval('ts_report_def_param_values_ts_id_seq', (select max(ts_id) from ts_report_def_param_values));

SELECT setval('ts_report_defs_ts_id_seq', (select max(ts_id) from ts_report_defs));

SELECT setval('ts_report_param_keys_ts_id_seq', (select max(ts_id) from ts_report_param_keys));

SELECT setval('ts_report_type_param_values_ts_id_seq', (select max(ts_id) from ts_report_type_param_values));

SELECT setval('ts_report_types_ts_id_seq', (select max(ts_id) from ts_report_types));

SELECT setval('ts_roles_ts_id_seq', (select max(ts_id) from ts_roles));

SELECT setval('ts_services_def_ts_id_seq', (select max(ts_id) from ts_services_def));

SELECT setval('ts_session_usage_daily_ts_id_seq', (select max(ts_id) from ts_session_usage_daily));

SELECT setval('ts_session_usage_interval_ts_id_seq', (select max(ts_id) from ts_session_usage_interval));

SELECT setval('ts_session_usage_monthly_ts_id_seq', (select max(ts_id) from ts_session_usage_monthly));

SELECT setval('ts_session_usage_weekly_ts_id_seq', (select max(ts_id) from ts_session_usage_weekly));

SELECT setval('ts_settings_ts_id_seq', (select max(ts_id) from ts_settings));

SELECT setval('ts_sm_groups_ts_id_seq', (select max(ts_id) from ts_sm_groups));

SELECT setval('ts_sm_policy_servers_ts_id_seq', (select max(ts_id) from ts_sm_policy_servers));

SELECT setval('ts_sm_web_servers_ts_id_seq', (select max(ts_id) from ts_sm_web_servers));

SELECT setval('ts_stats_tran_user_interval_ts_id_seq', (select max(ts_id) from ts_stats_tran_user_interval));

SELECT setval('ts_stats_transet_all_daily_ts_id_seq', (select max(ts_id) from ts_stats_transet_all_daily));

SELECT setval('ts_stats_transet_all_interval_ts_id_seq', (select max(ts_id) from ts_stats_transet_all_interval));

SELECT setval('ts_stats_transet_all_monthly_ts_id_seq', (select max(ts_id) from ts_stats_transet_all_monthly));

SELECT setval('ts_stats_transet_all_weekly_ts_id_seq', (select max(ts_id) from ts_stats_transet_all_weekly));

SELECT setval('ts_stats_transet_usergroup_daily_ts_id_seq', (select max(ts_id) from ts_stats_transet_usergroup_daily));

SELECT setval('ts_stats_transet_usergroup_interval_ts_id_seq', (select max(ts_id) from ts_stats_transet_usergroup_interval));

SELECT setval('ts_stats_transet_usergroup_monthly_ts_id_seq', (select max(ts_id) from ts_stats_transet_usergroup_monthly));

SELECT setval('ts_stats_transet_usergroup_weekly_ts_id_seq', (select max(ts_id) from ts_stats_transet_usergroup_weekly));

SELECT setval('ts_stats_transet_user_daily_ts_id_seq', (select max(ts_id) from ts_stats_transet_user_daily));

SELECT setval('ts_stats_transet_user_interval_ts_id_seq', (select max(ts_id) from ts_stats_transet_user_interval));

SELECT setval('ts_stats_transet_user_monthly_ts_id_seq', (select max(ts_id) from ts_stats_transet_user_monthly));

SELECT setval('ts_stats_transet_user_weekly_ts_id_seq', (select max(ts_id) from ts_stats_transet_user_weekly));

SELECT setval('ts_stats_transetgroup_all_daily_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_all_daily));

SELECT setval('ts_stats_transetgroup_all_interval_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_all_interval));

SELECT setval('ts_stats_transetgroup_all_monthly_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_all_monthly));

SELECT setval('ts_stats_transetgroup_all_weekly_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_all_weekly));

SELECT setval('ts_stats_transetgroup_usergroup_daily_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_usergroup_daily));

SELECT setval('ts_stats_transetgroup_usergroup_interval_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_usergroup_interval));

SELECT setval('ts_stats_transetgroup_usergroup_monthly_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_usergroup_monthly));

SELECT setval('ts_stats_transetgroup_usergroup_weekly_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_usergroup_weekly));

SELECT setval('ts_stats_transetgroup_user_daily_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_user_daily));

SELECT setval('ts_stats_transetgroup_user_interval_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_user_interval));

SELECT setval('ts_stats_transetgroup_user_monthly_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_user_monthly));

SELECT setval('ts_stats_transetgroup_user_weekly_ts_id_seq', (select max(ts_id) from ts_stats_transetgroup_user_weekly));

SELECT setval('ts_stats_tranunit_all_daily_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_all_daily));

SELECT setval('ts_stats_tranunit_all_interval_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_all_interval));

SELECT setval('ts_stats_tranunit_all_monthly_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_all_monthly));

SELECT setval('ts_stats_tranunit_all_weekly_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_all_weekly));

SELECT setval('ts_stats_tranunit_usergroup_daily_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_usergroup_daily));

SELECT setval('ts_stats_tranunit_usergroup_interval_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_usergroup_interval));

SELECT setval('ts_stats_tranunit_usergroup_monthly_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_usergroup_monthly));

SELECT setval('ts_stats_tranunit_usergroup_weekly_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_usergroup_weekly));

SELECT setval('ts_stats_tranunit_user_daily_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_user_daily));

SELECT setval('ts_stats_tranunit_user_interval_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_user_interval));

SELECT setval('ts_stats_tranunit_user_monthly_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_user_monthly));

SELECT setval('ts_stats_tranunit_user_weekly_ts_id_seq', (select max(ts_id) from ts_stats_tranunit_user_weekly));

SELECT setval('ts_tran_def_groups_ts_id_seq', (select max(ts_id) from ts_tran_def_groups));

SELECT setval('ts_tran_importances_ts_id_seq', (select max(ts_id) from ts_tran_importances));

SELECT setval('ts_trancomps_ts_id_seq', (select max(ts_id) from ts_trancomps));

SELECT setval('ts_tran_comp_details_ts_id_seq', (select max(ts_id) from ts_tran_comp_details));

SELECT setval('ts_transet_groups_ts_id_seq', (select max(ts_id) from ts_transet_groups));

SELECT setval('ts_transets_ts_id_seq', (select max(ts_id) from ts_transets));

SELECT setval('ts_tran_types_ts_id_seq', (select max(ts_id) from ts_tran_types));

SELECT setval('ts_tranunits_ts_id_seq', (select max(ts_id) from ts_tranunits));

SELECT setval('ts_user_def_groups_ts_id_seq', (select max(ts_id) from ts_user_def_groups));

SELECT setval('ts_user_groups_ts_id_seq', (select max(ts_id) from ts_user_groups));

SELECT setval('ts_user_importances_ts_id_seq', (select max(ts_id) from ts_user_importances));

SELECT setval('ts_users_ts_id_seq', (select max(ts_id) from ts_users));

SELECT setval('ts_web_servers_ts_id_seq', (select max(ts_id) from ts_web_servers));

SELECT setval('tang_config_ts_id_seq', (select max(ts_id) from tang_config));

SELECT setval('tang_event_types_ts_id_seq', (select max(ts_id) from tang_event_types));

SELECT setval('tang_events_ts_id_seq', (select max(ts_id) from tang_events));
