-- upgrade database from 4.1.4 to 4.2.0

-- fix bugs 1153 & 1792
create table ts_daily_aggregation_log (
    ts_id timestamp not null unique,
    version_info int8 not null,
    ts_start_time timestamp not null,
    ts_end_time timestamp,
    ts_completed bool,
    ts_soft_delete bool not null,
    primary key (ts_id)
);
-- don't run daily aggregation again for the day before the upgrade
insert into ts_daily_aggregation_log values (current_date-1, 1, current_timestamp, current_timestamp, true, false);

-- New Setting to indicate if passwords have been changed to be FIPS compliant
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1023, 1, 'resetPasswordToEncryptionFIPSCompliant', 'false', 'Operator password, Interscope password, SMTP password should be modified based on FIPS compliance if upgrade happens', '', false);

-- add missing required column
alter table ts_audit_record_props add column ts_soft_delete bool not null default false;
alter table ts_audit_records add column ts_soft_delete bool not null default false;
alter table ts_operator_role_map add column ts_soft_delete bool not null default false;
alter table ts_transet_usergroup_slas add column ts_soft_delete bool not null default false;

-- allow non-literals in parameter names
alter table ts_params add column ts_name_type int2 not null default 0;

-- FIPS compliance
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1024, 1, 'encryptDefectHttpInfo', 'pwyvbUr3NAa14sv+hEvjSg==', 'Defect Http Infomation has to be encrypted based on FIPS', '', false);
alter table ts_defect_meta_values add ts_encrypt_value bool not null default false;

insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1025, 1, 'encryptSessionId', 'pwyvbUr3NAa14sv+hEvjSg==', 'Session Id has to be encrypted based on FIPS', '', false);
alter table ts_user_sessions_map add ts_encrypt_session_id bool not null default false;

alter table ts_introscope_ems alter column ts_password type varchar(400);
alter table ts_operators alter column ts_password type varchar(400);

-- name change eTrust -> CA
update ts_app_auth_types set ts_name='CA SiteMinder' where ts_id=2;

-- ts_monitors table to support ipv6: change data type of existing column and add additional column (ts_ip_address_type)
alter table ts_monitors add column ts_ip_address_type int2 default 1;
alter table ts_monitors alter column ts_ip_address type numeric;

-- ts_sm_policy_servers table to support ipv6: change data type of existing column and add additional column (ts_ip_address_type)
alter table ts_sm_policy_servers add column ts_ip_address_type int2 default 1;
alter table ts_sm_policy_servers alter column ts_ip_address type numeric;


-- ts_user_groups table to support ipv6: change data type of the existing columns for subnet mask and address and add additional column (ts_ip_address_type)
alter table ts_user_groups add column ts_ip_address_type int2 default 1;
alter table ts_user_groups alter column ts_subnet_mask type numeric;
alter table ts_user_groups alter column ts_subnet_address type numeric;

-- ts_domains table to support ipv6: change data type of existing column and add additional column (ts_ip_address_type)
alter table ts_domains add column ts_subnet_mask varchar(200);
alter table ts_domains add column ts_ip_address_type int2 default 1;
alter table ts_domains alter column ts_ip_address type numeric;
UPDATE ts_domains
      SET ts_subnet_mask =
                CASE
                    WHEN (ts_new_ip_user_groups_enabled = '1')
                        THEN '255.255.255.0'
                    ELSE ts_subnet_mask
                END;

--ts_web_servers table to support ipv6: change data type of existing column and add additional column (ts_ip_address_type)
alter table ts_web_servers add column ts_ip_address_type int2 default 1;
alter table ts_web_servers alter column ts_from_ip_address type numeric;
alter table ts_web_servers alter column ts_to_ip_address type numeric;

--ts_sm_web_servers table to support ipv6: change data type of existing column and add additional column (ts_ip_address_type)
alter table ts_sm_web_servers add column ts_ip_address_type int2 default 1;
alter table ts_sm_web_servers alter column ts_from_ip_address type numeric;
alter table ts_sm_web_servers alter column ts_to_ip_address type numeric;

--ts_defects table to support ipv6: change data type of existing column and add additional column (ts_ip_address_type)
alter table ts_defects add column ts_server_ip_address_type int2 default 1;
alter table ts_defects add column ts_client_ip_address_type int2 default 1;
alter table ts_defects alter column ts_server_ip_address type numeric;
alter table ts_defects alter column ts_client_ip_address type numeric;

--ts_recording_sessions table to support ipv6: change data type of existing column and add additional column (ts_ip_address_type)
alter table ts_recording_sessions add column ts_client_ip_address_type int2 default 1;
alter table ts_recording_sessions alter column ts_client_ip_address type numeric;

--ts_recording_components table to support ipv6
alter table ts_recording_components add column ts_server_ip_address_type int2 default 1;
alter table ts_recording_components alter column ts_server_ip_address type numeric;
 
drop function format_ip_address(int8);

-- fix bug 2062 - selecting incident detail link causes exception
update ts_defects set ts_data_center_time = -1 where ts_data_center_time is null;
alter table ts_defects alter column ts_data_center_time set not null;

-- ts_introscope_ems table to support loading Introscope API based on EM version
alter table ts_introscope_ems add column ts_em_version varchar(200) not null default '8.0';
alter table ts_introscope_ems add column ts_has_mix_mode bool not null default true;
update ts_introscope_ems set ts_has_mix_mode =
    case
        when (ts_enabled != true)
            then false
        else ts_has_mix_mode
    end;           

-- Updating database version
update ts_domains set ts_db_versions='4.2.0';
