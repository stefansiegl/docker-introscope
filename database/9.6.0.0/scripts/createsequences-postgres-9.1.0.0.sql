-- This file creates the sequences required for the 
-- Primary Key generation of the tables

CREATE SEQUENCE ts_apps_ts_id_sq;
ALTER SEQUENCE ts_apps_ts_id_sq OWNED BY ts_apps.ts_id;
ALTER TABLE ts_apps ALTER COLUMN ts_id SET DEFAULT nextval('ts_apps_ts_id_sq');
-- This is for the StaggeredAPMUpgrade feature ... to avoid conflicts when merging DBs
ALTER SEQUENCE ts_apps_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_attributes_ts_id_sq;
ALTER SEQUENCE ts_attributes_ts_id_sq OWNED BY ts_attributes.ts_id;
ALTER TABLE ts_attributes ALTER COLUMN ts_id SET DEFAULT nextval('ts_attributes_ts_id_sq');

CREATE SEQUENCE ts_audit_rcrd_props_ts_id_sq ;
ALTER SEQUENCE ts_audit_rcrd_props_ts_id_sq OWNED BY ts_audit_record_props.ts_id;
ALTER TABLE ts_audit_record_props ALTER COLUMN ts_id SET DEFAULT nextval('ts_audit_rcrd_props_ts_id_sq ');

CREATE SEQUENCE ts_audit_records_ts_id_sq ;
ALTER SEQUENCE ts_audit_records_ts_id_sq  OWNED BY ts_audit_records.ts_id;
ALTER TABLE ts_audit_records ALTER COLUMN ts_id SET DEFAULT nextval('ts_audit_records_ts_id_sq ');

CREATE SEQUENCE ts_autogen_tmplt_ts_id_sq;
ALTER SEQUENCE ts_autogen_tmplt_ts_id_sq OWNED BY ts_autogen_template.ts_id;
ALTER TABLE ts_autogen_template ALTER COLUMN ts_id SET DEFAULT nextval('ts_autogen_tmplt_ts_id_sq');

CREATE SEQUENCE ts_biz_events_ts_id_sq;
ALTER SEQUENCE ts_biz_events_ts_id_sq OWNED BY ts_biz_events.ts_id;
ALTER TABLE ts_biz_events ALTER COLUMN ts_id SET DEFAULT nextval('ts_biz_events_ts_id_sq');

CREATE SEQUENCE ts_cached_reports_ts_id_sq;
ALTER SEQUENCE ts_cached_reports_ts_id_sq OWNED BY ts_cached_reports.ts_id;
ALTER TABLE ts_cached_reports ALTER COLUMN ts_id SET DEFAULT nextval('ts_cached_reports_ts_id_sq');

CREATE SEQUENCE ts_child_servc_def_ts_id_sq;
ALTER SEQUENCE ts_child_servc_def_ts_id_sq OWNED BY ts_child_services_def.ts_id;
ALTER TABLE ts_child_services_def ALTER COLUMN ts_id SET DEFAULT nextval('ts_child_servc_def_ts_id_sq');

CREATE SEQUENCE ts_concur_sessions_ts_id_sq;
ALTER SEQUENCE ts_concur_sessions_ts_id_sq OWNED BY ts_concurrent_sessions.ts_id;
ALTER TABLE ts_concurrent_sessions ALTER COLUMN ts_id SET DEFAULT nextval('ts_concur_sessions_ts_id_sq');

CREATE SEQUENCE ts_defect_defs_ts_id_sq;
ALTER SEQUENCE ts_defect_defs_ts_id_sq OWNED BY ts_defect_defs.ts_id;
ALTER TABLE ts_defect_defs ALTER COLUMN ts_id SET DEFAULT nextval('ts_defect_defs_ts_id_sq');
ALTER SEQUENCE ts_defect_defs_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_bizdef_filters_ts_id_sq;
ALTER SEQUENCE ts_bizdef_filters_ts_id_sq OWNED BY ts_bizdef_filters.ts_id;
ALTER TABLE ts_bizdef_filters ALTER COLUMN ts_id SET DEFAULT nextval('ts_bizdef_filters_ts_id_sq');

