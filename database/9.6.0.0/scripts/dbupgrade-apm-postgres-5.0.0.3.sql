--adding 4.5 SPC schema changes

   ALTER TABLE ts_login_id_parameters add column ts_group int2 not null DEFAULT 0;
   ALTER TABLE ts_session_id_parameters add column ts_group int2 not null DEFAULT 0;

   ALTER TABLE ts_login_id_parameters DROP CONSTRAINT ts_login_id_parameters_pkey;
   ALTER TABLE ts_login_id_parameters ADD CONSTRAINT ts_login_id_parameters_pkey PRIMARY KEY(ts_app_id, ts_type, ts_name, ts_group);
   
   ALTER TABLE ts_session_id_parameters DROP CONSTRAINT ts_session_id_parameters_pkey;
   ALTER TABLE ts_session_id_parameters ADD CONSTRAINT ts_session_id_parameters_pkey PRIMARY KEY(ts_app_id, ts_type, ts_name, ts_id_type, ts_group);

  -- updating the master data changes ( 4.5 SPC changes)


   UPDATE ts_impact_settings SET ts_fromname='Wily CEM Administrator', ts_fromaddress= 'support@myCompany.com',  ts_subject='Wily CEM Incident EMail - Moderate Severity Notification', ts_message='This email has been sent to you by Wily CEM Incident Engine because an incident is moderate severity.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n' where ts_id=1;
   UPDATE ts_impact_settings SET ts_fromname='Wily CEM Administrator', ts_fromaddress= 'support@myCompany.com',  ts_subject='Wily CEM Incident EMail - Severe Severity Notification', ts_message='This email has been sent to you by Wily CEM Incident Engine because an incident is severe severity.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n' where ts_id=2;
   UPDATE ts_impact_settings SET ts_fromname='Wily CEM Administrator', ts_fromaddress= 'support@myCompany.com',  ts_subject='Wily CEM Incident EMail - Critical Severity Notification', ts_message='This email has been sent to you by Wily CEM Incident Engine because an incident is critical severity.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n' where ts_id=3;

   UPDATE ts_settings SET ts_default='support@myCompany.com'  WHERE ts_id=1027;
   UPDATE ts_settings SET ts_value='Wily CEM Administrator' ,ts_description='From: Name to be used to email incident status' ,ts_default='Wily CEM Administrator'  WHERE ts_id=1028;
   UPDATE ts_settings SET ts_value='Wily CEM Incident EMail - Open Notification' ,ts_default='Wily CEM Incident EMail - Open Notification'  WHERE ts_id=1029;
   UPDATE ts_settings SET ts_value='This email has been sent to you by Wily CEM Incident Engine because an incident has been opened.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n' ,ts_default='This email has been sent to you by Wily CEM Incident Engine because an incident has been opened.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n'  WHERE ts_id=1030;
   UPDATE ts_settings SET ts_description='Comma seperated list of recipients'  WHERE ts_id=1031;


--renaming the tables

ALTER TABLE ts_stats_tran_user_interval	 RENAME TO ts_stats_t_us_interval;
ALTER TABLE ts_stats_transet_all_daily	RENAME TO ts_stats_ts_all_daily;
ALTER TABLE ts_stats_transet_all_interval RENAME TO ts_stats_ts_all_interval;
ALTER TABLE ts_stats_transet_all_monthly  RENAME TO ts_stats_ts_all_monthly;
ALTER TABLE ts_stats_transet_all_weekly	 RENAME TO ts_stats_ts_all_weekly;
ALTER TABLE ts_stats_transet_usergroup_daily RENAME TO 	ts_stats_ts_usgrp_daily;
ALTER TABLE ts_stats_transet_usergroup_interval	RENAME TO ts_stats_ts_usgrp_interval;
ALTER TABLE ts_stats_transet_usergroup_monthly	RENAME TO ts_stats_ts_usgrp_monthly;
ALTER TABLE ts_stats_transet_usergroup_weekly RENAME TO ts_stats_ts_usgrp_weekly;
ALTER TABLE ts_stats_transet_user_daily RENAME TO ts_stats_ts_us_daily;
ALTER TABLE ts_stats_transet_user_interval RENAME TO ts_stats_ts_us_interval;
ALTER TABLE ts_stats_transet_user_monthly RENAME TO ts_stats_ts_us_monthly;
ALTER TABLE ts_stats_transet_user_weekly RENAME TO ts_stats_ts_us_weekly;
ALTER TABLE ts_stats_transetgroup_all_daily RENAME TO 	ts_stats_tsgrp_all_daily;
ALTER TABLE ts_stats_transetgroup_all_interval RENAME TO ts_stats_tsgrp_all_interval;
ALTER TABLE ts_stats_transetgroup_all_monthly RENAME TO ts_stats_tsgrp_all_monthly;
ALTER TABLE ts_stats_transetgroup_all_weekly  RENAME TO ts_stats_tsgrp_all_weekly;
ALTER TABLE ts_stats_transetgroup_usergroup_daily RENAME TO ts_stats_tsgrp_usgrp_daily;
ALTER TABLE ts_stats_transetgroup_usergroup_interval RENAME TO ts_stats_tsgrp_usgrp_interval;
ALTER TABLE ts_stats_transetgroup_usergroup_monthly RENAME TO ts_stats_tsgrp_usgrp_monthly;
ALTER TABLE ts_stats_transetgroup_usergroup_weekly RENAME TO ts_stats_tsgrp_usgrp_weekly;
ALTER TABLE ts_stats_transetgroup_user_daily RENAME TO ts_stats_tsgrp_us_daily;
ALTER TABLE ts_stats_transetgroup_user_interval RENAME TO ts_stats_tsgrp_us_interval;
ALTER TABLE ts_stats_transetgroup_user_monthly RENAME TO ts_stats_tsgrp_us_monthly;
ALTER TABLE ts_stats_transetgroup_user_weekly RENAME TO ts_stats_tsgrp_us_weekly;
ALTER TABLE ts_stats_tranunit_all_daily RENAME TO ts_stats_tu_all_daily;
ALTER TABLE ts_stats_tranunit_all_interval RENAME TO ts_stats_tu_all_interval;
ALTER TABLE ts_stats_tranunit_all_monthly RENAME TO ts_stats_tu_all_monthly;
ALTER TABLE ts_stats_tranunit_all_weekly RENAME TO ts_stats_tu_all_weekly;
ALTER TABLE ts_stats_tranunit_usergroup_daily RENAME TO ts_stats_tu_usgrp_daily;
ALTER TABLE ts_stats_tranunit_usergroup_interval RENAME TO ts_stats_tu_usgrp_interval;
ALTER TABLE ts_stats_tranunit_usergroup_monthly RENAME TO ts_stats_tu_usgrp_monthly;
ALTER TABLE ts_stats_tranunit_usergroup_weekly RENAME TO ts_stats_tu_usgrp_weekly;
ALTER TABLE ts_stats_tranunit_user_daily RENAME TO ts_stats_tu_us_daily;
ALTER TABLE ts_stats_tranunit_user_interval RENAME TO ts_stats_tu_us_interval;
ALTER TABLE ts_stats_tranunit_user_monthly RENAME TO ts_stats_tu_us_monthly;
ALTER TABLE ts_stats_tranunit_user_weekly RENAME TO ts_stats_tu_us_weekly;
ALTER TABLE ts_interim_session_id_parameters RENAME TO ts_interim_session_id_params;


--renaming the columns

