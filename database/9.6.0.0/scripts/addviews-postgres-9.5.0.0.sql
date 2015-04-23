
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
 (SELECT b.ts_transet_group_id AS TranSetGroupId, a.ts_tran_time_sla AS TranTimeSla
  FROM ts_transets a, ts_transetgroup_transets_map b
  WHERE a.ts_incarnation_id = b.ts_transet_incarnation_id AND a.ts_tran_time_sla_inherited = false AND a.ts_tran_time_sla >= 0 AND a.ts_soft_delete = false)
  UNION ALL
 (SELECT d.ts_transet_group_id AS TranSetGroupId, e.ts_tran_time_sla AS TranTimeSla
  FROM ts_transets c, ts_transetgroup_transets_map d, ts_tran_def_groups e
  WHERE c.ts_incarnation_id = d.ts_transet_incarnation_id AND c.ts_trandef_group_id = e.ts_id AND e.ts_tran_time_sla_inherited = false AND c.ts_tran_time_sla_inherited = true AND e.ts_tran_time_sla >= 0 AND c.ts_soft_delete = false)
  UNION ALL
 (SELECT g.ts_transet_group_id AS TranSetGroupId, i.ts_tran_tran_time_sla AS TranTimeSla
  FROM ts_transets f, ts_transetgroup_transets_map g, ts_tran_def_groups h, ts_domains i
  WHERE f.ts_incarnation_id = g.ts_transet_incarnation_id AND f.ts_trandef_group_id = h.ts_id AND h.ts_tran_time_sla_inherited = true AND f.ts_tran_time_sla_inherited = true AND h.ts_domain_id = i.ts_id AND f.ts_soft_delete = false);

create or replace view UsGrpSlaPerfTimeSlaVw AS
  SELECT ts_id AS UserGroupId, ts_tran_time_sla AS TranTimeSla
  FROM ts_user_groups
  WHERE ts_tran_time_sla >= 0;