CREATE SEQUENCE ts_defect_meta_keys_ts_id_sq; 
ALTER SEQUENCE ts_defect_meta_keys_ts_id_sq OWNED BY ts_defect_meta_keys.ts_id;
ALTER TABLE ts_defect_meta_keys ALTER COLUMN ts_id SET DEFAULT nextval('ts_defect_meta_keys_ts_id_sq');
ALTER SEQUENCE ts_defect_meta_keys_ts_id_sq RESTART WITH 600000000000000000;

CREATE SEQUENCE ts_dfct_meta_values_ts_id_sq;
ALTER SEQUENCE ts_dfct_meta_values_ts_id_sq OWNED BY ts_defect_meta_values.ts_id;
ALTER TABLE ts_defect_meta_values ALTER COLUMN ts_id SET DEFAULT nextval('ts_dfct_meta_values_ts_id_sq');

CREATE SEQUENCE ts_defects_itvl_ts_id_sq;
ALTER SEQUENCE ts_defects_itvl_ts_id_sq OWNED BY ts_defects_interval.ts_id;
ALTER TABLE ts_defects_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_defects_itvl_ts_id_sq');

CREATE SEQUENCE ts_entity_ts_id_sq;
ALTER SEQUENCE ts_entity_ts_id_sq OWNED BY ts_entity.ts_id;
ALTER TABLE ts_entity ALTER COLUMN ts_id SET DEFAULT nextval('ts_entity_ts_id_sq');

CREATE SEQUENCE ts_entity_service_ts_id_sq;
ALTER SEQUENCE ts_entity_service_ts_id_sq OWNED BY ts_entity_service.ts_id;
ALTER TABLE ts_entity_service ALTER COLUMN ts_id SET DEFAULT nextval('ts_entity_service_ts_id_sq');

CREATE SEQUENCE ts_entitysvc_svc_num_sq;
ALTER SEQUENCE ts_entitysvc_svc_num_sq OWNED BY ts_entity_service.ts_service_number;
ALTER TABLE ts_entity_service ALTER COLUMN ts_service_number SET DEFAULT nextval('ts_entitysvc_svc_num_sq');

CREATE SEQUENCE ts_hourly_aggr_log_ts_id_sq;
ALTER SEQUENCE ts_hourly_aggr_log_ts_id_sq OWNED BY ts_hourly_aggregation_log.ts_id;
ALTER TABLE ts_hourly_aggregation_log ALTER COLUMN ts_id SET DEFAULT nextval('ts_hourly_aggr_log_ts_id_sq');

CREATE SEQUENCE ts_impact_settings_ts_id_sq; 
ALTER SEQUENCE ts_impact_settings_ts_id_sq OWNED BY ts_impact_settings.ts_id;
ALTER TABLE ts_impact_settings ALTER COLUMN ts_id SET DEFAULT nextval('ts_impact_settings_ts_id_sq');

CREATE SEQUENCE ts_introscope_cfgs_ts_id_sq; 
ALTER SEQUENCE ts_introscope_cfgs_ts_id_sq OWNED BY ts_introscope_configs.ts_id;
ALTER TABLE ts_introscope_configs ALTER COLUMN ts_id SET DEFAULT nextval('ts_introscope_cfgs_ts_id_sq');
 
CREATE SEQUENCE ts_introscope_ems_ts_id_sq;
ALTER SEQUENCE ts_introscope_ems_ts_id_sq OWNED BY ts_introscope_ems.ts_id;
ALTER TABLE ts_introscope_ems ALTER COLUMN ts_id SET DEFAULT nextval('ts_introscope_ems_ts_id_sq');

CREATE SEQUENCE ts_monitors_ts_id_sq; 
ALTER SEQUENCE ts_monitors_ts_id_sq OWNED BY ts_monitors.ts_id;
ALTER TABLE ts_monitors ALTER COLUMN ts_id SET DEFAULT nextval('ts_monitors_ts_id_sq');
ALTER SEQUENCE ts_monitors_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_montr_child_srvc_ts_id_sq;
ALTER SEQUENCE ts_montr_child_srvc_ts_id_sq OWNED BY ts_monitor_child_service.ts_id;
ALTER TABLE ts_monitor_child_service ALTER COLUMN ts_id SET DEFAULT nextval('ts_montr_child_srvc_ts_id_sq');

CREATE SEQUENCE ts_operators_ts_id_sq;
ALTER SEQUENCE ts_operators_ts_id_sq OWNED BY ts_operators.ts_id;
ALTER TABLE ts_operators ALTER COLUMN ts_id SET DEFAULT nextval('ts_operators_ts_id_sq');

