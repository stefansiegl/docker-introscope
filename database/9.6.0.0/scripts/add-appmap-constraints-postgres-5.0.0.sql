ALTER TABLE agent
      ADD CONSTRAINT application_sever_id_fkey FOREIGN KEY (application_server_id)
      	REFERENCES application_server (id) MATCH SIMPLE
      	ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE owner  
	ADD CONSTRAINT  parent_id_fkey FOREIGN KEY (parent_id)
	  REFERENCES owner (id) MATCH SIMPLE;
      
ALTER TABLE vertex  
	ADD CONSTRAINT application_server_id_fkey FOREIGN KEY (application_server_id)
      		REFERENCES application_server (id) MATCH SIMPLE
      		ON UPDATE NO ACTION ON DELETE SET NULL;

ALTER TABLE vertex       
    ADD CONSTRAINT vertex_type_id_fkey FOREIGN KEY (vertex_type_id)
      REFERENCES vertex_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;
      
ALTER TABLE vertex             
  ADD CONSTRAINT vertex_uniquekey UNIQUE (unique_id);
  
ALTER TABLE vertex               
    ADD CONSTRAINT  parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES vertex (id) MATCH SIMPLE;      
      
ALTER TABLE metric_path
	ADD CONSTRAINT vertex_id_fkey FOREIGN KEY (vertex_id)
      REFERENCES vertex (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;      

ALTER TABLE edge
	 ADD CONSTRAINT head_vertex_id_fkey FOREIGN KEY (head_vertex_id)
	      REFERENCES vertex (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE edge      
	  ADD CONSTRAINT owner_id_fkey FOREIGN KEY (owner_id)
	      REFERENCES owner (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE edge      
	  ADD CONSTRAINT head_owner_id_fkey FOREIGN KEY (owner_id)
	      REFERENCES owner (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE edge      
	  ADD CONSTRAINT tail_owner_id_fkey FOREIGN KEY (owner_id)
	      REFERENCES owner (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;      
ALTER TABLE edge      
	  ADD CONSTRAINT tail_vertex_id_fkey FOREIGN KEY (tail_vertex_id)
	      REFERENCES vertex (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE CASCADE;      

      
      
      