ALTER TABLE ts_domains RENAME COLUMN ts_infrastructure_event_ageout TO ts_infrastruct_event_ageout;
ALTER TABLE ts_domains RENAME COLUMN ts_infrastructure_defect_delete TO ts_infrastruct_defect_delete;
ALTER TABLE ts_domains RENAME COLUMN ts_usergroup_interval_stats_discard_time TO ts_usgrp_intrvl_st_dscrd_time;
ALTER TABLE ts_domains RENAME COLUMN ts_usergroup_daily_stats_discard_time TO ts_usgrp_dly_st_dscrd_time;
ALTER TABLE ts_domains RENAME COLUMN ts_usergroup_weekly_stats_discard_time TO ts_usgrp_wkly_st_dscrd_time;
ALTER TABLE ts_domains RENAME COLUMN ts_ignore_apps_in_user_recognition	TO ts_ignore_apps_in_user_recogn;
ALTER TABLE ts_domains RENAME COLUMN ts_filter_defects_subnets_enabled TO ts_filter_defects_subnets_on;
ALTER TABLE ts_domains RENAME COLUMN ts_new_ip_user_groups_enabled TO ts_new_ip_us_grps_enabled;
ALTER TABLE ts_domains RENAME COLUMN ts_stats_interval_duration_mins TO ts_stats_intrvl_duration_mins;
ALTER TABLE ts_domains RENAME COLUMN ts_capture_comprehensive_defect_details TO ts_capture_full_defect_details;
ALTER TABLE ts_introscope_ems RENAME COLUMN ts_tran_trace_threshold_percentage TO ts_tran_trace_threshold_percnt;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_url_host      TO   ts_case_senstv_url_host;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_url_path      TO   ts_case_senstv_url_path;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_query_name    TO   ts_case_senstv_query_name;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_query_value   TO   ts_case_senstv_query_value;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_cookie_name   TO   ts_case_senstv_cookie_name;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_cookie_value  TO   ts_case_senstv_cookie_value;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_post_name     TO   ts_case_senstv_post_name;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_post_value    TO   ts_case_senstv_post_value;
ALTER TABLE ts_apps RENAME COLUMN ts_case_sensitivity_login_name    TO   ts_case_senstv_login_name;

--Dropping constraints 
--(changing postgres schema to make it synchronized with oracle schema. Reason to change it for oracle -see TT issue 62079)

ALTER TABLE ts_user_sessions_map DROP CONSTRAINT ts_user_sessions_map_pkey;
ALTER TABLE ts_user_sessions_map ADD CONSTRAINT ts_user_sessions_map_ukey UNIQUE(ts_app_id, ts_session_id, ts_interim_session_id);
ALTER TABLE ts_user_sessions_map ALTER COLUMN ts_interim_session_id DROP NOT NULL;
ALTER TABLE ts_audit_record_props ALTER COLUMN 	ts_old_value DROP NOT NULL;
ALTER TABLE ts_audit_record_props ALTER COLUMN 	ts_new_value DROP NOT NULL;
ALTER TABLE ts_introscope_ems ALTER COLUMN 	ts_web_view_version DROP NOT NULL;
ALTER TABLE ts_operators ALTER COLUMN ts_password DROP NOT NULL;
ALTER TABLE ts_plugin_url_filter ALTER COLUMN ts_url_filter DROP NOT NULL;
ALTER TABLE ts_params ALTER COLUMN ts_original_value DROP NOT NULL;
ALTER TABLE ts_settings ALTER COLUMN ts_value DROP NOT NULL;
ALTER TABLE ts_trancomps ALTER COLUMN ts_url DROP NOT NULL;
ALTER TABLE ts_users ALTER COLUMN ts_first_name DROP NOT NULL;
ALTER TABLE ts_users ALTER COLUMN ts_last_name DROP NOT NULL;
ALTER TABLE ts_web_servers ALTER COLUMN ts_mac_address DROP NOT NULL;
ALTER TABLE tang_config ALTER COLUMN ts_value DROP NOT NULL;

--renaming the indexes

