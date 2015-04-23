--apm_agent's constraints
ALTER TABLE apm_agent  DROP CONSTRAINT apm_agent_unique;
--apm_edge's constraints
ALTER TABLE apm_edge DROP CONSTRAINT apm_head_vertex_id_fkey; 
ALTER TABLE apm_edge DROP CONSTRAINT apm_owner_id_fkey; 
ALTER TABLE apm_edge DROP CONSTRAINT apm_head_owner_id_fkey; 
ALTER TABLE apm_edge DROP CONSTRAINT apm_tail_owner_id_fkey;       
ALTER TABLE apm_edge DROP CONSTRAINT apm_tail_vertex_id_fkey;     
ALTER TABLE apm_edge DROP CONSTRAINT apm_edge_type_check;
--apm_metric_path's constraints
ALTER TABLE apm_metric_path	DROP CONSTRAINT apm_vertex_id_fkey;
--apm_owner's constraints
ALTER TABLE apm_owner DROP CONSTRAINT apm_owner_type_check;
ALTER TABLE apm_owner DROP CONSTRAINT apm_owner_unique;
--apm_vertex's constraints
ALTER TABLE apm_vertex  DROP CONSTRAINT apm_agent_id_fkey;
ALTER TABLE apm_vertex  DROP CONSTRAINT apm_vertex_type_id_fkey;
ALTER TABLE apm_vertex  DROP CONSTRAINT apm_vertex_unique;
ALTER TABLE apm_vertex DROP CONSTRAINT  apm_parent_id_fkey;
ALTER TABLE apm_vertex DROP CONSTRAINT apm_vertex_abstraction_level_check;      

--apm_vertex_logical_equivalence's constraints
ALTER TABLE apm_vertex_logical_equivalence DROP CONSTRAINT apm_from_vertex_id_fkey;
ALTER TABLE apm_vertex_logical_equivalence DROP CONSTRAINT apm_to_vertex_id_fkey;

-- drop a prune_apm_data function
DROP FUNCTION prune_apm_data(bigint,bigint);

 

      
      
      