CREATE SEQUENCE ts_plugin_ts_id_sq;
ALTER SEQUENCE ts_plugin_ts_id_sq OWNED BY ts_plugin.ts_id;
ALTER TABLE ts_plugin ALTER COLUMN ts_id SET DEFAULT nextval('ts_plugin_ts_id_sq');

CREATE SEQUENCE ts_plugin_filter_ts_id_sq;
ALTER SEQUENCE ts_plugin_filter_ts_id_sq OWNED BY ts_plugin_filter.ts_id;
ALTER TABLE ts_plugin_filter ALTER COLUMN ts_id SET DEFAULT nextval('ts_plugin_filter_ts_id_sq');

CREATE SEQUENCE ts_plugin_url_filter_ts_id_sq;	
ALTER SEQUENCE ts_plugin_url_filter_ts_id_sq OWNED BY ts_plugin_url_filter.ts_id;
ALTER TABLE ts_plugin_url_filter ALTER COLUMN ts_id SET DEFAULT nextval('ts_plugin_url_filter_ts_id_sq');

CREATE SEQUENCE ts_private_params_ts_id_sq; 
ALTER SEQUENCE ts_private_params_ts_id_sq OWNED BY ts_private_parameters.ts_id;
ALTER TABLE ts_private_parameters ALTER COLUMN ts_id SET DEFAULT nextval('ts_private_params_ts_id_sq');
ALTER SEQUENCE ts_private_params_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_record_components_ts_id_sq; 
ALTER SEQUENCE ts_record_components_ts_id_sq OWNED BY ts_recording_components.ts_id;
ALTER TABLE ts_recording_components ALTER COLUMN ts_id SET DEFAULT nextval('ts_record_components_ts_id_sq');
ALTER SEQUENCE ts_record_components_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_record_sessions_ts_id_sq;
ALTER SEQUENCE ts_record_sessions_ts_id_sq OWNED BY ts_recording_sessions.ts_id;
ALTER TABLE ts_recording_sessions ALTER COLUMN ts_id SET DEFAULT nextval('ts_record_sessions_ts_id_sq');
ALTER SEQUENCE ts_record_sessions_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_rprt_def_parm_val_ts_id_sq; 
ALTER SEQUENCE ts_rprt_def_parm_val_ts_id_sq OWNED BY ts_report_def_param_values.ts_id;
ALTER TABLE ts_report_def_param_values ALTER COLUMN ts_id SET DEFAULT nextval('ts_rprt_def_parm_val_ts_id_sq');

CREATE SEQUENCE ts_report_defs_ts_id_sq;
ALTER SEQUENCE ts_report_defs_ts_id_sq OWNED BY ts_report_defs.ts_id;
ALTER TABLE ts_report_defs ALTER COLUMN ts_id SET DEFAULT nextval('ts_report_defs_ts_id_sq');

CREATE SEQUENCE ts_report_param_keys_ts_id_sq;
ALTER SEQUENCE ts_report_param_keys_ts_id_sq OWNED BY ts_report_param_keys.ts_id;
ALTER TABLE ts_report_param_keys ALTER COLUMN ts_id SET DEFAULT nextval('ts_report_param_keys_ts_id_sq');

CREATE SEQUENCE ts_rprt_type_prm_val_ts_id_sq;
ALTER SEQUENCE ts_rprt_type_prm_val_ts_id_sq OWNED BY ts_report_type_param_values.ts_id;
ALTER TABLE ts_report_type_param_values ALTER COLUMN ts_id SET DEFAULT nextval('ts_rprt_type_prm_val_ts_id_sq');

CREATE SEQUENCE ts_report_types_ts_id_sq; 
ALTER SEQUENCE ts_report_types_ts_id_sq OWNED BY ts_report_types.ts_id;
ALTER TABLE ts_report_types ALTER COLUMN ts_id SET DEFAULT nextval('ts_report_types_ts_id_sq');

CREATE SEQUENCE ts_session_usage_dly_ts_id_sq;
ALTER SEQUENCE ts_session_usage_dly_ts_id_sq OWNED BY ts_session_usage_daily.ts_id;
ALTER TABLE ts_session_usage_daily ALTER COLUMN ts_id SET DEFAULT nextval('ts_session_usage_dly_ts_id_sq');

