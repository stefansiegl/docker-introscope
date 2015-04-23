-- upgrade database from 4.1.2 to 4.1.3

-- fix bug 1962 - report type field empty for certain time-series reports
update ts_report_type_param_values set ts_value = 'comparison,timeSeries' where ts_id in (127,128,129,130,131,132,133,134); 

-- fix bug 2011 - a soft deleted login name can never be reused
alter table ts_users add column ts_login_name varchar(200);
update ts_users set ts_login_name = (select ts_raw_login_name from ts_user_logins_map where ts_user_id=ts_id limit 1);
delete from ts_user_logins_map where ts_soft_delete = true;
update ts_users set ts_login_name = '???' where ts_login_name is null;

-- Updating database version
update ts_domains set ts_db_versions='4.1.3';
