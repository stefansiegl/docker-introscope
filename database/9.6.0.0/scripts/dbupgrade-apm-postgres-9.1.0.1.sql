-- Updating database version from 9.1.0.1 to 9.1.1.0

ALTER TABLE ts_entity ALTER COLUMN ts_port TYPE integer;

ALTER TABLE ts_entity
	ADD CONSTRAINT ts_entity_ts_port_check CHECK (0 < ts_port and ts_port < 65536);

ALTER TABLE ts_entity ADD COLUMN ts_local_ip_address numeric(39,0);
UPDATE ts_entity SET ts_local_ip_address = ts_ip_address;
ALTER TABLE ts_entity ALTER COLUMN ts_local_ip_address SET NOT NULL;

ALTER TABLE ts_entity ADD COLUMN ts_local_ip_address_type smallint;
UPDATE ts_entity SET ts_local_ip_address_type = ts_ip_address_type;
ALTER TABLE ts_entity ALTER COLUMN ts_local_ip_address_type SET NOT NULL;

ALTER TABLE apm_vertex ALTER COLUMN name TYPE varchar(2000);

ALTER TABLE ts_monitors ADD COLUMN ts_sm_host_config varchar(200) default 'smhostconfig';

ALTER TABLE ts_sm_groups ADD COLUMN ts_apiversion varchar(3) default '4' not null;

ALTER TABLE ts_sm_policy_servers ADD COLUMN ts_user_name varchar(200) default 'registerAdmin' not null;

ALTER TABLE ts_sm_policy_servers ADD COLUMN ts_password varchar(1000) default '';

DELETE FROM tang_event_types WHERE ts_id = 30 or ts_id = 31;
