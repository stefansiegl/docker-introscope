
--	purge_apm_data_function purges the data that is older than pruning_time_in_seconds + aging_time_in_seconds.

--	Core Logic:
--	1. Delete all the edges that qualifies for deletion i.e. update_date < current_timestamp - (pruning_time_in_seconds + aging_time_in_seconds).
--	2. Delete  vertices that are no longer referenced in Edge table.
--	3. Delete  owners that are no longer referenced in Edge table.


CREATE	OR REPLACE FUNCTION prune_apm_data(pruning_time_in_seconds bigint,aging_time_in_seconds bigint) RETURNS integer AS $$

DECLARE
    v_result_code integer := -1;	
    v_actual_active_data_period bigint;
    v_tm timestamp = now();
    v_cutt_off_date timestamp;
    v_off_set text := $1+$2 || ' seconds';
BEGIN

	
    --make sure to retain the active data for a period of atleast a 
    -- pruning_time_in_seconds + aging_time_in_seconds to avoid
    -- deleting the current data
    --validate the pruning_time_in_seconds.
    -- Note: Don't delete vertex types from apm_vertex_type table as these entities are considered eternal

    v_actual_active_data_period := pruning_time_in_seconds + aging_time_in_seconds;	
    
    IF v_actual_active_data_period <= 0 THEN
	RAISE EXCEPTION 'The actual active data period can not be less than %. Please change date',req_active_data_period;
    END IF;	
	
    -- All the time stamps(creation_date & update_date) stored in GMT, 
    -- so while comparing against them take current time in GMT
    select now() at time zone 'GMT' into v_tm;

    v_cutt_off_date := v_tm - v_off_set::interval;

    --RAISE NOTICE 'v_off_set : % ',v_off_set;
    RAISE NOTICE 'The purge_apm_data() function began with threshhold date   %.',v_cutt_off_date;

    --Delete all the edges whose update_date are older than cut_off_date.	
    DELETE FROM apm_edge where apm_edge.update_date < v_cutt_off_date ;
    -- Delete all the vertices that are still in apm_vertex table, but not referenced in 
    -- apm_edge table.
    DELETE FROM apm_vertex WHERE id IN 
          (SELECT id FROM apm_vertex EXCEPT 
            (SELECT distinct(head_vertex_id) FROM apm_edge UNION 
                SELECT distinct(tail_vertex_id) FROM apm_edge));
    -- Delete all the agents that are not referenced in apm_vertex table anymore.
    DELETE FROM apm_agent WHERE id IN 
          (SELECT id FROM apm_agent EXCEPT SELECT distinct(agent_id) FROM apm_vertex);
    
    -- Delete all the owners that are still in apm_owner table, but not referenced in 
    -- apm_edge table.
    DELETE FROM apm_owner WHERE id IN 
          (SELECT id FROM apm_owner EXCEPT 
              (SELECT distinct(owner_id) FROM apm_edge 
                UNION 
                SELECT distinct(head_owner_id) FROM apm_edge
                UNION 
                SELECT distinct(tail_owner_id) FROM apm_edge));
 
 RETURN v_result_code;
END;
$$ LANGUAGE plpgsql;
