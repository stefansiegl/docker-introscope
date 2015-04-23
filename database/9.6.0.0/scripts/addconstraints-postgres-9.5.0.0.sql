-- This file is adapted from the one generated automatically by
-- generate-createtables-postgres.sh 
-- using org.hibernate.tool.hbm2ddl.SchemaExport

-- this file is in alphabetical order -- please keep it that away.

alter table ts_apps 
    add constraint FKC1F8AC329E85330D 
    foreign key (ts_domain_id) 
    references ts_domains;
alter table ts_apps 
    add constraint FKC1F8AC328CD64687 
    foreign key (ts_authtype_id) 
    references ts_app_auth_types;
alter table ts_apps 
    add constraint FKC1F8AC328CD64688
    foreign key (ts_apptype_id) 
    references ts_app_types;
alter table ts_attributes
    add constraint FKF110A8825A698EC3
    foreign key (ts_monitor_type)
    references ts_monitor_types (ts_id);    
alter table ts_attributes
    add constraint FKF110A852EF375ED8
    foreign key (ts_protocol_type)
    references ts_protocols (ts_id);
alter table ts_attributes
    add constraint FKA110A752AF225ED0
    foreign key (ts_tran_type)
    references ts_tran_types (ts_id);
alter table ts_audit_record_props
    add constraint FKC35853A67ED614FE
    foreign key (ts_audit_record_id)
    references ts_audit_records;
alter table ts_audit_record_props
    add constraint FKC35853A64AFDC9FF
    foreign key (ts_audit_record_props)
    references ts_audit_records;
alter table ts_autogen_params
  add constraint fked464au11a100010
  foreign key (ts_template_id)
  references ts_autogen_template(ts_id)
  on update no action on delete cascade;
alter table ts_autogen_template
  add constraint fked464au12a100010
  foreign key (ts_apps_id)
  references ts_apps(ts_id)
  on update no action on delete no action;
alter table ts_bizdef_filters 
    add constraint fk3216d15c22b94axl 
    foreign key (ts_trandef_groups_id) 
    references ts_tran_def_groups on delete cascade;
alter table ts_bizdef_filters 
    add constraint fk3216d15c22b94bxl 
    foreign key (ts_monitor_type) 
    references ts_monitor_types;
alter table ts_biz_events 
    add constraint FKF300A7859DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_biz_events 
    add constraint FKF300A7854AD9EEC4 
    foreign key (ts_defect_def_id) 
    references ts_defect_defs;
alter table ts_biz_event_subnets
    add constraint fkf300a7854ad9ffd5
    foreign key (ts_biz_event_id)
    references ts_biz_events (ts_id)
    on update no action on delete cascade;
alter table ts_child_services_def
    add constraint FK78097D6E27254A97
    foreign key (ts_parent_id)
    references ts_services_def (ts_id) on delete cascade;	
alter table ts_defect_defs 
    add constraint FK3216D15C22B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_defect_defs 
    add constraint FK3216D15C2E10A59E 
    foreign key (ts_importance_id) 
    references ts_defect_importances;
alter table ts_defect_defs 
    add constraint FK3216D15C9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_defect_defs 
    add constraint FK3216D15C9DCCA47 
    foreign key (ts_attribute_id) 
    references ts_attributes (ts_id)
	on update no action on delete cascade;	
alter table ts_defect_defs 
    add constraint FK3216D15CB62FC018 
    foreign key (ts_trancomp_id) 
    references ts_trancomps;
alter table ts_defects_interval 
    add constraint FK6C18990222B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_defects_interval 
    add constraint FK6C1899029DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_defects_interval 
    add constraint FK6C189902545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_defects_interval 
    add constraint FK6C189902B62FC018 
    foreign key (ts_trancomp_id) 
    references ts_trancomps;
alter table ts_defect_meta_values 
    add constraint FKE00FC8E3955976 
    foreign key (ts_metakey_id) 
    references ts_defect_meta_keys on delete cascade;    
alter table ts_defects_interval 
    add constraint FK6C189902F081AE66 
    foreign key (ts_biz_event_id) 
    references ts_biz_events on delete cascade;
alter table ts_defects_interval 
    add constraint FK6C1899024AD9EEC4 
    foreign key (ts_defect_def_id) 
    references ts_defect_defs;
alter table ts_domains 
    add constraint FK461B8A6FB31EE104 
    foreign key (ts_tran_importance_id) 
    references ts_tran_importances;
alter table ts_domains 
    add constraint FK461B8A6FF8C9F244 
    foreign key (ts_user_importance_id) 
    references ts_user_importances;
alter table ts_entity
    add constraint ts_entity_ts_port_check 
    check (0 < ts_port and ts_port < 65536);