CREATE SEQUENCE ts_ses_usage_itvl_ts_id_sq; 
ALTER SEQUENCE ts_ses_usage_itvl_ts_id_sq OWNED BY ts_session_usage_interval.ts_id;
ALTER TABLE ts_session_usage_interval ALTER COLUMN ts_id SET DEFAULT nextval('ts_ses_usage_itvl_ts_id_sq');

CREATE SEQUENCE ts_ses_usage_mtly_ts_id_sq;
ALTER SEQUENCE ts_ses_usage_mtly_ts_id_sq OWNED BY ts_session_usage_monthly.ts_id;
ALTER TABLE ts_session_usage_monthly ALTER COLUMN ts_id SET DEFAULT nextval('ts_ses_usage_mtly_ts_id_sq');

CREATE SEQUENCE ts_ses_usage_wkly_ts_id_sq;
ALTER SEQUENCE ts_ses_usage_wkly_ts_id_sq OWNED BY ts_session_usage_weekly.ts_id;
ALTER TABLE ts_session_usage_weekly ALTER COLUMN ts_id SET DEFAULT nextval('ts_ses_usage_wkly_ts_id_sq');

CREATE SEQUENCE ts_settings_ts_id_sq;
ALTER SEQUENCE ts_settings_ts_id_sq OWNED BY ts_settings.ts_id;
ALTER TABLE ts_settings ALTER COLUMN ts_id SET DEFAULT nextval('ts_settings_ts_id_sq');

CREATE SEQUENCE ts_sm_groups_ts_id_sq;
ALTER SEQUENCE ts_sm_groups_ts_id_sq OWNED BY ts_sm_groups.ts_id;
ALTER TABLE ts_sm_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_sm_groups_ts_id_sq');

CREATE SEQUENCE ts_sm_policy_servers_ts_id_sq;
ALTER SEQUENCE ts_sm_policy_servers_ts_id_sq OWNED BY ts_sm_policy_servers.ts_id;
ALTER TABLE ts_sm_policy_servers ALTER COLUMN ts_id SET DEFAULT nextval('ts_sm_policy_servers_ts_id_sq');

CREATE SEQUENCE ts_sm_web_servers_ts_id_sq; 
ALTER SEQUENCE ts_sm_web_servers_ts_id_sq OWNED BY ts_sm_web_servers.ts_id;
ALTER TABLE ts_sm_web_servers ALTER COLUMN ts_id SET DEFAULT nextval('ts_sm_web_servers_ts_id_sq');

CREATE SEQUENCE ts_start_times_ts_id_sq;
ALTER SEQUENCE ts_start_times_ts_id_sq OWNED BY ts_services_start_times.ts_id;
ALTER TABLE ts_services_start_times ALTER COLUMN ts_id SET DEFAULT nextval('ts_start_times_ts_id_sq');
                
CREATE SEQUENCE ts_stat_t_us_itvl_id_sq;
ALTER SEQUENCE ts_stat_t_us_itvl_id_sq OWNED BY ts_st_t_us_int.ts_id;
ALTER TABLE ts_st_t_us_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_t_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_all_dly_id_sq;
ALTER SEQUENCE ts_stat_ts_all_dly_id_sq OWNED BY ts_st_ts_all_dly.ts_id;
ALTER TABLE ts_st_ts_all_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_all_dly_id_sq');

CREATE SEQUENCE ts_stat_ts_all_itvl_id_sq;
ALTER SEQUENCE ts_stat_ts_all_itvl_id_sq OWNED BY ts_st_ts_all_int.ts_id;
ALTER TABLE ts_st_ts_all_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_all_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_all_mtly_id_sq; 
ALTER SEQUENCE ts_stat_ts_all_mtly_id_sq OWNED BY ts_st_ts_all_mly.ts_id;
ALTER TABLE ts_st_ts_all_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_all_mtly_id_sq');

