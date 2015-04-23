-- index names are of the form: <table name>_<index name>
CREATE INDEX apm_agent_name_index ON apm_agent(name);
CREATE INDEX apm_agent_unique_index ON apm_agent(name,host_name,process_name);
CREATE INDEX apm_edge_unique_index ON apm_edge(owner_id,head_vertex_id,tail_vertex_id,tail_owner_id,head_owner_id);
CREATE INDEX apm_edge_owner_index ON apm_edge(owner_id);
CREATE INDEX apm_edge_head_vertex_index ON apm_edge(head_vertex_id);
CREATE INDEX apm_edge_tail_vertex_index ON apm_edge(tail_vertex_id);
CREATE INDEX apm_owner_name_index ON apm_owner(name);
CREATE INDEX apm_owner_uniue_index ON apm_owner(name,type);
CREATE INDEX apm_owner_type_index ON apm_owner(type);
CREATE INDEX apm_owner_transaction_id_index ON apm_owner(transaction_id);
CREATE INDEX apm_vertex_name_index ON apm_vertex(name);
CREATE INDEX apm_vertex_unique_index ON apm_vertex(name, abstraction_level, hierarchy_level, vertex_type_id,agent_id);
CREATE INDEX apm_vertex_typename_index ON apm_vertex_type(name);
CREATE INDEX apm_metric_path_vertex_id_indx ON apm_metric_path(vertex_id);
