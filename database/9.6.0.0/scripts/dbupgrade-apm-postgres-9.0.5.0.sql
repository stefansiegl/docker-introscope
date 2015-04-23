ALTER TABLE ts_biz_events ADD COLUMN ts_record_updated timestamp with time zone;

-- This statement always should be at the end to upgrade to 9.0.6.0 , please do not move it to some other place --
-- Updating database version from 9.0.5.0 to 9.0.6.0

update ts_domains set ts_db_versions='9.0.6.0';