ALTER INDEX	  ts_audit_record_props_AuditIndex  	RENAME TO	 ts_audit_record_props_AuditIdx ;
ALTER INDEX	  ts_audit_records_KeyIndex  	RENAME TO	  ts_audit_records_KeyIdx ;
ALTER INDEX	  ts_audit_records_OperatorIndex  	RENAME TO	  ts_audit_records_OperatorIdx ;
ALTER INDEX	  ts_biz_events_DefectIndex  	RENAME TO	  ts_biz_events_DefectIdx;
ALTER INDEX	  ts_biz_events_StatusIndex  	RENAME TO	  ts_biz_events_StatusIdx;
ALTER INDEX	  ts_biz_events_TransetIncarnationIdIndex  	RENAME TO	  ts_biz_events_TSIncrnIdIdx;
ALTER INDEX	  ts_biz_events_TransetIdIndex  	RENAME TO	  ts_biz_events_TSIdIdx;
ALTER INDEX	  ts_cached_reports_EndTimeIndex  	RENAME TO	  ts_cached_reports_EndTimeIdx;
ALTER INDEX	  ts_cached_reports_LastAccessTimeIndex  	RENAME TO	  ts_cached_rprts_LstAcsTimeIdx;
ALTER INDEX	  ts_cached_reports_ReportPathIndex  	RENAME TO	  ts_cached_reports_RprtPathIdx;
ALTER INDEX	  ts_cached_reports_StartTimeIndex  	RENAME TO	  ts_cached_reports_StTimeIdx;
ALTER INDEX	  ts_defect_defs_TranunitIndex  	RENAME TO	  ts_defect_defs_TranunitIdx;
ALTER INDEX	  ts_defect_defs_TransetIndex  	RENAME TO	  ts_defect_defs_TSIdx;
ALTER INDEX	  ts_defects_interval_DateIndex  	RENAME TO	  ts_defects_interval_DateIdx;
ALTER INDEX	  ts_defects_interval_DefectIndex  	RENAME TO	  ts_defects_interval_DefectIdx;
ALTER INDEX	  ts_defects_interval_EventIndex  	RENAME TO	  ts_defects_interval_EventIdx;
ALTER INDEX	  ts_defects_interval_TranSetIndex  	RENAME TO	  ts_defects_interval_TSIdx;
ALTER INDEX	  ts_defects_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_defects_itvl_TSIncrnIdIdx;
ALTER INDEX	  ts_defects_interval_UserIndex  	RENAME TO	  ts_defects_itvl_UserIdx;
ALTER INDEX	  ts_defects_interval_UserIncarnationIdIndex  	RENAME TO	  ts_defects_itvl_UserIncIdIdx;
ALTER INDEX	  ts_login_id_parameters_AppIdIndex  	RENAME TO	  ts_login_id_parms_AppIdIdx;
ALTER INDEX	  ts_operator_role_map_OperatorIdIndex  	RENAME TO	  ts_oper_role_map_OperIdIdx;
ALTER INDEX	  ts_operator_role_map_RoleIdIndex  	RENAME TO	  ts_operator_role_map_RoleIdIdx;
ALTER INDEX	  ts_params_TranCompIdIndex  	RENAME TO	  ts_params_TranCompIdIdx;
ALTER INDEX	  ts_recording_components_RecordingIdIndex  	RENAME TO	  ts_record_components_RecordIdx;
ALTER INDEX	  ts_recording_components_SequenceNumberIndex  	RENAME TO	  ts_recording_comp_SeqNumberIdx;
ALTER INDEX	  ts_report_def_param_value_ParamKeyIndex  	RENAME TO	  ts_rprt_def_prm_val_PrmKeyIdx;
ALTER INDEX	  ts_report_def_param_value_ReportDefIndex  	RENAME TO	  ts_rprt_def_prm_val_RprtDefIdx;
ALTER INDEX	  ts_report_type_param_value_ParamKeyIndex  	RENAME TO	  ts_rprt_type_prm_val_PrmKeyIdx;
ALTER INDEX	  ts_report_type_param_value_ReportTypeIndex  	RENAME TO	  ts_rprttype_prmval_RprtTypeIdx;
ALTER INDEX	  ts_session_id_parameters_AppIdIndex  	RENAME TO	  ts_session_id_parms_AppIdIdx;
ALTER INDEX	  ts_settings_KeyIndex  	RENAME TO	  ts_settings_KeyIdx;
ALTER INDEX	  ts_sm_policy_servers_SmGroupIdIndex  	RENAME TO	  ts_sm_plcy_servers_SmGrpIdIdx;
ALTER INDEX	  ts_sm_web_servers_SmGroupIdIndex  	RENAME TO	  ts_sm_web_servers_SmGroupIdIdx;
ALTER INDEX	  ts_stats_transet_all_daily_DayIndex  	RENAME TO	  ts_st_ts_all_dly_DayIdx;
ALTER INDEX	  ts_stats_transet_all_daily_HourIndex  	RENAME TO	  ts_st_ts_all_dly_HourIdx;
ALTER INDEX	  ts_stats_transet_all_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_all_dly_LAggRow;
ALTER INDEX	  ts_stats_transet_all_daily_MonthIndex  	RENAME TO	  ts_st_ts_all_dly_MonthIdx;
ALTER INDEX	  ts_stats_transet_all_daily_StartTimeIndex  	RENAME TO	  ts_st_ts_all_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_all_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_dly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_all_daily_TranSetIndex  	RENAME TO	  ts_st_ts_all_dly_TSIdx;
ALTER INDEX	  ts_stats_transet_all_daily_WeekIndex  	RENAME TO	  ts_st_ts_all_dly_WeekIdx;
ALTER INDEX	  ts_stats_transet_all_daily_YearIndex  	RENAME TO	  ts_st_ts_all_dly_YearIdx;
ALTER INDEX	  ts_stats_transet_all_interval_DayIndex  	RENAME TO	  ts_st_ts_all_itvl_DayIdx;
ALTER INDEX	  ts_stats_transet_all_interval_HourIndex  	RENAME TO	  ts_st_ts_all_itvl_HourIdx;
ALTER INDEX	  ts_stats_transet_all_interval_LastAggregatedRowIndex	RENAME TO	  ts_st_ts_all_itvl_LastAggRwIdx;
ALTER INDEX	  ts_stats_transet_all_interval_MonthIndex  	RENAME TO	  ts_st_ts_all_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transet_all_interval_StartTimeIndex  	RENAME TO	  ts_st_ts_all_itvl_StTimeIdx;
ALTER INDEX	  ts_stats_transet_all_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_itvl_TSInIdIdx;
ALTER INDEX	  ts_stats_transet_all_interval_TranSetIndex  	RENAME TO	  ts_st_ts_all_itvl_TSIdx ;
ALTER INDEX	  ts_stats_transet_all_interval_WeekIndex  	RENAME TO	  ts_st_ts_all_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_transet_all_interval_YearIndex  	RENAME TO	  ts_st_ts_all_itvl_YearIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_DayIndex  	RENAME TO	  ts_st_ts_all_mtly_DayIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_HourIndex  	RENAME TO	  ts_st_ts_all_mtly_HourIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_all_mtly_LastAggRwIdx;
ALTER INDEX	  ts_stats_transet_all_monthly_MonthIndex  	RENAME TO	  ts_st_ts_all_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_StartTimeIndex  	RENAME TO	  ts_st_ts_all_mtly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_mtly_TSInIdIdx;
ALTER INDEX	  ts_stats_transet_all_monthly_TranSetIndex  	RENAME TO	  ts_st_ts_all_mtly_TSIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_WeekIndex  	RENAME TO	  ts_st_ts_all_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_all_monthly_YearIndex  	RENAME TO	  ts_st_ts_all_mtly_YearIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_DayIndex  	RENAME TO	  ts_st_ts_all_wkly_DayIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_HourIndex  	RENAME TO	  ts_st_ts_all_wkly_HourIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_all_wkly_LastAggRwIdx;
ALTER INDEX	  ts_stats_transet_all_weekly_MonthIndex  	RENAME TO	  ts_st_ts_all_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_StartTimeIndex  	RENAME TO	  ts_st_ts_all_wkly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_all_wkly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_transet_all_weekly_TranSetIndex  	RENAME TO	ts_st_ts_all_wkly_TSIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_WeekIndex  	RENAME TO	  ts_st_ts_all_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_all_weekly_YearIndex  	RENAME TO	  ts_st_ts_all_wkly_YearIdx ;
ALTER INDEX	  ts_stats_transetgroup_all_daily_DayIndex  	RENAME TO	  ts_st_tsgrp_all_dly_DayIdx ;
ALTER INDEX	  ts_stats_transetgroup_all_daily_HourIndex  	RENAME TO	  ts_st_tsgrp_all_dly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_dly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_dly_MonthIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_daily_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_dly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_all_daily_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_dly_WeekIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_daily_YearIndex  	RENAME TO	  ts_st_tsgrp_all_dly_YearIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_interval_DayIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_DayIdx 	;
ALTER INDEX	  ts_stats_transetgroup_all_interval_HourIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_LAgRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_all_interval_YearIndex  	RENAME TO	  ts_st_tsgrp_all_itvl_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_DayIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_HourIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_LAgRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_all_monthly_YearIndex  	RENAME TO	  ts_st_tsgrp_all_mtly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_DayIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_HourIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_LAgRowIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_MonthIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_WeekIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_all_weekly_YearIndex  	RENAME TO	  ts_st_tsgrp_all_wkly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_DayIndex  	RENAME TO	  ts_st_tsgrp_us_dly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_HourIndex  	RENAME TO	  ts_st_tsgrp_us_dly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_dly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_dly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_us_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_dly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_UserIncarnationIdIndex  	RENAME TO	  ts_st_tgrp_us_dly_UsrIncIdIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_UserIndex  	RENAME TO	  ts_st_tsgrp_us_dly_UserIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_dly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_user_daily_YearIndex  	RENAME TO	  ts_st_tsgrp_us_dly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_LAgRwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_STimeIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_TSGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_UsGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_WeekIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_daily_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_dly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_HrIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_LARwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_MnthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_StTmIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_TSGpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_UsGpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_WeekIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_interval_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_itvl_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_LARwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_MnthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_STmIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_TSGIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_UsGIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_WeekIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_WkIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_monthly_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_mtly_YrIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_DayIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_HourIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_LARwIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_MonthIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_MnthIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_STmIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_TSGIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_UserGroupIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_UGrpIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_WeekIndex  	RENAME TO	ts_st_tsgrp_usgrp_wkly_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_usergroup_weekly_YearIndex  	RENAME TO	  ts_st_tsgrp_usgrp_wkly_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_DayIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_HourIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_StartIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_StartIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_UserIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_UserIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_WeekIdx;
ALTER INDEX	  ts_stats_transetgroup_user_interval_YearIndex  	RENAME TO	  ts_st_tsgrp_us_itvl_YearIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_DayIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_DayIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_HourIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_HourIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_UserIncarnationIdIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_UsrInIdIdx;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_UserIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_UserIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_monthly_YearIndex  	RENAME TO	  ts_st_tsgrp_us_mtly_YearIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_DayIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_DayIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_HourIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_HourIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_LAggRowIdx;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_MonthIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_StartTimeIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_STimeIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_TranSetGroupIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_TSGroupIdx;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_UserIncarnationIdIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_UsrInIdIdx;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_UserIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_UserIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_WeekIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transetgroup_user_weekly_YearIndex  	RENAME TO	  ts_st_tsgrp_us_wkly_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_DayIndex  	RENAME TO	  ts_st_ts_us_dly_DayIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_HourIndex  	RENAME TO	  ts_st_ts_us_dly_HourIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_us_dly_LAggRow;
ALTER INDEX	  ts_stats_transet_user_daily_MonthIndex  	RENAME TO	  ts_st_ts_us_dly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_StartTimeIndex  	RENAME TO	  ts_st_ts_us_dly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_dly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_transet_user_daily_TranSetIndex  	RENAME TO	  ts_st_ts_us_dly_TSIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_dly_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_daily_UserIndex  	RENAME TO	  ts_st_ts_us_dly_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_WeekIndex  	RENAME TO	  ts_st_ts_us_dly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_daily_YearIndex  	RENAME TO	  ts_st_ts_us_dly_YearIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_DayIndex  	RENAME TO	  ts_st_ts_usgrp_dly_DayIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_HourIndex  	RENAME TO	  ts_st_ts_usgrp_dly_HourIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_dly_LAggRowIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_MonthIndex  	RENAME TO	  ts_st_ts_usgrp_dly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_daily_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_dly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_dly_TSIncrIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_dly_TSIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_UserGroupIndex  	RENAME TO	  ts_st_ts_usgrp_dly_UserGrpIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_dly_WeekIdx;
ALTER INDEX	  ts_stats_transet_usergroup_daily_YearIndex  	RENAME TO	  ts_st_ts_usgrp_dly_YearIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_DayIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_DayIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_GroupIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_GroupIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_HourIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_HourIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_LAggRowIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_MonthIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_MonthIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_STimeIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_interval_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_TSIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_interval_YearIndex  	RENAME TO	  ts_st_ts_usgrp_itvl_YearIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_DayIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_DayIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_HourIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_HourIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_LAggRowIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_MonthIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_MonthIdx 	;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_STimeIdx 	;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_TSIdx 	;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_UserGroupIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_UserGrpIdx;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_WeekIdx;
ALTER INDEX	  ts_stats_transet_usergroup_monthly_YearIndex  	RENAME TO	  ts_st_ts_usgrp_mtly_YearIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_DayIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_DayIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_HourIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_HourIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_LAggRow;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_MonthIndex  	RENAME TO	ts_st_ts_usgrp_wkly_MonthIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_StartTimeIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_TranSetIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_TSIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_UserGroupIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_UsGrpIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_WeekIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_usergroup_weekly_YearIndex  	RENAME TO	  ts_st_ts_usgrp_wkly_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_DayIndex  	RENAME TO	  ts_st_ts_us_itvl_DayIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_HourIndex  	RENAME TO	  ts_st_ts_us_itvl_HourIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_MonthIndex  	RENAME TO	  ts_st_ts_us_itvl_MonthIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_StartTime  	RENAME TO	  ts_st_ts_us_itvl_StTime ;
ALTER INDEX	  ts_stats_transet_user_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_itvl_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_interval_TranSetIndex  	RENAME TO	  ts_st_ts_us_itvl_TSIdx 	;
ALTER INDEX	  ts_stats_transet_user_interval_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_itvl_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_interval_UserIndex  	RENAME TO	  ts_st_ts_us_itvl_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_WeekIndex  	RENAME TO	  ts_st_ts_us_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_interval_YearIndex  	RENAME TO	  ts_st_ts_us_itvl_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_DayIndex  	RENAME TO	  ts_st_ts_us_mtly_DayIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_HourIndex  	RENAME TO	  ts_st_ts_us_mtly_HourIdx ;
ALTER INDEX	 ts_stats_transet_user_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_us_mtly_LAggRow;
ALTER INDEX	  ts_stats_transet_user_monthly_MonthIndex  	RENAME TO	  ts_st_ts_us_mtly_MonthIdx 	;
ALTER INDEX	  ts_stats_transet_user_monthly_StartTimeIndex  	RENAME TO	  ts_st_ts_us_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_transet_user_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_mtly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_monthly_TranSetIndex  	RENAME TO	  ts_st_ts_us_mtly_TSIdx 	;
ALTER INDEX	  ts_stats_transet_user_monthly_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_mtly_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_monthly_UserIndex  	RENAME TO	  ts_st_ts_us_mtly_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_WeekIndex  	RENAME TO	  ts_st_ts_us_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_monthly_YearIndex  	RENAME TO	  ts_st_ts_us_mtly_YearIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_DayIndex  	RENAME TO	  ts_st_ts_us_wkly_DayIdx;
ALTER INDEX	  ts_stats_transet_user_weekly_HourIndex  	RENAME TO	  ts_st_ts_us_wkly_HourIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_ts_us_wkly_LAggRow;
ALTER INDEX	  ts_stats_transet_user_weekly_MonthIndex  	RENAME TO	  ts_st_ts_us_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_StartTimeIndex  	RENAME TO	  ts_st_ts_us_wkly_StTimeIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_wkly_TSIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_weekly_TranSetIndex  	RENAME TO	  ts_st_ts_us_wkly_TSIdx 	;
ALTER INDEX	  ts_stats_transet_user_weekly_UserIncarnationIdIndex  	RENAME TO	  ts_st_ts_us_wkly_UserIncIdIdx;
ALTER INDEX	  ts_stats_transet_user_weekly_UserIndex  	RENAME TO	  ts_st_ts_us_wkly_UserIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_WeekIndex  	RENAME TO	  ts_st_ts_us_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_transet_user_weekly_YearIndex  	RENAME TO	  ts_st_ts_us_wkly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_DayIndex  	RENAME TO	  ts_st_tu_all_dly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_HourIndex  	RENAME TO	  ts_st_tu_all_dly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_dly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_daily_MonthIndex  	RENAME TO	  ts_st_tu_all_dly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_StartTimeIndex  	RENAME TO	  ts_st_tu_all_dly_StTimeIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_dly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_daily_TranSetIndex  	RENAME TO	  ts_st_tu_all_dly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_TranUnitIndex  	RENAME TO	  ts_st_tu_all_dly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_WeekIndex  	RENAME TO	  ts_st_tu_all_dly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_daily_YearIndex  	RENAME TO	  ts_st_tu_all_dly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_DayIndex  	RENAME TO	  ts_st_tu_all_itvl_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_HourIndex  	RENAME TO	  ts_st_tu_all_itvl_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_itvl_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_interval_MonthIndex  	RENAME TO	  ts_st_tu_all_itvl_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_StartTimeIndex  	RENAME TO	  ts_st_tu_all_itvl_StTimeIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_itvl_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_interval_TranSetIndex  	RENAME TO	  ts_st_tu_all_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_TranUnitIndex  	RENAME TO	  ts_st_tu_all_itvl_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_WeekIndex  	RENAME TO	  ts_st_tu_all_itvl_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_interval_YearIndex  	RENAME TO	  ts_st_tu_all_itvl_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_DayIndex  	RENAME TO	  ts_st_tu_all_mtly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_HourIndex  	RENAME TO	  ts_st_tu_all_mtly_HourIdx;
ALTER INDEX	  ts_stats_tranunit_all_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_mtly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_monthly_MonthIndex  	RENAME TO	  ts_st_tu_all_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_StartTimeIndex  	RENAME TO	  ts_st_tu_all_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_all_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_mtly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_monthly_TranSetIndex  	RENAME TO	  ts_st_tu_all_mtly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_TranUnitIndex  	RENAME TO	  ts_st_tu_all_mtly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_WeekIndex  	RENAME TO	  ts_st_tu_all_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_monthly_YearIndex  	RENAME TO	  ts_st_tu_all_mtly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_DayIndex  	RENAME TO	  ts_st_tu_all_wkly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_HourIndex  	RENAME TO	  ts_st_tu_all_wkly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_all_wkly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_all_weekly_MonthIndex  	RENAME TO	  ts_st_tu_all_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_StartTimeIndex  	RENAME TO	  ts_st_tu_all_wkly_StTimeIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_all_wkly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_all_weekly_TranSetIndex  	RENAME TO	  ts_st_tu_all_wkly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_TranUnitIndex  	RENAME TO	  ts_st_tu_all_wkly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_WeekIndex  	RENAME TO	  ts_st_tu_all_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_all_weekly_YearIndex  	RENAME TO	  ts_st_tu_all_wkly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_DayIndex  	RENAME TO	  ts_st_tu_us_dly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_HourIndex  	RENAME TO	  ts_st_tu_us_dly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_us_dly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_user_daily_MonthIndex  	RENAME TO	  ts_st_tu_us_dly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_StartTime  	RENAME TO	  ts_st_tu_us_dly_StTime ;
ALTER INDEX	  ts_stats_tranunit_user_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_dly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_daily_TranSetIndex  	RENAME TO	  ts_st_tu_us_dly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_TranUnitIndex  	RENAME TO	  ts_st_tu_us_dly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_dly_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_daily_UserIndex  	RENAME TO	  ts_st_tu_us_dly_UserIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_WeekIndex  	RENAME TO	  ts_st_tu_us_dly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_user_daily_YearIndex  	RENAME TO	  ts_st_tu_us_dly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_DayIndex  	RENAME TO	  ts_st_tu_usgrp_dly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_HourIndex  	RENAME TO	  ts_st_tu_usgrp_dly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_dly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_dly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_dly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_dly_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_TranSetIndex  	RENAME TO	  ts_st_tu_usgrp_dly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_dly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_dly_UsGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_dly_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_daily_YearIndex  	RENAME TO	  ts_st_tu_usgrp_dly_YearIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_DayIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_HourIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_LAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_MonthIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_TranSetIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_UsGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_interval_YearIndex  	RENAME TO	  ts_st_tu_usgrp_itvl_YearIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_DayIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_DayIdx;
ALTER INDEX	ts_stats_tranunit_usergroup_monthly_HourIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_HourIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_LastAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_MonthIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_TranSetIndex  	RENAME TO	ts_st_tu_usgrp_mtly_TSIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_TUIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_UserGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_WeekIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_monthly_YearIndex  	RENAME TO	  ts_st_tu_usgrp_mtly_YearIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_DayIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_DayIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_HourIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_HourIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_LAggRow;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_MonthIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_MonthIdx 	;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_StartTimeIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_StTimeIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_TSIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_TranSetIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_TSIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_TranUnitIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_TUIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_UserGroupIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_UserGrpIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_WeekIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_usergroup_weekly_YearIndex  	RENAME TO	  ts_st_tu_usgrp_wkly_YearIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_DayIndex  	RENAME TO	  ts_st_tu_us_itvl_DayIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_HourIndex  	RENAME TO	  ts_st_tu_us_itvl_HourIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_MonthIndex  	RENAME TO	  ts_st_tu_us_itvl_MonthIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_StartTime  	RENAME TO	  ts_st_tu_us_itvl_StTime;
ALTER INDEX	  ts_stats_tranunit_user_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_itvl_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_TranSetIndex  	RENAME TO	  ts_st_tu_us_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_user_interval_TranUnitIndex  	RENAME TO	  ts_st_tu_us_itvl_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_user_interval_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_itvl_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_UserIndex  	RENAME TO	  ts_st_tu_us_itvl_UserIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_WeekIndex  	RENAME TO	  ts_st_tu_us_itvl_WeekIdx;
ALTER INDEX	  ts_stats_tranunit_user_interval_YearIndex  	RENAME TO	  ts_st_tu_us_itvl_YearIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_DayIndex  	RENAME TO	  ts_st_tu_us_mtly_DayIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_HourIndex  	RENAME TO	  ts_st_tu_us_mtly_HourIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_us_mtly_LAggRow ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_MonthIndex  	RENAME TO	  ts_st_tu_us_mtly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_StartTime  	RENAME TO	  ts_st_tu_us_mtly_StTime ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_mtly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_TranSetIndex  	RENAME TO	  ts_st_tu_us_mtly_TSIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_TranUnitIndex  	RENAME TO	  ts_st_tu_us_mtly_TUIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_mtly_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_monthly_UserIndex  	RENAME TO	  ts_st_tu_us_mtly_UserIdx ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_WeekIndex  	RENAME TO	  ts_st_tu_us_mtly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_user_monthly_YearIndex  	RENAME TO	  ts_st_tu_us_mtly_YearIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_DayIndex  	RENAME TO	  ts_st_tu_us_wkly_DayIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_HourIndex  	RENAME TO	  ts_st_tu_us_wkly_HourIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_LastAggregatedRowIndex  	RENAME TO	  ts_st_tu_us_wkly_LastAggRow;
ALTER INDEX	  ts_stats_tranunit_user_weekly_MonthIndex  	RENAME TO	  ts_st_tu_us_wkly_MonthIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_StartTime  	RENAME TO	  ts_st_tu_us_wkly_StTime ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_wkly_TSIncrnIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_weekly_TranSetIndex  	RENAME TO	  ts_st_tu_us_wkly_TSIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_TranUnitIndex  	RENAME TO	  ts_st_tu_us_wkly_TUIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_UserIncarnationIdIndex  	RENAME TO	  ts_st_tu_us_wkly_UserIncIdIdx;
ALTER INDEX	  ts_stats_tranunit_user_weekly_UserIndex  	RENAME TO	  ts_st_tu_us_wkly_UserIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_WeekIndex  	RENAME TO	  ts_st_tu_us_wkly_WeekIdx ;
ALTER INDEX	  ts_stats_tranunit_user_weekly_YearIndex  	RENAME TO	  ts_st_tu_us_wkly_YearIdx ;
ALTER INDEX	  ts_stats_tran_user_interval_StartTimeIndex  	RENAME TO	  ts_st_t_us_itvl_StTimeIdx ;
ALTER INDEX	  ts_stats_tran_user_interval_TranSetIncarnationIdIndex  	RENAME TO	  ts_st_t_us_itvl_TSIncrnIdx;
ALTER INDEX	  ts_stats_tran_user_interval_TranSetIndex  	RENAME TO	  ts_st_t_us_itvl_TSIdx ;
ALTER INDEX	  ts_stats_tran_user_interval_TranUnitIndex  	RENAME TO	  ts_st_t_us_itvl_TUIdx ;
ALTER INDEX	  ts_trancomps_TranunitIndex  	RENAME TO	  ts_trancomps_TranunitIdx ;
ALTER INDEX	  ts_transetgroup_transets_map_TranSetGroupIdIndex  	RENAME TO	  ts_tsgrp_ts_map_TSGroupIdIdx;
ALTER INDEX	  ts_transetgroup_transets_map_TranSetIdIndex  	RENAME TO	  ts_tsgrp_ts_map_TSIdIdx ;
ALTER INDEX	  ts_transetgroup_transets_map_TranSetIncarnationIndex  	RENAME TO	  ts_tsgrp_ts_map_TSIncrnIdx;
ALTER INDEX	  ts_transets_AppIndex  	RENAME TO	  ts_transets_AppIdx ;
ALTER INDEX	  ts_transets_IncarnationIndex  	RENAME TO	  ts_transets_IncrnIdx;
ALTER INDEX	  ts_tranunits_TransetIndex  	RENAME TO	  ts_tranunits_TsIdx ;
ALTER INDEX	  ts_user_groups_DefGroupIndex  	RENAME TO	  ts_user_groups_DefGroupIdx ;
ALTER INDEX	  ts_user_groups_GroupByIndex  	RENAME TO	  ts_user_groups_GroupByIdx ;
ALTER INDEX	  ts_usergroup_transets_slas_TranSetIndex  	RENAME TO	  ts_usgrp_ts_slas_TSIdx ;
ALTER INDEX	  ts_usergroup_transets_slas_UserGroupIndex  	RENAME TO	  ts_usgrp_ts_slas_UsGrpIdx ;
ALTER INDEX	  ts_usergroup_users_map_UserGroupIndex  	RENAME TO	  ts_usgrp_users_map_UsGrpIdx ;
ALTER INDEX	  ts_usergroup_users_map_UserIncarnationIndex  	RENAME TO	  ts_usgrp_users_map_UsIncIdx ;
ALTER INDEX	  ts_usergroup_users_map_UserIndex  	RENAME TO	  ts_usgrp_users_map_UserIdx ;
ALTER INDEX	  ts_user_logins_map_AppIndex  	RENAME TO	  ts_user_logins_map_AppIdx ;
ALTER INDEX	  ts_user_logins_map_NameIndex  	RENAME TO	  ts_user_logins_map_NameIdx ;
ALTER INDEX	  ts_user_logins_map_UserIndex  	RENAME TO	  ts_user_logins_map_UserIdx ;
ALTER INDEX	  ts_user_sessions_map_AppIndex  	RENAME TO	  ts_us_ses_map_AppIdx ;
ALTER INDEX	  ts_user_sessions_map_InterimSessionIdIndex  	RENAME TO	  ts_us_ses_map_InterimSesIdIdx;
ALTER INDEX	  ts_user_sessions_map_SessionIdIndex  	RENAME TO	  ts_us_ses_map_SessionIdIdx;
ALTER INDEX	  ts_users_IncarnationIndex  	RENAME TO	  ts_users_IncrnIdx ;
ALTER INDEX	  ts_users_UserDefGroupIndex  	RENAME TO	  ts_users_UserDefGroupIdx ;
ALTER INDEX	  ts_web_servers_MonitorIndex  	RENAME TO	  ts_web_servers_MonitorIdx ;
ALTER INDEX	  ts_defects_userincarnationidindex  	RENAME TO	  ts_defects_UserIncIdIdx ;
ALTER INDEX	  ts_defects_eventindex  	RENAME TO	  ts_defects_eventIdx;
ALTER INDEX	  ts_biz_events_versioninfoindex  	RENAME TO	  ts_biz_events_versioninfoIdx;