CREATE SEQUENCE ts_stat_ts_all_wkly_id_sq; 
ALTER SEQUENCE ts_stat_ts_all_wkly_id_sq OWNED BY ts_st_ts_all_wly.ts_id;
ALTER TABLE ts_st_ts_all_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_all_wkly_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_dly_id_sq; 
ALTER SEQUENCE ts_stat_ts_usgrp_dly_id_sq OWNED BY ts_st_ts_usgrp_dly.ts_id;
ALTER TABLE ts_st_ts_usgrp_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_dly_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_itvl_id_sq; 
ALTER SEQUENCE ts_stat_ts_usgrp_itvl_id_sq OWNED BY ts_st_ts_usgrp_int.ts_id;
ALTER TABLE ts_st_ts_usgrp_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_mtly_id_sq;
ALTER SEQUENCE ts_stat_ts_usgrp_mtly_id_sq OWNED BY ts_st_ts_usgrp_mly.ts_id;
ALTER TABLE ts_st_ts_usgrp_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_mtly_id_sq');

CREATE SEQUENCE ts_stat_ts_usgrp_wkly_id_sq;
ALTER SEQUENCE ts_stat_ts_usgrp_wkly_id_sq OWNED BY ts_st_ts_usgrp_wly.ts_id;
ALTER TABLE ts_st_ts_usgrp_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_usgrp_wkly_id_sq');

CREATE SEQUENCE ts_stat_ts_us_dly_id_sq; 
ALTER SEQUENCE ts_stat_ts_us_dly_id_sq OWNED BY ts_st_ts_us_dly.ts_id;
ALTER TABLE ts_st_ts_us_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_dly_id_sq');

CREATE SEQUENCE ts_stat_ts_us_itvl_id_sq; 
ALTER SEQUENCE ts_stat_ts_us_itvl_id_sq OWNED BY ts_st_ts_us_int.ts_id;
ALTER TABLE ts_st_ts_us_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_ts_us_mtly_id_sq;
ALTER SEQUENCE ts_stat_ts_us_mtly_id_sq OWNED BY ts_st_ts_us_mly.ts_id;
ALTER TABLE ts_st_ts_us_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_mtly_id_sq');

CREATE SEQUENCE ts_stat_ts_us_wkly_id_sq;
ALTER SEQUENCE ts_stat_ts_us_wkly_id_sq OWNED BY ts_st_ts_us_wly.ts_id;
ALTER TABLE ts_st_ts_us_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_ts_us_wkly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_dly_id_sq; 
ALTER SEQUENCE ts_stat_tsgrp_all_dly_id_sq OWNED BY ts_st_tsgrp_all_dly.ts_id;
ALTER TABLE ts_st_tsgrp_all_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_dly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_itvl_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_all_itvl_id_sq OWNED BY ts_st_tsgrp_all_int.ts_id;
ALTER TABLE ts_st_tsgrp_all_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_itvl_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_mtly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_all_mtly_id_sq OWNED BY ts_st_tsgrp_all_mly.ts_id;
ALTER TABLE ts_st_tsgrp_all_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_mtly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_all_wkly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_all_wkly_id_sq OWNED BY ts_st_tsgrp_all_wly.ts_id;
ALTER TABLE ts_st_tsgrp_all_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_all_wkly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_dly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_usgrp_dly_id_sq OWNED BY ts_st_tsgrp_usgrp_dly.ts_id;
ALTER TABLE ts_st_tsgrp_usgrp_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_dly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_itvl_id_sq; 
ALTER SEQUENCE ts_stat_tsgrp_usgrp_itvl_id_sq OWNED BY ts_st_tsgrp_usgrp_int.ts_id;
ALTER TABLE ts_st_tsgrp_usgrp_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_itvl_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_mtly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_usgrp_mtly_id_sq OWNED BY ts_st_tsgrp_usgrp_mly.ts_id;
ALTER TABLE ts_st_tsgrp_usgrp_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_mtly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_usgrp_wkly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_usgrp_wkly_id_sq OWNED BY ts_st_tsgrp_usgrp_wly.ts_id;
ALTER TABLE ts_st_tsgrp_usgrp_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_usgrp_wkly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_dly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_us_dly_id_sq OWNED BY ts_st_tsgrp_us_dly.ts_id;
ALTER TABLE ts_st_tsgrp_us_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_dly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_itvl_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_us_itvl_id_sq OWNED BY ts_st_tsgrp_us_int.ts_id;
ALTER TABLE ts_st_tsgrp_us_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_mtly_id_sq;
ALTER SEQUENCE ts_stat_tsgrp_us_mtly_id_sq OWNED BY ts_st_tsgrp_us_mly.ts_id;
ALTER TABLE ts_st_tsgrp_us_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_mtly_id_sq');

