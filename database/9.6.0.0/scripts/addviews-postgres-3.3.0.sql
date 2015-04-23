-- create static views

create view  view_biz_event_metadata as 
	select d.ts_biz_event_id, mv.ts_metakey_id, mv.ts_value, count(d.ts_id) AS ts_defect_count
	from ts_defects d, ts_defect_meta_values mv
	where d.ts_id = mv.ts_defect_id
	group by d.ts_biz_event_id, mv.ts_metakey_id, mv.ts_value;

CREATE OR REPLACE VIEW TranSetGroupSlaPerformanceTimeSlaView AS
  SELECT b.ts_transet_group_id AS TranSetGroupId, a.ts_tran_time_sla AS TranTimeSla
  FROM ts_transets a
  INNER JOIN ts_transetgroup_transets_map b ON b.ts_transet_id = a.ts_id
  WHERE a.ts_tran_time_sla >= 0;

CREATE OR REPLACE VIEW UserGroupSlaPerformanceTimeSlaView AS
  SELECT ts_id AS UserGroupId, ts_tran_time_sla AS TranTimeSla
  FROM ts_user_groups
  WHERE ts_tran_time_sla >= 0;