--upgrading the sequences

ALTER SEQUENCE ts_app_auth_types_ts_id_seq RENAME TO  	ts_app_auth_types_ts_id_sq;  
ALTER SEQUENCE ts_app_types_ts_id_seq RENAME TO 	ts_app_types_ts_id_sq; 
ALTER SEQUENCE ts_apps_ts_id_seq RENAME TO 	ts_apps_ts_id_sq;
ALTER SEQUENCE ts_attributes_ts_id_seq RENAME TO 	ts_attributes_ts_id_sq; 
ALTER SEQUENCE ts_audit_record_props_ts_id_seq RENAME TO 	ts_audit_rcrd_props_ts_id_sq; 
ALTER SEQUENCE ts_audit_records_ts_id_seq RENAME TO 	ts_audit_records_ts_id_sq; 
ALTER SEQUENCE ts_autogen_template_ts_id_seq RENAME TO 	ts_autogen_tmplt_ts_id_sq; 
ALTER SEQUENCE ts_biz_events_ts_id_seq RENAME TO 	ts_biz_events_ts_id_sq; 
ALTER SEQUENCE ts_cached_reports_ts_id_seq RENAME TO 	ts_cached_reports_ts_id_sq; 
ALTER SEQUENCE ts_child_services_def_ts_id_seq RENAME TO 	ts_child_servc_def_ts_id_sq; 
ALTER SEQUENCE ts_concurrent_sessions_ts_id_seq RENAME TO 	ts_concur_sessions_ts_id_sq; 
ALTER SEQUENCE ts_defect_defs_ts_id_seq RENAME TO 	ts_defect_defs_ts_id_sq;
ALTER SEQUENCE ts_bizdef_filters_ts_id_seq RENAME TO 	ts_bizdef_filters_ts_id_sq; 
ALTER SEQUENCE ts_defect_importances_ts_id_seq RENAME TO 	ts_defect_importance_ts_id_sq;
ALTER SEQUENCE ts_defect_meta_keys_ts_id_seq RENAME TO  	ts_defect_meta_keys_ts_id_sq; 
ALTER SEQUENCE ts_defect_meta_values_ts_id_seq RENAME TO 	ts_dfct_meta_values_ts_id_sq; 
ALTER SEQUENCE ts_defects_ts_id_seq RENAME TO 	ts_defects_ts_id_sq; 
ALTER SEQUENCE ts_defects_interval_ts_id_seq RENAME TO 	ts_defects_itvl_ts_id_sq; 
ALTER SEQUENCE ts_domains_ts_id_seq RENAME TO 	ts_domains_ts_id_sq; 
ALTER SEQUENCE ts_entity_ts_id_seq RENAME TO 	ts_entity_ts_id_sq; 
ALTER SEQUENCE ts_entity_service_ts_id_seq RENAME TO 	ts_entity_service_ts_id_sq;
ALTER SEQUENCE ts_hourly_aggregation_log_ts_id_seq RENAME TO ts_hourly_aggr_log_ts_id_sq; 
ALTER SEQUENCE ts_impact_settings_ts_id_seq RENAME TO  	ts_impact_settings_ts_id_sq;  
ALTER SEQUENCE ts_introscope_configs_ts_id_seq RENAME TO  	ts_introscope_cfgs_ts_id_sq;   
ALTER SEQUENCE ts_introscope_ems_ts_id_seq RENAME TO 	ts_introscope_ems_ts_id_sq; 
ALTER SEQUENCE ts_license_compliance_ts_id_seq RENAME TO  	ts_license_compl_ts_id_sq;  
ALTER SEQUENCE ts_monitors_ts_id_seq RENAME TO  	ts_monitors_ts_id_sq;
ALTER SEQUENCE ts_monitor_child_service_ts_id_seq RENAME TO 	ts_montr_child_srvc_ts_id_sq; 
ALTER SEQUENCE ts_monitor_types_ts_id_seq RENAME TO  	ts_monitor_types_ts_id_sq;  
ALTER SEQUENCE ts_operators_ts_id_seq RENAME TO 	ts_operators_ts_id_sq; 
ALTER SEQUENCE ts_plugin_ts_id_seq RENAME TO 	ts_plugin_ts_id_sq; 
ALTER SEQUENCE ts_plugin_filter_ts_id_seq RENAME TO 	ts_plugin_filter_ts_id_sq; 
ALTER SEQUENCE ts_plugin_url_filter_ts_id_seq RENAME TO 	ts_plugin_url_filter_ts_id_sq;
ALTER SEQUENCE ts_private_parameters_ts_id_seq RENAME TO  	ts_private_params_ts_id_sq;  
ALTER SEQUENCE ts_protocols_ts_id_seq RENAME TO  	ts_protocols_ts_id_sq;  
ALTER SEQUENCE ts_recording_components_ts_id_seq RENAME TO  	ts_record_components_ts_id_sq;
ALTER SEQUENCE ts_recording_sessions_ts_id_seq RENAME TO 	ts_record_sessions_ts_id_sq;
ALTER SEQUENCE ts_report_def_param_values_ts_id_seq RENAME TO  	ts_rprt_def_parm_val_ts_id_sq; 
ALTER SEQUENCE ts_report_defs_ts_id_seq RENAME TO 	ts_report_defs_ts_id_sq; 
ALTER SEQUENCE ts_report_param_keys_ts_id_seq RENAME TO 	ts_report_param_keys_ts_id_sq; 
ALTER SEQUENCE ts_report_type_param_values_ts_id_seq RENAME TO 	ts_rprt_type_prm_val_ts_id_sq; 
ALTER SEQUENCE ts_report_types_ts_id_seq RENAME TO  	ts_report_types_ts_id_sq;  
ALTER SEQUENCE ts_roles_ts_id_seq RENAME TO 	ts_roles_ts_id_sq; 
ALTER SEQUENCE ts_services_def_ts_id_seq RENAME TO 	ts_services_def_ts_id_sq; 
ALTER SEQUENCE ts_session_usage_daily_ts_id_seq RENAME TO 	ts_session_usage_dly_ts_id_sq; 
ALTER SEQUENCE ts_session_usage_interval_ts_id_seq RENAME TO  	ts_ses_usage_itvl_ts_id_sq;  
ALTER SEQUENCE ts_session_usage_monthly_ts_id_seq RENAME TO 	ts_ses_usage_mtly_ts_id_sq; 
ALTER SEQUENCE ts_session_usage_weekly_ts_id_seq RENAME TO 	ts_ses_usage_wkly_ts_id_sq; 
ALTER SEQUENCE ts_settings_ts_id_seq RENAME TO 	ts_settings_ts_id_sq; 
ALTER SEQUENCE ts_sm_groups_ts_id_seq RENAME TO 	ts_sm_groups_ts_id_sq; 
ALTER SEQUENCE ts_sm_policy_servers_ts_id_seq RENAME TO 	ts_sm_policy_servers_ts_id_sq; 
ALTER SEQUENCE ts_sm_web_servers_ts_id_seq RENAME TO  	ts_sm_web_servers_ts_id_sq;  
ALTER SEQUENCE ts_stats_tran_user_interval_ts_id_seq RENAME TO  	ts_stat_t_us_itvl_id_sq;  
ALTER SEQUENCE ts_stats_transet_all_daily_ts_id_seq RENAME TO 	ts_stat_ts_all_dly_id_sq; 
ALTER SEQUENCE ts_stats_transet_all_interval_ts_id_seq RENAME TO 	ts_stat_ts_a_itvl_id_sq; 
ALTER SEQUENCE ts_stats_transet_all_monthly_ts_id_seq RENAME TO  	ts_stat_ts_all_mtly_id_sq;  
ALTER SEQUENCE ts_stats_transet_all_weekly_ts_id_seq RENAME TO  	ts_stat_ts_all_wkly_id_sq;  
ALTER SEQUENCE ts_stats_transet_usergroup_daily_ts_id_seq RENAME TO  	ts_stat_ts_usgrp_dly_id_sq;  
ALTER SEQUENCE ts_stats_transet_usergroup_interval_ts_id_seq RENAME TO  	ts_stat_ts_usgrp_itvl_id_sq;  
ALTER SEQUENCE ts_stats_transet_usergroup_monthly_ts_id_seq RENAME TO 	ts_stat_ts_usgrp_mtly_id_sq; 
ALTER SEQUENCE ts_stats_transet_usergroup_weekly_ts_id_seq RENAME TO 	ts_stat_ts_usgrp_wkly_id_sq; 
ALTER SEQUENCE ts_stats_transet_user_daily_ts_id_seq RENAME TO  	ts_stat_ts_us_dly_id_sq;  
ALTER SEQUENCE ts_stats_transet_user_interval_ts_id_seq RENAME TO  	ts_stat_ts_us_itvl_id_sq;  
ALTER SEQUENCE ts_stats_transet_user_monthly_ts_id_seq RENAME TO 	ts_stat_ts_us_mtly_id_sq; 
ALTER SEQUENCE ts_stats_transet_user_weekly_ts_id_seq RENAME TO 	ts_stat_ts_us_wkly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_all_daily_ts_id_seq RENAME TO  	ts_stat_tsgrp_all_dly_id_sq;  
ALTER SEQUENCE ts_stats_transetgroup_all_interval_ts_id_seq RENAME TO 	ts_stat_tsgrp_all_itvl_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_all_monthly_ts_id_seq RENAME TO 	ts_stat_tsgrp_all_mtly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_all_weekly_ts_id_seq RENAME TO 	ts_stat_tsgrp_all_wkly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_usergroup_daily_ts_id_seq RENAME TO 	ts_stat_tsgrp_usgrp_dly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_usergroup_interval_ts_id_seq RENAME TO  	ts_stat_tsgrp_usgrp_itvl_id_sq;  
ALTER SEQUENCE ts_stats_transetgroup_usergroup_monthly_ts_id_seq RENAME TO 	ts_stat_tsgrp_usgrp_mtly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_usergroup_weekly_ts_id_seq RENAME TO 	ts_stat_tsgrp_usgrp_wkly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_user_daily_ts_id_seq RENAME TO 	ts_stat_tsgrp_us_dly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_user_interval_ts_id_seq RENAME TO 	ts_stat_tsgrp_us_itvl_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_user_monthly_ts_id_seq RENAME TO 	ts_stat_tsgrp_us_mtly_id_sq; 
ALTER SEQUENCE ts_stats_transetgroup_user_weekly_ts_id_seq RENAME TO  	ts_stat_tsgrp_us_wkly_id_sq;  
ALTER SEQUENCE ts_stats_tranunit_all_daily_ts_id_seq RENAME TO 	ts_stat_tu_all_dly_id_sq; 
ALTER SEQUENCE ts_stats_tranunit_all_interval_ts_id_seq RENAME TO  	ts_stat_tu_all_itvl_id_sq;  
ALTER SEQUENCE ts_stats_tranunit_all_monthly_ts_id_seq RENAME TO 	ts_stat_tu_all_mtly_id_sq; 
ALTER SEQUENCE ts_stats_tranunit_all_weekly_ts_id_seq RENAME TO  	ts_stat_tu_all_wkly_id_sq;  
ALTER SEQUENCE ts_stats_tranunit_usergroup_daily_ts_id_seq RENAME TO 	ts_stat_tu_usgrp_dly_id_sq; 
ALTER SEQUENCE ts_stats_tranunit_usergroup_interval_ts_id_seq RENAME TO  	ts_stat_tu_usgrp_itvl_id_sq;  
ALTER SEQUENCE ts_stats_tranunit_usergroup_monthly_ts_id_seq RENAME TO  	ts_stat_tu_usgrp_mtly_id_sq;  
ALTER SEQUENCE ts_stats_tranunit_usergroup_weekly_ts_id_seq RENAME TO 	ts_stat_tu_usgrp_wkly_id_sq; 
ALTER SEQUENCE ts_stats_tranunit_user_daily_ts_id_seq RENAME TO  	ts_stat_tu_us_dly_id_sq;  
ALTER SEQUENCE ts_stats_tranunit_user_interval_ts_id_seq RENAME TO 	ts_stat_tu_us_itvl_id_sq; 
ALTER SEQUENCE ts_stats_tranunit_user_monthly_ts_id_seq RENAME TO  	ts_stat_tu_us_mtly_id_sq;  
ALTER SEQUENCE ts_stats_tranunit_user_weekly_ts_id_seq RENAME TO  	ts_stat_tu_us_wkly_id_sq;  
ALTER SEQUENCE ts_tran_def_groups_ts_id_seq RENAME TO 	ts_tran_def_groups_ts_id_sq;
ALTER SEQUENCE ts_tran_importances_ts_id_seq RENAME TO  	ts_tran_importances_ts_id_sq;  
ALTER SEQUENCE ts_trancomps_ts_id_seq RENAME TO 	ts_trancomps_ts_id_sq;
ALTER SEQUENCE ts_tran_comp_details_ts_id_seq RENAME TO 	ts_tran_comp_details_ts_id_sq; 
ALTER SEQUENCE ts_transet_groups_ts_id_seq RENAME TO 	ts_transet_groups_ts_id_sq;
ALTER SEQUENCE ts_transets_ts_id_seq RENAME TO 	ts_transets_ts_id_sq;
ALTER SEQUENCE ts_tran_types_ts_id_seq RENAME TO  	ts_tran_types_ts_id_sq;  
ALTER SEQUENCE ts_tranunits_ts_id_seq RENAME TO  	ts_tranunits_ts_id_sq;  
ALTER SEQUENCE ts_user_def_groups_ts_id_seq RENAME TO  	ts_user_def_groups_ts_id_sq;  
ALTER SEQUENCE ts_user_groups_ts_id_seq RENAME TO  	ts_user_groups_ts_id_sq;  
ALTER SEQUENCE ts_user_importances_ts_id_seq RENAME TO 	ts_user_importances_ts_id_sq; 
ALTER SEQUENCE ts_users_ts_id_seq RENAME TO  	ts_users_ts_id_sq;  
ALTER SEQUENCE ts_users_ts_incarnation_id_seq RENAME TO ts_users_ts_incarnation_id_sq;
ALTER SEQUENCE ts_web_servers_ts_id_seq RENAME TO  	ts_web_servers_ts_id_sq;  
ALTER SEQUENCE tang_config_ts_id_seq RENAME TO  	tang_config_ts_id_sq;  
ALTER SEQUENCE tang_event_types_ts_id_seq RENAME TO  	tang_event_types_ts_id_sq;  
ALTER SEQUENCE tang_events_ts_id_seq RENAME TO  	tang_events_ts_id_sq;  

