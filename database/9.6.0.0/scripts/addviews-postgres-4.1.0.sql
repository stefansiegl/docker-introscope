-- create functions

-- create array accumulate function
create aggregate array_accumulate(basetype = int,
                          sfunc = array_append,
                          stype = int[],
                          initcond = '{}'
                         );
                         
-- create format ip address function
CREATE OR REPLACE FUNCTION format_ip_address(int8)
  RETURNS text AS
$BODY$
    select to_char(($1 >> 24) & 255, 'FM999') || '.' ||
           to_char(($1 >> 16) & 255, 'FM999') || '.' ||
           to_char(($1 >> 8)  & 255, 'FM999') || '.' ||
           to_char($1         & 255, 'FM999')
$BODY$
  LANGUAGE 'sql' IMMUTABLE STRICT;

-- create static views

create or replace view view_biz_event_metadata as 
 select d.ts_biz_event_id, mv.ts_metakey_id, mv.ts_value, count(d.ts_id) AS ts_defect_count
 from ts_defects d, ts_defect_meta_values mv
 where d.ts_id = mv.ts_defect_id
 group by d.ts_biz_event_id, mv.ts_metakey_id, mv.ts_value;
    
create or replace view view_defect_app_server_time as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=14;

create or replace view view_defect_brta_time as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=15;

create or replace view view_defect_slowest_lowest_comp_time as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=17;

create or replace view view_defect_slowest_lowest_back_comp_time as 
 select ts_defect_id, CAST(ts_value as int) as time 
 from ts_defect_meta_values m 
 where m.ts_metakey_id=19;
  

CREATE OR REPLACE VIEW TranSetGroupSlaPerformanceTimeSlaView AS
  SELECT b.ts_transet_group_id AS TranSetGroupId, a.ts_tran_time_sla AS TranTimeSla
  FROM ts_transets a
  INNER JOIN ts_transetgroup_transets_map b ON b.ts_transet_id = a.ts_id
  WHERE a.ts_tran_time_sla >= 0;

CREATE OR REPLACE VIEW UserGroupSlaPerformanceTimeSlaView AS
  SELECT ts_id AS UserGroupId, ts_tran_time_sla AS TranTimeSla
  FROM ts_user_groups
  WHERE ts_tran_time_sla >= 0;
