-- upgrade database from 4.0.9 to 4.1.0

-- licensing tables
create table ts_concurrent_sessions (
    ts_id int8 not null unique,
	ts_session_count int4 not null,
    ts_creation_date timestamp with time zone not null,
    ts_year int2 not null,
    ts_month int2 not null,
    ts_week int2 not null,
    ts_day int2 not null,
    ts_hour int2 not null,
    version_info int8 not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);
create table ts_license_compliance (
    ts_id int8 not null unique,
	ts_compliant bool not null,
	ts_max_sessions int4 not null,
	ts_actual_sessions int4 not null,
	ts_session_samples int4 not null,
    ts_creation_date timestamp with time zone not null,
    ts_year int2 not null,
    ts_month int2 not null,
    version_info int8 not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);
create table ts_session_usage_daily (
    ts_id int8 not null unique,
    ts_samples int4 not null,
	ts_min_sessions int4 not null,
	ts_max_sessions int4 not null,
	ts_sessions_lp float8 not null,
	ts_sessions_95p float8 not null,
	ts_sessions_75p float8 not null,
	ts_sessions_50p float8 not null,
	ts_sessions_25p float8 not null,
	ts_sessions_5p float8 not null,
    ts_occur_date timestamp with time zone not null,
    ts_year int2 not null,
    ts_month int2 not null,
    ts_week int2 not null,
    ts_day int2 not null,
    ts_day_of_week int2 not null,
    ts_hour int2 not null,
    version_info int8 not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);
create table ts_session_usage_interval (
    ts_id int8 not null unique,
    ts_samples int4 not null,
	ts_min_sessions int4 not null,
	ts_max_sessions int4 not null,
	ts_sessions_lp float8 not null,
	ts_sessions_95p float8 not null,
	ts_sessions_75p float8 not null,
	ts_sessions_50p float8 not null,
	ts_sessions_25p float8 not null,
	ts_sessions_5p float8 not null,
    ts_occur_date timestamp with time zone not null,
    ts_year int2 not null,
    ts_month int2 not null,
    ts_week int2 not null,
    ts_day int2 not null,
    ts_day_of_week int2 not null,
    ts_hour int2 not null,
    version_info int8 not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);
create table ts_session_usage_monthly (
    ts_id int8 not null unique,
    ts_samples int4 not null,
	ts_min_sessions int4 not null,
	ts_max_sessions int4 not null,
	ts_sessions_lp float8 not null,
	ts_sessions_95p float8 not null,
	ts_sessions_75p float8 not null,
	ts_sessions_50p float8 not null,
	ts_sessions_25p float8 not null,
	ts_sessions_5p float8 not null,
    ts_last_aggregated_row timestamp with time zone not null,
    ts_occur_date timestamp with time zone not null,
    ts_year int2 not null,
    ts_month int2 not null,
    ts_week int2 not null,
    ts_day int2 not null,
    ts_day_of_week int2 not null,
    ts_hour int2 not null,
    version_info int8 not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);
create table ts_session_usage_weekly (
    ts_id int8 not null unique,
    ts_samples int4 not null,
	ts_min_sessions int4 not null,
	ts_max_sessions int4 not null,
	ts_sessions_lp float8 not null,
	ts_sessions_95p float8 not null,
	ts_sessions_75p float8 not null,
	ts_sessions_50p float8 not null,
	ts_sessions_25p float8 not null,
	ts_sessions_5p float8 not null,
    ts_last_aggregated_row timestamp with time zone not null,
    ts_occur_date timestamp with time zone not null,
    ts_year int2 not null,
    ts_month int2 not null,
    ts_week int2 not null,
    ts_day int2 not null,
    ts_day_of_week int2 not null,
    ts_hour int2 not null,
    version_info int8 not null,
    ts_soft_delete bool not null,
    primary key (ts_id)
);

-- new licensing and session usage reports
insert into ts_report_types values (26, 1, 'LicenseComplianceReport', false);
insert into ts_report_types values (27, 1, 'SessionUsageReport', false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (155,1,1,26,'licenseComplianceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (156,1,1,27,'sessionUsageReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (157,1,20,27,'LastWeek',false);

-- license warning items
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1016, 1, 'license.notification', 'enabled', 'Enables/disables license warning notification', 'enabled', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1017, 1, 'license.reserve', '5', 'License warning when (100-reserve)% of licensed concurrent sessions is less than actual concurrent sessions', '5', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1018, 1, 'license.emailAddresses', '', 'Email address notified if a license warning is needed', '', false);

--fix bug 952 - primary key of ts_user_logins_map wrong
alter table ts_user_logins_map drop constraint ts_user_logins_map_pkey;
alter table ts_user_logins_map add constraint ts_user_logins_map_pkey primary key (ts_app_id, ts_login_name);

--bug fix 1597 - adding indexes to ts_biz_events table
create index ts_biz_events_TransetIncarnationIdIndex on ts_biz_events (ts_transet_incarnation_id);
create index ts_biz_events_TransetIdIndex on ts_biz_events (ts_transet_id);

-- fix bug 1657 - wrong default timeframe for scheduled defect freq report
update ts_report_type_param_values set ts_report_type_id = 27 where ts_id = 157;

-- Updating database version
update ts_domains set ts_db_versions='4.1.0';