--upgrading the views

ALTER VIEW TranSetGroupSlaPerformanceTimeSlaView RENAME TO TSGrpSlaPerfTimeSlaVw;
ALTER VIEW UserGroupSlaPerformanceTimeSlaView RENAME TO UsGrpSlaPerfTimeSlaVw;
ALTER VIEW view_biz_event_metadata RENAME TO vw_biz_event_metadata;
ALTER VIEW view_defect_app_server_time RENAME TO vw_defect_app_server_time;
ALTER VIEW view_defect_brta_time RENAME TO vw_defect_brta_time;
ALTER VIEW view_defect_slowest_lowest_comp_time	 RENAME TO vw_defect_slowlow_comptime;
ALTER VIEW view_defect_slowest_lowest_back_comp_time RENAME TO 	vw_defect_slowlow_backcomptime;


--column length changes


-- tang_events
ALTER TABLE tang_events ALTER COLUMN ts_info TYPE VARCHAR(4000);

-- ts_apps
ALTER TABLE ts_apps ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_autogen_params
ALTER TABLE ts_autogen_params ALTER COLUMN ts_name TYPE VARCHAR(4000);

-- ts_biz_events
ALTER TABLE ts_biz_events ALTER COLUMN ts_cause TYPE VARCHAR(4000);
ALTER TABLE ts_biz_events ALTER COLUMN ts_resolution TYPE VARCHAR(4000);

