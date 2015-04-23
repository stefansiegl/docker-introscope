-- update database from 4.2.1 to 4.2.2

-- improve login processing performance
create index ts_user_logins_map_NameIndex on ts_user_logins_map (ts_login_name);
create index ts_user_sessions_map_InterimSessionIdIndex on ts_user_sessions_map (ts_interim_session_id);
create index ts_user_sessions_map_SessionIdIndex on ts_user_sessions_map (ts_session_id);

-- Updating database version
update ts_domains set ts_db_versions='4.2.2.0';

