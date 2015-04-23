-- upgrade database from 4.0.7 to 4.0.8

-- add new meta key for User-Agent aka Clinet Type
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (22, 'RequestHeader', 'User-Agent', 1, false, false, 1);

--change reference of meta values already created to this one.
update ts_defect_meta_values set ts_metakey_id=22 where ts_metakey_id in (select ts_id from ts_defect_meta_keys where ts_name='User-Agent' and ts_source='RequestHeader' and ts_id>1000);

-- finaly remove the old 'User-Agent' meta key
delete from ts_defect_meta_keys where ts_name='User-Agent' and ts_source='RequestHeader' and ts_id>1000;

-- enable any defectDefs that are  DEFECT_TYPE_MISSING_RESPONSE, DEFECT_TYPE_MISSING_SUB_PART, DEFECT_TYPE_PARTIAL_RESPONSE
update ts_defect_defs set ts_enabled=true where ts_type in (9,11,16);

-- Updating database version
update ts_domains set ts_db_versions='4.0.8';
