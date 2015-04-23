-- This file updates the sequences used for the 
-- Primary Key generation of the tables

SELECT setval('ts_autogen_tmplt_ts_id_sq', (select max(ts_id) from ts_autogen_template));

-- Reset the sequence ts_apps_ts_id_sq
SELECT setval('ts_apps_ts_id_sq', 
				(SELECT   
			      CASE 
			         WHEN max(ts_id) <  700000000000000000 THEN 700000000000000000-1
			         ELSE max(ts_id)
			      END
				 FROM ts_apps)
			 );

SELECT setval('ts_attributes_ts_id_sq', (select max(ts_id) from ts_attributes));

SELECT setval('ts_audit_rcrd_props_ts_id_sq', (select max(ts_id) from ts_audit_record_props));

SELECT setval('ts_audit_records_ts_id_sq', (select max(ts_id) from ts_audit_records));

SELECT setval('ts_autogen_tmplt_ts_id_sq', (select max(ts_id) from ts_plugin));

SELECT setval('ts_biz_events_ts_id_sq', (select max(ts_id) from ts_biz_events));

SELECT setval('ts_cached_reports_ts_id_sq', (select max(ts_id) from ts_cached_reports));

SELECT setval('ts_concur_sessions_ts_id_sq', (select max(ts_id) from ts_concurrent_sessions));

SELECT setval('ts_defect_defs_ts_id_sq', (select max(ts_id) from ts_defect_defs));

-- Reset the sequence ts_defect_meta_keys_ts_id_sq
SELECT setval('ts_defect_meta_keys_ts_id_sq', 
				(SELECT   
			      CASE 
			         WHEN max(ts_id) <  600000000000000000 THEN 600000000000000000-1
			         ELSE max(ts_id)
			      END
				 FROM ts_defect_meta_keys)
			 );

SELECT setval('ts_dfct_meta_values_ts_id_sq', (select max(ts_id) from ts_defect_meta_values));

SELECT setval('ts_defects_itvl_ts_id_sq', (select max(ts_id) from ts_defects_interval));

SELECT setval('ts_entity_ts_id_sq', (select max(ts_id) from ts_entity));

SELECT setval('ts_entity_service_ts_id_sq', (select max(ts_id) from ts_entity_service));

SELECT setval('ts_hourly_aggr_log_ts_id_sq', (select max(ts_id) from ts_hourly_aggregation_log));

SELECT setval('ts_introscope_cfgs_ts_id_sq', (select max(ts_id) from ts_introscope_configs));
 
SELECT setval('ts_introscope_ems_ts_id_sq', (select max(ts_id) from ts_introscope_ems));

SELECT setval('ts_monitors_ts_id_sq', (select max(ts_id) from ts_monitors));

SELECT setval('ts_operators_ts_id_sq', (select max(ts_id) from ts_autogen_template));

SELECT setval('ts_plugin_filter_ts_id_sq', (select max(ts_id) from ts_plugin_filter));

SELECT setval('ts_plugin_url_filter_ts_id_sq', (select max(ts_id) from ts_plugin_url_filter));

SELECT setval('ts_private_params_ts_id_sq', (select max(ts_id) from ts_private_parameters));

SELECT setval('ts_record_components_ts_id_sq', (select max(ts_id) from ts_recording_components));

SELECT setval('ts_record_sessions_ts_id_sq', (select max(ts_id) from ts_recording_sessions));

SELECT setval('ts_rprt_def_parm_val_ts_id_sq', (select max(ts_id) from ts_report_def_param_values));

SELECT setval('ts_report_defs_ts_id_sq', (select max(ts_id) from ts_report_defs));

SELECT setval('ts_report_param_keys_ts_id_sq', (select max(ts_id) from ts_report_param_keys));

SELECT setval('ts_rprt_type_prm_val_ts_id_sq', (select max(ts_id) from ts_report_type_param_values));

SELECT setval('ts_report_types_ts_id_sq', (select max(ts_id) from ts_report_types));

SELECT setval('ts_session_usage_dly_ts_id_sq', (select max(ts_id) from ts_session_usage_daily));

SELECT setval('ts_ses_usage_itvl_ts_id_sq', (select max(ts_id) from ts_session_usage_interval));

SELECT setval('ts_ses_usage_mtly_ts_id_sq', (select max(ts_id) from ts_session_usage_monthly));

SELECT setval('ts_ses_usage_wkly_ts_id_sq', (select max(ts_id) from ts_session_usage_weekly));

SELECT setval('ts_settings_ts_id_sq', (select max(ts_id) from ts_settings));

SELECT setval('ts_sm_groups_ts_id_sq', (select max(ts_id) from ts_sm_groups));

SELECT setval('ts_sm_policy_servers_ts_id_sq', (select max(ts_id) from ts_sm_policy_servers));

SELECT setval('ts_sm_web_servers_ts_id_sq', (select max(ts_id) from ts_sm_web_servers));

SELECT setval('ts_stat_t_us_itvl_id_sq', (select max(ts_id) from ts_st_t_us_int));

SELECT setval('ts_stat_ts_all_dly_id_sq', (select max(ts_id) from ts_st_ts_all_dly));

SELECT setval('ts_stat_ts_all_itvl_id_sq', (select max(ts_id) from ts_st_ts_all_int));
               
SELECT setval('ts_stat_ts_all_mtly_id_sq', (select max(ts_id) from ts_st_ts_all_mly));

SELECT setval('ts_stat_ts_all_wkly_id_sq', (select max(ts_id) from ts_st_ts_all_wly));

SELECT setval('ts_stat_ts_usgrp_dly_id_sq', (select max(ts_id) from ts_st_ts_usgrp_dly));