-- ts_biz_event_subnets
ALTER TABLE ts_biz_event_subnets ALTER COLUMN ts_subnet TYPE NUMERIC(39,0);

-- ts_defects
ALTER TABLE ts_defects ALTER COLUMN ts_server_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_defects ALTER COLUMN ts_client_ip_address TYPE NUMERIC(39,0);

-- ts_defect_meta_keys
ALTER TABLE ts_defect_meta_keys ALTER COLUMN ts_name TYPE VARCHAR(4000);

-- ts_domains
ALTER TABLE ts_domains ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);

-- ts_entity
ALTER TABLE ts_entity ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);

-- ts_impact_settings
ALTER TABLE ts_impact_settings ALTER COLUMN ts_action_cmd TYPE VARCHAR(4000);

-- ts_interim_session_id_params
ALTER TABLE ts_interim_session_id_params ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_introscope_ems
ALTER TABLE ts_introscope_ems ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_login_id_parameters
ALTER TABLE ts_login_id_parameters ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_monitors
ALTER TABLE ts_monitors ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_monitors ALTER COLUMN ts_domain_status_code TYPE VARCHAR(4000);
ALTER TABLE ts_monitors ALTER COLUMN ts_tim_status_code TYPE VARCHAR(4000);

-- ts_monitor_types
ALTER TABLE ts_monitor_types ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_params
ALTER TABLE ts_params ALTER COLUMN ts_name TYPE VARCHAR(4000);

