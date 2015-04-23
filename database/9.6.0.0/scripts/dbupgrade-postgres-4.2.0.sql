-- update database from 4.2.0 to 4.2.1

-- fix for bug 2000 (default app can be deleted)
update ts_apps set ts_soft_delete=false where ts_id=1;

-- allow non-literals in parameter names (bug 2190)
alter table ts_session_id_parameters add column ts_name_type int2 not null default 0;

-- TT 48439 invalid value in col ts_name_type of table ts_params
update ts_params set ts_name_type = 0 where ts_name_type = 1;

-- Updating database version
update ts_domains set ts_db_versions='4.2.1';

