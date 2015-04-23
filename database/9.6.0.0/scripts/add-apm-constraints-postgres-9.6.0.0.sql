--apm_agent's constraints
ALTER TABLE apm_agent  
	ADD CONSTRAINT apm_agent_unique UNIQUE(name,host_name,process_name);
	
--apm_edge's constraints	
ALTER TABLE apm_edge      
	  ADD CONSTRAINT apm_tail_vertex_id_fkey FOREIGN KEY (tail_vertex_id)
	      REFERENCES apm_vertex (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;   
ALTER TABLE apm_edge      
	  ADD CONSTRAINT apm_edge_type_check CHECK(type='RR' or type='RQ' or type='RS');
ALTER TABLE apm_edge      
	  ADD CONSTRAINT apm_owner_id_fkey FOREIGN KEY (owner_id)
	      REFERENCES apm_owner (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE apm_edge      
	  ADD CONSTRAINT apm_head_owner_id_fkey FOREIGN KEY (head_owner_id)
	      REFERENCES apm_owner (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE apm_edge      
	  ADD CONSTRAINT apm_tail_owner_id_fkey FOREIGN KEY (tail_owner_id)
	      REFERENCES apm_owner (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE apm_edge
	 ADD CONSTRAINT apm_head_vertex_id_fkey FOREIGN KEY (head_vertex_id)
	      REFERENCES apm_vertex (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;

--apm_metric_path's constraints	      
ALTER TABLE apm_metric_path
	ADD CONSTRAINT apm_vertex_id_fkey FOREIGN KEY (vertex_id)
      REFERENCES apm_vertex (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;      

--apm_owner's constraints
ALTER TABLE apm_owner
	 ADD CONSTRAINT apm_owner_type_check CHECK(type='App' or type='BTC');

ALTER TABLE apm_owner	 
	ADD CONSTRAINT apm_owner_unique UNIQUE(name,type);	 	      
	
--apm_vertex's constraints	

ALTER TABLE apm_vertex  
	ADD CONSTRAINT apm_agent_id_fkey FOREIGN KEY (agent_id)
      		REFERENCES apm_agent (id) MATCH SIMPLE
      		ON UPDATE NO ACTION ON DELETE SET NULL;
ALTER TABLE apm_vertex       
    ADD CONSTRAINT apm_vertex_type_id_fkey FOREIGN KEY (vertex_type_id)
      REFERENCES apm_vertex_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE apm_vertex       
    ADD CONSTRAINT apm_vertex_abstraction_level_check CHECK(abstraction_level='P' or abstraction_level='L');  
ALTER TABLE apm_vertex       
    ADD CONSTRAINT apm_vertex_unique UNIQUE(name,abstraction_level,hierarchy_level,agent_id,vertex_type_id);        
ALTER TABLE apm_vertex               
    ADD CONSTRAINT  apm_parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES apm_vertex (id) MATCH SIMPLE;     
      
--apm_vertex_type's constraints       
ALTER TABLE apm_vertex_type       
    ADD CONSTRAINT apm_vertex_type_unique UNIQUE(name);        
      
--apm_vertex_logical_equivalence's constraints	      
ALTER TABLE apm_vertex_logical_equivalence
	 ADD CONSTRAINT apm_from_vertex_id_fkey FOREIGN KEY (from_vertex_id)
	      REFERENCES apm_vertex (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE apm_vertex_logical_equivalence      
	  ADD CONSTRAINT apm_to_vertex_id_fkey FOREIGN KEY (to_vertex_id)
	      REFERENCES apm_vertex (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;      
	      
	      

      
      
      