-- ts_plugin
ALTER TABLE ts_plugin ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_plugin_filter
ALTER TABLE ts_plugin_filter ALTER COLUMN ts_from_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_plugin_filter ALTER COLUMN ts_to_ip_address TYPE NUMERIC(39,0);

-- ts_recording_components
ALTER TABLE ts_recording_components ALTER COLUMN ts_comments TYPE VARCHAR(4000);
ALTER TABLE ts_recording_components ALTER COLUMN ts_server_ip_address TYPE NUMERIC(39,0);

-- ts_recording_sessions
ALTER TABLE ts_recording_sessions ALTER COLUMN ts_client_ip_address TYPE NUMERIC(39,0);

-- ts_report_def_param_values
ALTER TABLE ts_report_def_param_values ALTER COLUMN ts_value TYPE VARCHAR(4000);

-- ts_report_type_param_values
ALTER TABLE ts_report_type_param_values ALTER COLUMN ts_value TYPE VARCHAR(4000);

-- ts_services_def
ALTER TABLE ts_services_def ALTER COLUMN ts_description TYPE VARCHAR(4000);


-- ts_session_id_parameters
ALTER TABLE ts_session_id_parameters ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_sm_policy_servers
ALTER TABLE ts_sm_policy_servers ALTER COLUMN ts_ip_address TYPE NUMERIC(39,0);

