-- upgrade database from 3.0.1 to 3.1.0

\echo Updating database version
update ts_domains set ts_db_versions='3.1.0';

-- fix bug 2119
alter table ts_defect_meta_values drop constraint FKE00FC8E235F57ED;
alter table ts_defect_meta_values add constraint FKE00FC8E235F57ED
  foreign key (ts_defect_id) references ts_defects on delete cascade; 

-- NTLM changes

alter table ts_params add column ts_operator int2 default 0 not null;
update ts_params set ts_operator=1 where ts_matched is true;
alter table ts_params drop column ts_matched;

update ts_app_types set ts_name='Application Specific' where ts_id=1;
insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(3, 'NTLM Authentication', false, 1);
insert into ts_app_types(ts_id, ts_name, ts_soft_delete, version_info) values(4, 'Basic Authentication', false, 1);

-- Parameter Type Changes
update ts_params set ts_param_type='NETEGRITY_SITEMINDER' where ts_param_type='NETEGRITY SITEMINDER';
update ts_login_id_parameters set ts_type='NETEGRITY_SITEMINDER' where ts_type='NETEGRITY SITEMINDER';
update ts_session_id_parameters set ts_type='NETEGRITY_SITEMINDER' where ts_type='NETEGRITY SITEMINDER';

-- misc tess settings
create table ts_settings (
    ts_id int8 not null unique,
    version_info int8 not null,
    ts_key varchar(100) not null,
    ts_value varchar(1000) not null,
    ts_description varchar(200),
    ts_default varchar(1000),
    ts_soft_delete bool not null,
    primary key (ts_id)
);
create index ts_settings_KeyIndex on ts_settings (ts_key);

-- add new meta key values
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (9, 'Introscope', 'agentHost', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (10, 'Introscope', 'agentProcess', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (11, 'Introscope', 'backendIpList', 1, true, false, 1);

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

