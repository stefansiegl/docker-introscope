-- upgrade database from 4.0.9 to 4.0.10

--bug fix 1597 - adding indexes to ts_biz_events table
create index ts_biz_events_TransetIncarnationIdIndex on ts_biz_events (ts_transet_incarnation_id);
create index ts_biz_events_TransetIdIndex on ts_biz_events (ts_transet_id);

-- Updating database version
update ts_domains set ts_db_versions='4.0.10';
