-- upgrade database from 3.2.0 to 3.2.1

-- add indexes (see bug 434)
create index ts_user_logins_map_UserIndex on ts_user_logins_map (ts_user_id);
create index ts_usergroup_users_map_UserGroupIndex on ts_usergroup_users_map(ts_usergroup_id);
create index ts_usergroup_users_map_UserIncarnationIndex on ts_usergroup_users_map(ts_user_incarnation_id);

\echo Updating database version
update ts_domains set ts_db_versions='3.2.1';