-- ts_sm_web_servers
ALTER TABLE ts_sm_web_servers ALTER COLUMN ts_from_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_sm_web_servers ALTER COLUMN ts_to_ip_address TYPE NUMERIC(39,0);

-- ts_trancomps
ALTER TABLE ts_trancomps ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_transets
ALTER TABLE ts_transets ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_transet_groups
ALTER TABLE ts_transet_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_tranunits
ALTER TABLE ts_tranunits ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_tran_def_groups
ALTER TABLE ts_tran_def_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_tran_types
ALTER TABLE ts_tran_types ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_usergroup_id_parameters
ALTER TABLE ts_usergroup_id_parameters ALTER COLUMN ts_name TYPE VARCHAR(200);

-- ts_user_def_groups
ALTER TABLE ts_user_def_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);

-- ts_user_groups
ALTER TABLE ts_user_groups ALTER COLUMN ts_description TYPE VARCHAR(4000);
ALTER TABLE ts_user_groups ALTER COLUMN ts_subnet_mask TYPE NUMERIC(39,0);
ALTER TABLE ts_user_groups ALTER COLUMN ts_subnet_address TYPE NUMERIC(39,0);

-- ts_web_servers
ALTER TABLE ts_web_servers ALTER COLUMN ts_from_ip_address TYPE NUMERIC(39,0);
ALTER TABLE ts_web_servers ALTER COLUMN ts_to_ip_address TYPE NUMERIC(39,0);

ALTER TABLE ts_biz_events ADD COLUMN ts_record_updated timestamp with time zone;

-- This statement always should be at the end to upgrade to 9.0.5.0 , please do not move it to some other place --
-- Updating database version from 5.0.0.3 to 9.0.6.0

update ts_domains set ts_db_versions='9.0.6.0';
