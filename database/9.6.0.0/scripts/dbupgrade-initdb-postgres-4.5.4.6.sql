-- update database from 4.5.4.6 to 5.0.0.0 for APM 9.0

-- insert services_defs
insert into ts_services_def(version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (1, 'TIM.Collection.Svc', 'TIM Collection Service', 'The service includes: Login Processing, Defect Processing, Recording Processing, TANG Event Processing, Hourly Statistics Processing, BT Statistics Processing, Transaction Analysis Service', true, false, false);
insert into ts_services_def(version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (1, 'Stats.Aggregation.Svc', 'Stats Aggregation Service', 'The service aggregates the statistics on a daily basis, runs against the database', true, false, false);
insert into ts_services_def(version_info, ts_name, ts_display_name, ts_description, ts_singleton, ts_required, ts_soft_delete) values (1, 'DB.Cleanup.Svc', 'DB Cleanup Service', 'The service cleans up aged out data from the database', true, false, false);

-- insert child_services_def
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Login.Collection.Service', 'Login Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Defect.Collection.Service', 'Defect Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Recording.Collection.Service', 'Recording Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Events.Collection.Service', 'Events Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Hourly.Collection.Service', 'Hourly Collection Service', false, null, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'Transaction.Discovery.Collection.Service', 'Transaction Discovery Collection Service', true, false, false);
insert into ts_child_services_def(version_info, ts_parent_id, ts_name, ts_description, ts_monitor_assignable, ts_started, ts_soft_delete) values (1, 1, 'RTTM.Collection.Service', 'RTTM Collection Service', true, true, false);

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
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(21, 0, 'Discovered transactions dropped', 'warning', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(22, 0, 'TIM Collection Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(23, 0, 'TIM Collection Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(24, 0, 'Stats Aggregation Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(25, 0, 'Stats Aggregation Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(26, 0, 'Database Cleanup Service has started', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(27, 0, 'Database Cleanup Service has stopped', 'informational', 'Processing');
insert into tang_event_types(ts_id, version_info, ts_name, ts_severity, ts_category) values(28, 0, 'Limit exceeded adding new components', 'warning', 'Processing');

insert into ts_protocols(ts_name) values('http');

insert into ts_tran_types(ts_name) values('Component');
insert into ts_tran_types(ts_name) values('Transaction');
insert into ts_tran_types(ts_name) values('Business Transaction');

-- initialize ts_attributes table
-- each attribute is specifically and directly referred to in the code. The ids are expected to be as specified below.
-- No reordering of entries should be done to this table without changing the code where the ids below
-- are referenced.  This is unlike other tables where the ids are auto-generated.
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(1, 1, 3, true, 'CEM', 'Transaction Time', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(2, 1, 3, true, 'CEM', 'Throughput', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(3, 1, 3, true, 'CEM', 'Transaction Size', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(4, 1, 3, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(5, 1, 2, true, 'CEM', 'Transaction Time', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(6, 1, 2, true, 'CEM', 'Throughput', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(7, 1, 2, true, 'CEM', 'Transaction Size', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(8, 1, 2, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(9, 1, 1, true, 'CEM', 'HTTP Code', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(10, 1, 1, true, 'CEM', 'Content Text', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(11, 1, 1, true, 'CEM', 'Component Timeout', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(12, 1, 1, true, 'CEM', 'HTTP Response Header Text', 2, 1, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(13, 1, 2, true, 'ISCP', 'Response Time', 2, 2, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(14, 1, 2, true, 'ISCP', 'Errors Per Interval', 2, 2, 1, false);
insert into ts_attributes(ts_id,version_info,ts_tran_type,ts_collection_attr,ts_category,ts_name,ts_type,ts_monitor_type,ts_protocol_type,ts_soft_delete) values(15, 1, 2, true, 'ISCP', 'Response Per Interval', 2, 2, 1, false);

-- update existing defect definitions to refer to an attribute id
update ts_defect_defs set ts_attribute_id=1 where ts_type=1 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=1 where ts_type=2 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=2 where ts_type=3 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=2 where ts_type=4 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=3 where ts_type=5 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=3 where ts_type=6 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=4 where ts_type=9 and ts_tran_type=3;
update ts_defect_defs set ts_attribute_id=5 where ts_type=1 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=5 where ts_type=2 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=6 where ts_type=3 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=6 where ts_type=4 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=7 where ts_type=5 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=7 where ts_type=6 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=8 where ts_type=9 and ts_tran_type=2;
update ts_defect_defs set ts_attribute_id=9 where ts_type=8 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=9 where ts_type=8 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=9 where ts_type=8 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=10 where ts_type=10 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=11 where ts_type=11 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=11 where ts_type=16 and ts_tran_type=1;
update ts_defect_defs set ts_attribute_id=11 where ts_type=17 and ts_tran_type=1;

-- this statement must be executed after the above 2 tables have been initialized 
-- thus its presence in this file vs the regular upgrade script
alter table ts_defect_defs alter column ts_attribute_id set not null;
-- initialize upgrade to TIM Monitoring
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1032, 1, 'upgradeToTimMonitoring', 'true', 'Boolean to indicate if upgrade to TIM monitoring is completed or not', '', false);
