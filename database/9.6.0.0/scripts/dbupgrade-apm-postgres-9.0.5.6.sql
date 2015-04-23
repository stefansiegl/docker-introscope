ALTER TABLE ts_biz_events ADD COLUMN ts_record_updated timestamp with time zone;

-- Eliminate duplicates in 'ts_user_def_groups' and 'ts_user_groups' by renaming them.
-- They need to be eliminated in order to apply unique constraint on ts_name column.
-- We rename only soft deleted rows because we assume there will be no duplicates within
-- rows which are not soft deleted since CEM doesn't allow duplicates in these rows.
UPDATE ts_user_def_groups SET ts_name = ts_name || '_' || ts_id WHERE ts_soft_delete='1' 
AND ts_name IN (SELECT ts_name FROM ts_user_def_groups GROUP BY ts_name HAVING count(*) > 1);
UPDATE ts_user_groups SET ts_name = ts_name || '_' || ts_id WHERE ts_soft_delete='1' 
AND ts_name IN (SELECT ts_name FROM ts_user_groups GROUP BY ts_name HAVING count(*) > 1);

-- set unique constraints for 'ts_user_def_groups' and 'ts_user_group'
ALTER TABLE ts_user_def_groups ADD CONSTRAINT ts_user_def_groups_NameIdx UNIQUE(ts_name);
ALTER TABLE ts_user_groups ADD CONSTRAINT ts_user_groups_NameIdx UNIQUE(ts_name);

-- This statement always should be at the end to upgrade to 9.0.7.0 , please do not move it to some other place --
-- Updating database version

update ts_domains set ts_db_versions='9.0.7.0';
