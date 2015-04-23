-- upgrade database from 4.1.0 to 4.1.1
-- Added new CEM Incident Analyst Role
insert into ts_roles (ts_id, version_info, ts_name, ts_soft_delete) values (4, 1, 'ROLE_TRIAGE_OPERATOR', FALSE);

-- Updating database version
update ts_domains set ts_db_versions='4.1.1';
