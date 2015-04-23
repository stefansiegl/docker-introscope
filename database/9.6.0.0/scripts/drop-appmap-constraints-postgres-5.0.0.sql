ALTER TABLE agent DROP CONSTRAINT application_sever_id_fkey; 
ALTER TABLE owner DROP CONSTRAINT  parent_id_fkey; 
ALTER TABLE vertex  DROP CONSTRAINT application_server_id_fkey;
ALTER TABLE vertex  DROP CONSTRAINT vertex_type_id_fkey;
ALTER TABLE vertex  DROP CONSTRAINT vertex_uniquekey;
ALTER TABLE vertex DROP CONSTRAINT  parent_id_fkey;
ALTER TABLE metric_path	DROP CONSTRAINT vertex_id_fkey; 
ALTER TABLE edge DROP CONSTRAINT head_vertex_id_fkey; 
ALTER TABLE edge DROP CONSTRAINT owner_id_fkey; 
ALTER TABLE edge DROP CONSTRAINT head_owner_id_fkey; 
ALTER TABLE edge DROP CONSTRAINT tail_owner_id_fkey;       
ALTER TABLE edge DROP CONSTRAINT tail_vertex_id_fkey;     

      
      
      

