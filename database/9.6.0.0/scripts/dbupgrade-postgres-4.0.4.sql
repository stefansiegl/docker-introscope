-- upgrade database from 4.0.4 to 4.0.5

-- add evidence on open columns
ALTER TABLE ts_biz_events ADD COLUMN ts_evidence_on_open varchar(200);

-- Updating database version
update ts_domains set ts_db_versions='4.0.5';
