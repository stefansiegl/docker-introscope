-- upgrade database from 4.0.6 to 4.0.7

-- fix bug 1330 - user def group list page slow
create index ts_user_groups_DefGroupIndex on ts_user_groups(ts_userdef_group_id);

-- Updating database version
update ts_domains set ts_db_versions='4.0.7';
