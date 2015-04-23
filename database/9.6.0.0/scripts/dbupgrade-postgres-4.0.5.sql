-- upgrade database from 4.0.5 to 4.0.6

-- add new meta key for all tran trace comps
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (21, 'Introscope', 'IntroscopeTranTrace', 1, false, false, 1);

-- Updating database version
update ts_domains set ts_db_versions='4.0.6';
