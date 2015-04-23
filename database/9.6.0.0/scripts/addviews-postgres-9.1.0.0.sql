
-- create static views

create or replace view vw_biz_event_metadata as 
 select d.ts_biz_event_id, mv.ts_metakey_id, mv.ts_value, count(d.ts_id) AS ts_defect_count
 from ts_defects d, ts_defect_meta_values mv
 where d.ts_id = mv.ts_defect_id
 group by d.ts_biz_event_id, mv.ts_metakey_id, mv.ts_value;
    
create or replace view vw_defect_app_server_time as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=14;

create or replace view vw_defect_brta_time as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=15;

create or replace view vw_defect_slowlow_comptime as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=17;

create or replace view vw_defect_slowlow_backcomptime as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=19;
  

create or replace view TSGrpSlaPerfTimeSlaVw AS
  SELECT b.ts_transet_group_id AS TranSetGroupId, a.ts_tran_time_sla AS TranTimeSla
  FROM ts_transets a
  INNER JOIN ts_transetgroup_transets_map b ON b.ts_transet_id = a.ts_id
  WHERE a.ts_tran_time_sla >= 0;

create or replace view UsGrpSlaPerfTimeSlaVw AS
  SELECT ts_id AS UserGroupId, ts_tran_time_sla AS TranTimeSla
  FROM ts_user_groups
  WHERE ts_tran_time_sla >= 0;