SELECT setval('ts_stat_ts_usgrp_itvl_id_sq', (select max(ts_id) from ts_st_ts_usgrp_int));

SELECT setval('ts_stat_ts_usgrp_mtly_id_sq', (select max(ts_id) from ts_st_ts_usgrp_mly));

SELECT setval('ts_stat_ts_usgrp_wkly_id_sq', (select max(ts_id) from ts_st_ts_usgrp_wly));

SELECT setval('ts_stat_ts_us_dly_id_sq', (select max(ts_id) from ts_st_ts_us_dly));

SELECT setval('ts_stat_ts_us_itvl_id_sq', (select max(ts_id) from ts_st_ts_us_int));

SELECT setval('ts_stat_ts_us_mtly_id_sq', (select max(ts_id) from ts_st_ts_us_mly));

SELECT setval('ts_stat_ts_us_wkly_id_sq', (select max(ts_id) from ts_st_ts_us_wly));

SELECT setval('ts_stat_tsgrp_all_dly_id_sq', (select max(ts_id) from ts_st_tsgrp_all_dly));

SELECT setval('ts_stat_tsgrp_all_itvl_id_sq', (select max(ts_id) from ts_st_tsgrp_all_int));

SELECT setval('ts_stat_tsgrp_all_mtly_id_sq', (select max(ts_id) from ts_st_tsgrp_all_mly));

SELECT setval('ts_stat_tsgrp_all_wkly_id_sq', (select max(ts_id) from ts_st_tsgrp_all_wly));

SELECT setval('ts_stat_tsgrp_usgrp_dly_id_sq', (select max(ts_id) from ts_st_tsgrp_usgrp_dly));

SELECT setval('ts_stat_tsgrp_usgrp_itvl_id_sq', (select max(ts_id) from ts_st_tsgrp_usgrp_int));

SELECT setval('ts_stat_tsgrp_usgrp_mtly_id_sq', (select max(ts_id) from ts_st_tsgrp_usgrp_mly));

SELECT setval('ts_stat_tsgrp_usgrp_wkly_id_sq', (select max(ts_id) from ts_st_tsgrp_usgrp_wly));

SELECT setval('ts_stat_tsgrp_us_dly_id_sq', (select max(ts_id) from ts_st_tsgrp_us_dly));

SELECT setval('ts_stat_tsgrp_us_itvl_id_sq', (select max(ts_id) from ts_st_tsgrp_us_int));

SELECT setval('ts_stat_tsgrp_us_mtly_id_sq', (select max(ts_id) from ts_st_tsgrp_us_mly));

SELECT setval('ts_stat_tsgrp_us_wkly_id_sq', (select max(ts_id) from ts_st_tsgrp_us_wly));

SELECT setval('ts_stat_tu_all_dly_id_sq', (select max(ts_id) from ts_st_tu_all_dly));

SELECT setval('ts_stat_tu_all_itvl_id_sq', (select max(ts_id) from ts_st_tu_all_int));

SELECT setval('ts_stat_tu_all_mtly_id_sq', (select max(ts_id) from ts_st_tu_all_mly));

SELECT setval('ts_stat_tu_all_wkly_id_sq', (select max(ts_id) from ts_st_tu_all_wly));

SELECT setval('ts_stat_tu_usgrp_dly_id_sq', (select max(ts_id) from ts_st_tu_usgrp_dly));

SELECT setval('ts_stat_tu_usgrp_itvl_id_sq', (select max(ts_id) from ts_st_tu_usgrp_int));

SELECT setval('ts_stat_tu_usgrp_mtly_id_sq', (select max(ts_id) from ts_st_tu_usgrp_mly));

SELECT setval('ts_stat_tu_usgrp_wkly_id_sq', (select max(ts_id) from ts_st_tu_usgrp_wly));

SELECT setval('ts_stat_tu_us_dly_id_sq', (select max(ts_id) from ts_st_tu_us_dly));

SELECT setval('ts_stat_tu_us_itvl_id_sq', (select max(ts_id) from ts_st_tu_us_int));

SELECT setval('ts_stat_tu_us_mtly_id_sq', (select max(ts_id) from ts_st_tu_us_mly));

SELECT setval('ts_stat_tu_us_wkly_id_sq', (select max(ts_id) from ts_st_tu_us_wly));

SELECT setval('ts_tran_def_groups_ts_id_sq', (select max(ts_id) from ts_tran_def_groups));

SELECT setval('ts_trancomps_ts_id_sq', (select max(ts_id) from ts_trancomps));

SELECT setval('ts_tran_comp_details_ts_id_sq', (select max(ts_id) from ts_tran_comp_details));

SELECT setval('ts_transet_groups_ts_id_sq', (select max(ts_id) from ts_transet_groups));

SELECT setval('ts_transets_ts_id_sq', (select max(ts_id) from ts_transets));
SELECT setval('ts_transets_incarnation_id_sq', (select max(ts_incarnation_id) from ts_transets));

SELECT setval('ts_tranunits_ts_id_sq', (select max(ts_id) from ts_tranunits));

SELECT setval('ts_user_def_groups_ts_id_sq', (select max(ts_id) from ts_user_def_groups));

SELECT setval('ts_user_groups_ts_id_sq', (select max(ts_id) from ts_user_groups));

SELECT setval('ts_users_ts_id_sq', (select max(ts_id) from ts_users));
SELECT setval('ts_users_ts_incarnation_id_sq', (select max(ts_incarnation_id) from ts_users));

SELECT setval('ts_web_servers_ts_id_sq', (select max(ts_id) from ts_web_servers));

SELECT setval('tang_events_ts_id_sq', (select max(ts_id) from tang_events));