alter table ts_entity_service
    add constraint FK78097D6E27154D97
    foreign key (ts_service_id)
    references ts_services_def on delete cascade;
alter table ts_entity_service
    add constraint FK79097D6E27167E11
    foreign key (ts_entity_id)
    references ts_entity on delete cascade;	
alter table ts_impact_settings 
    add constraint FKEE3AC53C9E85330D 
    foreign key (ts_domain_id) 
    references ts_domains;
alter table ts_locks
    add constraint FK79097D6E27167E13
    foreign key (ts_entity_id)
    references ts_entity on delete cascade;	
alter table ts_login_id_parameters 
    add constraint FK2999D77892916D70 
    foreign key (ts_app_id) 
    references ts_apps on delete cascade;
alter table ts_monitors
    add constraint FK924B8A6AA179D180 
    foreign key (ts_monitor_type)
    references ts_monitor_types (ts_id);
alter table ts_monitor_child_service
    add constraint FK78097D6E35354E97
    foreign key (ts_child_service_id)
    references ts_child_services_def (ts_id) on delete cascade;
alter table ts_monitor_child_service
    add constraint FK64597D6E35354B97
    foreign key (ts_entity_service_id)
    references ts_entity_service (ts_id) on delete cascade;  
alter table ts_monitor_child_service
    add constraint FK67657D6E35354R97
    foreign key (ts_monitors_id)
    references ts_monitors (ts_id) on delete cascade;	
alter table ts_operator_role_map
    add constraint FK123456789ABCDEF0
    foreign key (ts_role_id)
    references ts_roles on delete cascade;
alter table ts_operator_role_map
    add constraint FK123456789ABCDEF1
    foreign key (ts_operator_id)
    references ts_operators on delete cascade;
alter table ts_params 
    add constraint FK3F446B46B62FC018 
    foreign key (ts_trancomp_id) 
    references ts_trancomps on delete cascade;
alter table ts_plugin_filter
    add constraint fked464pl1aa100000
    foreign key (ts_plugin_id)
    references ts_plugin (ts_id)
    on update no action on delete cascade;
alter table ts_plugin_url_filter
    add constraint fked464p11aa100010
    foreign key (ts_plugin_id)
    references ts_plugin (ts_id)
    on update no action on delete cascade;
alter table ts_private_parameters 
    add constraint FKFE6043E69E85330D 
    foreign key (ts_domain_id) 
    references ts_domains;
alter table ts_recording_components 
    add constraint FKED464BE4C6CF0E08
    foreign key (ts_main_component_reference) 
    references ts_recording_components;    
alter table ts_recording_components 
    add constraint FKED464BE4BB341521 
    foreign key (ts_recording_id) 
    references ts_recording_sessions on delete cascade;
alter table ts_recording_components 
    add constraint FKED464BE4C6CF0E07 
    foreign key (ts_monitor_id) 
    references ts_monitors;
alter table ts_report_def_param_values
    add constraint FKDE7570F927121B26
    foreign key (ts_param_key_id)
    references ts_report_param_keys on delete cascade;
alter table ts_report_def_param_values
    add constraint FKDE7570F9A0746AFE
    foreign key (ts_report_def_id)
    references ts_report_defs on delete cascade;
alter table ts_report_defs
    add constraint FK498E2779DF34A896
    foreign key (ts_report_type_id)
    references ts_report_types;
alter table ts_report_type_param_values
    add constraint FK78097D6EDF34A896
    foreign key (ts_report_type_id)
    references ts_report_types on delete cascade;
alter table ts_report_type_param_values
    add constraint FK78097D6E27121B26
    foreign key (ts_param_key_id)
    references ts_report_param_keys on delete cascade;
alter table ts_services_start_times
    add constraint FK78097D6E27154D98
    foreign key (ts_service_id)
    references ts_services_def on delete cascade;
alter table ts_services_start_times
    add constraint FK79097D6E27167E12
    foreign key (ts_entity_id)
    references ts_entity on delete cascade; 
alter table ts_session_id_parameters 
    add constraint FKB01847E592916D70 
    foreign key (ts_app_id) 
    references ts_apps on delete cascade;
alter table ts_sm_policy_servers 
    add constraint FK7024A482916E672 
    foreign key (ts_sm_group_id) 
    references ts_sm_groups on delete cascade;
alter table ts_sm_web_servers 
    add constraint FK7591FF002916E672 
    foreign key (ts_sm_group_id) 
    references ts_sm_groups on delete cascade;
