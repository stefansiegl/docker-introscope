--Allows EM port value to be in the range of 1 to 65535. 
ALTER TABLE ts_entity ALTER COLUMN ts_port TYPE integer;

-- Defect 275712: Schema upgrade results error on upgrading APM 915 to 953 (Because of differences between 9.1 and 9.5 schemas 
-- with respect to ts_entity_ts_port_check constraint, we need to check if this constraint exists and if doesn’t it needs to be created)
SWITCH_DELIMITER_TO /;
CREATE OR REPLACE FUNCTION create_constraint_ts_port_check() RETURNS void AS $$
DECLARE
    counter int;
BEGIN
    SELECT count(*) INTO counter FROM pg_constraint WHERE conname = 'ts_entity_ts_port_check';
    IF counter < 1 THEN ALTER TABLE ts_entity ADD CONSTRAINT ts_entity_ts_port_check CHECK (0 < ts_port and ts_port < 65536);
    END IF;
END;
$$ LANGUAGE plpgsql;
/
SWITCH_DELIMITER_TO ;;
SELECT create_constraint_ts_port_check();
DROP FUNCTION create_constraint_ts_port_check();

--Defect 268835: Internal Application Error after moving BT from one BS to another
--AND Defect 250630: Average time SLA issue
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
