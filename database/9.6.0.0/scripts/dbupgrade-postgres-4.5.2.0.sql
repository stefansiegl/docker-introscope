-- update database from 4.5.2.0 to 4.5.3.0

-- insert default settings for send email whenincident occurs

insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1026, 1, 'email.bizEvent.sendEmailOnOpen', 'false', 'Flag to indicate if email should be sent when an incident is opened', 'false', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1027, 1, 'email.bizEvent.fromAddress', 'support@myCompany.com', 'From: address to be used from which email to be sent', 'wily-cemadmin@myCompany.com', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1028, 1, 'email.bizEvent.fromName', 'Wily CEM Admin', 'From: Name to be used to email bizEvent status', 'wily-cemadmin', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1029, 1, 'email.bizEvent.subject', 'Wily CEM bizEvent Mail', 'Text to be used as subject', 'wily-cemadmin bizEvent Mail', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1030, 1, 'email.bizEvent.message', 'This email has been sent to you by Wily CEM bizEvent Engine', 'Text to be used as body', 'This email has been sent to you by Wily CEM bizEvent Engine', false);
insert into ts_settings(ts_id, version_info, ts_key, ts_value, ts_description, ts_default, ts_soft_delete) values (1031, 1, 'email.bizEvent.toAddress', '', 'comma seperated list of recipients', '', false);

alter table ts_impact_settings add column ts_email_enabled boolean default false;
alter table ts_impact_settings add column ts_fromName character varying(1024) default null;
alter table ts_impact_settings add column ts_fromAddress character varying(200) default null;
alter table ts_impact_settings add column ts_toAddress character varying(200) default null;
alter table ts_impact_settings add column ts_subject character varying(10485) default null;
alter table ts_impact_settings add column ts_message character varying(10485760) default null;


-- Updating database version
update ts_domains set ts_db_versions='4.5.3.0';