alter table ts_st_ts_all_dly 
    add constraint FK76A257B39DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_all_int
    add constraint FK5F73CCEB9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_all_mly
    add constraint FK4BB10B279DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_all_wly 
    add constraint FK7E4B3A279DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_usgrp_int
    add constraint FKF0580C789DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_usgrp_int
    add constraint FKF0580C7847078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_ts_usgrp_mly
    add constraint FK9AB025FA9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_usgrp_mly
    add constraint FK9AB025FA47078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_ts_usgrp_wly 
    add constraint FKB263F8F49DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_usgrp_wly 
    add constraint FKB263F8F447078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_ts_us_dly 
    add constraint FK8ED105ED9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_us_dly 
    add constraint FK8ED105ED545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_ts_us_int
    add constraint FK7FB8BC719DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_us_int
    add constraint FK7FB8BC71545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_ts_us_mly
    add constraint FK12ED12E19DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_us_mly
    add constraint FK12ED12E1545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_ts_us_wly 
    add constraint FK6BF2532D9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_us_wly 
    add constraint FK6BF2532D545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_ts_usgrp_dly 
    add constraint FKD2D663669DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_ts_usgrp_dly 
    add constraint FKD2D6636647078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tsgrp_all_dly 
    add constraint FK13C22764AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_all_int
    add constraint FK185E139AAAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_all_mly
    add constraint FK201BB298AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_all_wly 
    add constraint FK85256096AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_usgrp_dly 
    add constraint FKFD379237AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_usgrp_dly 
    add constraint FKFD37923747078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tsgrp_usgrp_int
    add constraint FKEF5853E7AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_usgrp_int
    add constraint FKEF5853E747078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tsgrp_usgrp_mly
    add constraint FK81E1B4ABAAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_usgrp_mly
    add constraint FK81E1B4AB47078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tsgrp_usgrp_wly 
    add constraint FKCA5D5023AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_usgrp_wly 
    add constraint FKCA5D502347078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tsgrp_us_dly 
    add constraint FK95AB2C5CAAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_us_dly 
    add constraint FK95AB2C5C545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_tsgrp_us_int
    add constraint FKE4174BA2AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_us_int
    add constraint FKE4174BA2545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_tsgrp_us_mly
    add constraint FKCBD75990AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_us_mly
    add constraint FKCBD75990545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_tsgrp_us_wly 
    add constraint FK405CFA9EAAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups;
alter table ts_st_tsgrp_us_wly 
    add constraint FK405CFA9E545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_tu_all_dly 
    add constraint FKC5EBB24B22B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_all_dly 
    add constraint FKC5EBB24B9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_all_int
    add constraint FK8B94B5322B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_all_int
    add constraint FK8B94B539DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_all_mly
    add constraint FKEE0E1FBF22B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_all_mly
    add constraint FKEE0E1FBF9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_all_wly 
    add constraint FK182D328F22B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_all_wly 
    add constraint FK182D328F9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_usgrp_dly 
    add constraint FK845113DE22B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_usgrp_dly 
    add constraint FK845113DE9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_usgrp_dly 
    add constraint FK845113DE47078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tu_usgrp_int
    add constraint FKA08F1CE022B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_usgrp_int
    add constraint FKA08F1CE09DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_usgrp_int
    add constraint FKA08F1CE047078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tu_usgrp_mly
    add constraint FKA8A1689222B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_usgrp_mly
    add constraint FKA8A168929DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_usgrp_mly
    add constraint FKA8A1689247078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tu_usgrp_wly 
    add constraint FK2674035C22B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_usgrp_wly 
    add constraint FK2674035C9DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_usgrp_wly 
    add constraint FK2674035C47078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups;
alter table ts_st_tu_us_dly 
    add constraint FK28B2FE5522B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_us_dly 
    add constraint FK28B2FE559DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_us_dly 
    add constraint FK28B2FE55545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_tu_us_int
    add constraint FKFF230B0922B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_us_int
    add constraint FKFF230B099DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_us_int
    add constraint FKFF230B09545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_tu_us_mly
    add constraint FKBC32914922B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_us_mly
    add constraint FKBC3291499DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_us_mly
    add constraint FKBC329149545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_st_tu_us_wly 
    add constraint FKE4F67C522B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_st_tu_us_wly 
    add constraint FKE4F67C59DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_st_tu_us_wly 
    add constraint FKE4F67C5545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_tran_def_groups 
    add constraint FKE5A903221F3F4798 
    foreign key (ts_importance_id) 
    references ts_tran_importances;
alter table ts_tran_def_groups 
    add constraint FKE5A903229E85330D 
    foreign key (ts_domain_id) 
    references ts_domains;
alter table ts_tran_def_groups 
    add constraint FKE5A9032292916D70 
    foreign key (ts_app_id) 
    references ts_apps;
alter table ts_trancomps 
    add constraint FK445D393922B94AEE 
    foreign key (ts_tranunit_id) 
    references ts_tranunits;