CREATE SEQUENCE ts_stat_tsgrp_us_wkly_id_sq; 
ALTER SEQUENCE ts_stat_tsgrp_us_wkly_id_sq OWNED BY ts_st_tsgrp_us_wly.ts_id;
ALTER TABLE ts_st_tsgrp_us_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tsgrp_us_wkly_id_sq');

CREATE SEQUENCE ts_stat_tu_all_dly_id_sq;
ALTER SEQUENCE ts_stat_tu_all_dly_id_sq OWNED BY ts_st_tu_all_dly.ts_id;
ALTER TABLE ts_st_tu_all_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_dly_id_sq');

CREATE SEQUENCE ts_stat_tu_all_itvl_id_sq; 
ALTER SEQUENCE ts_stat_tu_all_itvl_id_sq OWNED BY ts_st_tu_all_int.ts_id;
ALTER TABLE ts_st_tu_all_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_itvl_id_sq');

CREATE SEQUENCE ts_stat_tu_all_mtly_id_sq;
ALTER SEQUENCE ts_stat_tu_all_mtly_id_sq OWNED BY ts_st_tu_all_mly.ts_id;
ALTER TABLE ts_st_tu_all_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_mtly_id_sq');

CREATE SEQUENCE ts_stat_tu_all_wkly_id_sq; 
ALTER SEQUENCE ts_stat_tu_all_wkly_id_sq OWNED BY ts_st_tu_all_wly.ts_id;
ALTER TABLE ts_st_tu_all_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_all_wkly_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_dly_id_sq;
ALTER SEQUENCE ts_stat_tu_usgrp_dly_id_sq OWNED BY ts_st_tu_usgrp_dly.ts_id;
ALTER TABLE ts_st_tu_usgrp_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_dly_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_itvl_id_sq; 
ALTER SEQUENCE ts_stat_tu_usgrp_itvl_id_sq OWNED BY ts_st_tu_usgrp_int.ts_id;
ALTER TABLE ts_st_tu_usgrp_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_itvl_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_mtly_id_sq; 
ALTER SEQUENCE ts_stat_tu_usgrp_mtly_id_sq OWNED BY ts_st_tu_usgrp_mly.ts_id;
ALTER TABLE ts_st_tu_usgrp_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_mtly_id_sq');

CREATE SEQUENCE ts_stat_tu_usgrp_wkly_id_sq;
ALTER SEQUENCE ts_stat_tu_usgrp_wkly_id_sq OWNED BY ts_st_tu_usgrp_wly.ts_id;
ALTER TABLE ts_st_tu_usgrp_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_usgrp_wkly_id_sq');

CREATE SEQUENCE ts_stat_tu_us_dly_id_sq; 
ALTER SEQUENCE ts_stat_tu_us_dly_id_sq OWNED BY ts_st_tu_us_dly.ts_id;
ALTER TABLE ts_st_tu_us_dly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_dly_id_sq');

CREATE SEQUENCE ts_stat_tu_us_itvl_id_sq;
ALTER SEQUENCE ts_stat_tu_us_itvl_id_sq OWNED BY ts_st_tu_us_int.ts_id;
ALTER TABLE ts_st_tu_us_int ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_itvl_id_sq');

CREATE SEQUENCE ts_stat_tu_us_mtly_id_sq; 
ALTER SEQUENCE ts_stat_tu_us_mtly_id_sq OWNED BY ts_st_tu_us_mly.ts_id;
ALTER TABLE ts_st_tu_us_mly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_mtly_id_sq');

CREATE SEQUENCE ts_stat_tu_us_wkly_id_sq; 
ALTER SEQUENCE ts_stat_tu_us_wkly_id_sq OWNED BY ts_st_tu_us_wly.ts_id;
ALTER TABLE ts_st_tu_us_wly ALTER COLUMN ts_id SET DEFAULT nextval('ts_stat_tu_us_wkly_id_sq');

create sequence ts_tcp_sess_data_id_sq;
ALTER SEQUENCE ts_tcp_sess_data_id_sq OWNED BY ts_tcp_session_data.id;
ALTER TABLE ts_tcp_session_data ALTER COLUMN id SET DEFAULT nextval('ts_tcp_sess_data_id_sq');

