-- upgrade database from 3.3.1 to 3.3.2

-- increasing the size of the column ts_object_key of the ts_audit_records table
ALTER TABLE ts_audit_records ALTER COLUMN ts_object_key TYPE varchar(1000);

-- Updating database version
update ts_domains set ts_db_versions='3.3.2';
