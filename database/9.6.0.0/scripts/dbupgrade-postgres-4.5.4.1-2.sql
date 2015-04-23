-- update database from 4.5.4.1 to 4.5.5.0
 
ALTER TABLE ts_session_id_parameters ADD COLUMN ts_group int2 NOT NULL default 0;
ALTER TABLE ts_session_id_parameters  DROP CONSTRAINT ts_session_id_parameters_pkey; 
ALTER TABLE ts_session_id_parameters  ADD CONSTRAINT ts_session_id_parameters_pkey PRIMARY KEY(ts_app_id, ts_type, ts_name, ts_id_type,ts_group);
ALTER TABLE ts_login_id_parameters ADD COLUMN ts_group int2 NOT NULL default 0;
ALTER TABLE ts_login_id_parameters  DROP CONSTRAINT ts_login_id_parameters_pkey; 
ALTER TABLE ts_login_id_parameters  ADD CONSTRAINT ts_login_id_parameters_pkey PRIMARY KEY(ts_app_id, ts_type, ts_name,ts_group);
ALTER TABLE ts_impact_settings ALTER COLUMN ts_subject TYPE VARCHAR(10485760);

-- Fix the defaults for email setting on open, moderate, servere and critical incidents
UPDATE ts_settings SET ts_default='support@myCompany.com' WHERE ts_id=1027;
UPDATE ts_settings SET ts_default='Wily CEM Administrator' WHERE ts_id=1028;
UPDATE ts_settings SET ts_default='Wily CEM Incident EMail - Open Notification' WHERE ts_id=1029;
UPDATE ts_settings SET ts_default='This email has been sent to you by Wily CEM Incident Engine because an incident has been opened.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n'  WHERE ts_id=1030;

UPDATE ts_settings SET ts_value='support@myCompany.com' WHERE ts_id=1027 AND ts_value='wily-cemadmin@myCompany.com';
UPDATE ts_settings SET ts_value='Wily CEM Administrator' WHERE ts_id=1028 AND ts_value='Wily CEM Admin';
UPDATE ts_settings SET ts_value='Wily CEM Incident EMail - Open Notification' WHERE ts_id=1029 AND ts_value='Wily CEM bizEvent Mail';
UPDATE ts_settings SET ts_value='This email has been sent to you by Wily CEM Incident Engine because an incident has been opened.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n'  WHERE ts_id=1030 AND ts_value='This email has been sent to you by Wily CEM bizEvent Engine';

UPDATE ts_impact_settings SET ts_fromname='Wily CEM Administrator' WHERE ts_fromname IS NULL;
UPDATE ts_impact_settings SET ts_fromaddress='support@myCompany.com' WHERE ts_fromaddress IS NULL;
UPDATE ts_impact_settings SET ts_subject='Wily CEM Incident EMail - Moderate Notification' WHERE ts_id=1 AND ts_subject IS NULL;
UPDATE ts_impact_settings SET ts_subject='Wily CEM Incident EMail - Severe Notification' WHERE ts_id=2 AND ts_subject IS NULL;
UPDATE ts_impact_settings SET ts_subject='Wily CEM Incident EMail - Critical Notification' WHERE ts_id=3 AND ts_subject IS NULL;
UPDATE ts_impact_settings SET ts_message='This email has been sent to you by Wily CEM Incident Engine because an incident is moderate severity.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n' WHERE ts_id=1 AND ts_message IS NULL;
UPDATE ts_impact_settings SET ts_message='This email has been sent to you by Wily CEM Incident Engine because an incident is severe severity.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n' WHERE ts_id=2 AND ts_message IS NULL;
UPDATE ts_impact_settings SET ts_message='This email has been sent to you by Wily CEM Incident Engine because an incident is critical severity.\n\nWily CEM System Administrators can change CEM incident notification by editing Incident Settings on the Setup > Incident Settings page.\n' WHERE ts_id=3 AND ts_message IS NULL;

create table tang_config 
(
    ts_id int8 not null unique, 
    version_info int8 not null,   
    ts_key varchar(100) not null,
    ts_value varchar(2000) not null,
    ts_soft_delete bool not null default false,
    primary key (ts_id)
);

-- insert tang_config
-- Need to insert with ids, as it is possible that the table may already exist
-- from before. So we dont want to override aprevious settings.
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(1, '0','database.schemaVersion', '10');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(2, '0','email.to', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(3, '0','email.fromName', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(4, '0','email.from', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(5, '0','email.subject', 'Wily CEM Event via email');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(6, '0','email.smtpServer', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(7, '0','email.smtpServer.port', '25');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(8, '0','email.smtpServer.requireAuthentication', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(9, '0','email.smtpServer.username', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(10, '0','email.smtpServer.password', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(11, '0','email.message', E'This email has been sent to you by the Wily CEM Events Engine.\\nEvent Type ID: <id>\\nEvent Name: <name>\\nEvent Severity: <severity>\\nEvent Category: <category>\\nEvent Source: <source>\\nEvent Source IP Address: <ipaddress>\\nEvent Description: <desc>\\nEvent Time: <time>\\n');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(12, '0','snmp.trap.ipAddress', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(13, '0','config.maxEvents', '1000');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(14, '0','config.maxEventAge', '604800');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(15, '0','config.mailSchedule', '0');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(16, '0','config.eventRules', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(17, '0','config.eventRuleToIpAddress', '');
insert into tang_config(ts_id, version_info, ts_key, ts_value) values(18, '0','config.eventRuleFromIpAddress', '');

create table tang_event_types 
(
    ts_id int8 not null unique,
    version_info int8 not null,
    ts_name varchar(100) not null,
    ts_severity varchar(20) not null,
    ts_category varchar(20),
    ts_soft_delete bool not null default false,
    primary key (ts_id)
);
--insert tang_event_types
--not inserting some of the tang_event_types with ts_id (1,2,7,8 and 13) as they are no longer valid event types as Tess 
--is on EM and not renaming the ts_id for the tang_event_types in a sequence as this will involve lot of rework.
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(3, 0, 'Enterprise Manager cannot reach TIM', 'error', 'Communications');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(4, 0, 'No network data', 'warning', 'Communications');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(5, 0, 'Enterprise Manager restarted', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(6, 0, 'TIM restarted', 'informational', 'Administration');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(10, 0, 'User group limit reached', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(11, 0, 'Logins dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(12, 0, 'Defects dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(14, 0, 'Business application name is not valid', 'error', 'WTG');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(15, 0, 'WTG Agent is down', 'warning', 'WTG');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(16, 0, 'WTG Agent is up', 'informational', 'WTG');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(17, 0, 'Duplicate session ids detected', 'warning', 'Monitoring');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(18, 0, 'HTTP Analyzer plug-in error', 'error', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(19, 0, 'Database space info 20% remaining', 'informational', 'Database');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(20, 0, 'Database space warning 5% remaining', 'warning', 'Database');  
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(21, 0, 'Discovered transactions dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(22, 0, 'TIM Collection Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(23, 0, 'TIM Collection Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(24, 0, 'Stats Aggregation Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(25, 0, 'Stats Aggregation Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(26, 0, 'Database Cleanup Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(27, 0, 'Database Cleanup Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(28, 0, 'Limit exceeded adding new components', 'warning', 'Processing');

  -- Updating database version
update ts_domains set ts_db_versions='4.5.5.0';