CREATE SEQUENCE ts_tran_def_groups_ts_id_sq;
ALTER SEQUENCE ts_tran_def_groups_ts_id_sq OWNED BY ts_tran_def_groups.ts_id;
ALTER TABLE ts_tran_def_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_tran_def_groups_ts_id_sq');
ALTER SEQUENCE ts_tran_def_groups_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_trancomps_ts_id_sq;
ALTER SEQUENCE ts_trancomps_ts_id_sq OWNED BY ts_trancomps.ts_id;
ALTER TABLE ts_trancomps ALTER COLUMN ts_id SET DEFAULT nextval('ts_trancomps_ts_id_sq');
ALTER SEQUENCE ts_trancomps_ts_id_sq RESTART WITH 700000000000000000;
 
CREATE SEQUENCE ts_tran_comp_details_ts_id_sq;
ALTER SEQUENCE ts_tran_comp_details_ts_id_sq OWNED BY ts_tran_comp_details.ts_id;
ALTER TABLE ts_tran_comp_details ALTER COLUMN ts_id SET DEFAULT nextval('ts_tran_comp_details_ts_id_sq'); 

CREATE SEQUENCE ts_transet_groups_ts_id_sq;
ALTER SEQUENCE ts_transet_groups_ts_id_sq OWNED BY ts_transet_groups.ts_id;
ALTER TABLE ts_transet_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_transet_groups_ts_id_sq');
ALTER SEQUENCE ts_transet_groups_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_transets_ts_id_sq;
ALTER SEQUENCE ts_transets_ts_id_sq OWNED BY ts_transets.ts_id;
ALTER TABLE ts_transets ALTER COLUMN ts_id SET DEFAULT nextval('ts_transets_ts_id_sq');
ALTER SEQUENCE ts_transets_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_transets_incarnation_id_sq;
ALTER SEQUENCE ts_transets_incarnation_id_sq OWNED BY ts_transets.ts_incarnation_id;
ALTER TABLE ts_transets ALTER COLUMN ts_incarnation_id SET DEFAULT nextval('ts_transets_incarnation_id_sq');

CREATE SEQUENCE ts_tranunits_ts_id_sq; 
ALTER SEQUENCE ts_tranunits_ts_id_sq OWNED BY ts_tranunits.ts_id;
ALTER TABLE ts_tranunits ALTER COLUMN ts_id SET DEFAULT nextval('ts_tranunits_ts_id_sq');
ALTER SEQUENCE ts_tranunits_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_user_def_groups_ts_id_sq; 
ALTER SEQUENCE ts_user_def_groups_ts_id_sq OWNED BY ts_user_def_groups.ts_id;
ALTER TABLE ts_user_def_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_user_def_groups_ts_id_sq');
ALTER SEQUENCE ts_user_def_groups_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_user_groups_ts_id_sq; 
ALTER SEQUENCE ts_user_groups_ts_id_sq OWNED BY ts_user_groups.ts_id;
ALTER TABLE ts_user_groups ALTER COLUMN ts_id SET DEFAULT nextval('ts_user_groups_ts_id_sq');
ALTER SEQUENCE ts_user_groups_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_users_ts_id_sq; 
ALTER SEQUENCE ts_users_ts_id_sq OWNED BY ts_users.ts_id;
ALTER TABLE ts_users ALTER COLUMN ts_id SET DEFAULT nextval('ts_users_ts_id_sq');
ALTER SEQUENCE ts_users_ts_id_sq RESTART WITH 700000000000000000;

CREATE SEQUENCE ts_users_ts_incarnation_id_sq;
ALTER SEQUENCE ts_users_ts_incarnation_id_sq OWNED BY ts_users.ts_incarnation_id;
ALTER TABLE ts_users ALTER COLUMN ts_incarnation_id SET DEFAULT nextval('ts_users_ts_incarnation_id_sq');

CREATE SEQUENCE ts_web_servers_ts_id_sq; 
ALTER SEQUENCE ts_web_servers_ts_id_sq OWNED BY ts_web_servers.ts_id;
ALTER TABLE ts_web_servers ALTER COLUMN ts_id SET DEFAULT nextval('ts_web_servers_ts_id_sq');

CREATE SEQUENCE tang_events_ts_id_sq; 
ALTER SEQUENCE tang_events_ts_id_sq OWNED BY tang_events.ts_id;
ALTER TABLE tang_events ALTER COLUMN ts_id SET DEFAULT nextval('tang_events_ts_id_sq');
