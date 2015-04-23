-- update database from 4.5.3.0 to 4.5.4.0
-- This statement always should be at the end to upgrade to 5.0 , please do not move it to some other place --
-- Updating database version
update ts_domains set ts_db_versions='4.5.4.0';