alter table ts_trancomps 
    add constraint FK445D393922B94AEF
    foreign key (ts_recording_component_id) 
    references ts_recording_components;
alter table ts_transet_groups 
    add constraint FK530C337C1F3F4798 
    foreign key (ts_importance_id) 
    references ts_tran_importances;
alter table ts_transet_groups 
    add constraint FK530C337C6C0651EB 
    foreign key (ts_parent_id) 
    references ts_transet_groups;
alter table ts_transet_groups 
    add constraint FK530C337CAD6E1758 
    foreign key (ts_trandef_group_id) 
    references ts_tran_def_groups;
alter table ts_transet_usergroup_slas
    add constraint FK7E37E448E92C7899
    foreign key (ts_usergroup_id) 
    references ts_user_groups on delete cascade;
alter table ts_transet_usergroup_slas
    add constraint FK7E37E448E92C789A
    foreign key (ts_transet_id) 
    references ts_transets on delete cascade;
alter table ts_transetgroup_transets_map 
    add constraint FK6DE90A309DADA24 
    foreign key (ts_transet_id) 
    references ts_transets on delete cascade;
alter table ts_transetgroup_transets_map 
    add constraint FK6DE90A30AAF0715E 
    foreign key (ts_transet_group_id) 
    references ts_transet_groups on delete cascade;
alter table ts_transets 
    add constraint FK865CB7BC1F3F4798 
    foreign key (ts_importance_id) 
    references ts_tran_importances;
alter table ts_transets 
    add constraint FK865CB7BCAD6E1758 
    foreign key (ts_trandef_group_id) 
    references ts_tran_def_groups;
alter table ts_transets 
    add constraint FK865CB7BC92916D70 
    foreign key (ts_app_id) 
    references ts_apps;
alter table ts_tranunits 
    add constraint FK455A5D649DADA24 
    foreign key (ts_transet_id) 
    references ts_transets;
alter table ts_usergroup_id_parameters 
    add constraint FK2999D77892916D71
    foreign key (ts_app_id) 
    references ts_apps on delete cascade;
alter table ts_userGroup_users_map 
    add constraint FK74F8FFDA545ADA6D 
    foreign key (ts_user_id) 
    references ts_users on delete cascade;
alter table ts_userGroup_users_map 
    add constraint FK74F8FFDA47078C67 
    foreign key (ts_userGroup_id) 
    references ts_user_groups on delete cascade;
alter table ts_user_def_groups 
    add constraint FKFA34E68261F97838 
    foreign key (ts_importance_id) 
    references ts_user_importances;
alter table ts_user_def_groups 
    add constraint FKFA34E6829E85330D 
    foreign key (ts_domain_id) 
    references ts_domains;
alter table ts_user_groups 
    add constraint FK3ABEC70861F97838 
    foreign key (ts_importance_id) 
    references ts_user_importances;
alter table ts_user_groups 
    add constraint FK3ABEC708E92C7898 
    foreign key (ts_userdef_group_id) 
    references ts_user_def_groups;
alter table ts_user_groups 
    add constraint FK3ABEC7082BAEEA11 
    foreign key (ts_parent_id) 
    references ts_user_groups;
alter table ts_user_logins_map 
    add constraint FKEC04E0FB545ADA6D 
    foreign key (ts_user_id) 
    references ts_users on delete cascade;
alter table ts_user_logins_map 
    add constraint FKEC04E0FB92916D70 
    foreign key (ts_app_id) 
    references ts_apps on delete cascade;
alter table ts_user_logins_map 
    add constraint FKEC04E0FB92916D71 
    foreign key (ts_apptype_id) 
    references ts_app_types on delete cascade;
alter table ts_us_sessions_map 
    add constraint FKE04844EE545ADA6D 
    foreign key (ts_user_id) 
    references ts_users on delete cascade;
alter table ts_us_sessions_map 
    add constraint FKE04844EE92916D70 
    foreign key (ts_app_id) 
    references ts_apps on delete cascade;
alter table ts_us_sessions_map 
    add constraint FKE04844EE92916D71 
    foreign key (ts_apptype_id) 
    references ts_app_types on delete cascade;
alter table ts_users 
    add constraint FK7E37E44861F97838 
    foreign key (ts_importance_id) 
    references ts_user_importances;
alter table ts_users 
    add constraint FK7E37E448E92C7898 
    foreign key (ts_userdef_group_id) 
    references ts_user_def_groups;
alter table ts_web_servers 
    add constraint FKB4963DE5C6CF0E07 
    foreign key (ts_monitor_id) 
    references ts_monitors on delete cascade;
alter table tang_events
    add constraint FKB4963DE5C6CF0E08
    foreign key (ts_type_id)
    references tang_event_types on delete cascade;    
    
