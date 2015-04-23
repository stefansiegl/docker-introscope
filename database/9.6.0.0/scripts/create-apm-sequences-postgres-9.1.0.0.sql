-- This file creates the sequences required for the 
-- Primary Key generation of the tables

-- CREATE SEQUENCE agent_id_seq;
ALTER SEQUENCE apm_agent_id_seq OWNED BY apm_agent.id;
ALTER TABLE apm_agent ALTER COLUMN id SET DEFAULT nextval('apm_agent_id_seq');

-- CREATE SEQUENCE owner_id_seq;
ALTER SEQUENCE apm_owner_id_seq OWNED BY apm_owner.id;
ALTER TABLE apm_owner ALTER COLUMN id SET DEFAULT nextval('apm_owner_id_seq');


-- CREATE SEQUENCE vertex_type_id_seq;
ALTER SEQUENCE apm_vertex_type_id_seq OWNED BY apm_vertex_type.id;
ALTER TABLE apm_vertex_type ALTER COLUMN id SET DEFAULT nextval('apm_vertex_type_id_seq');


-- CREATE SEQUENCE vertex_id_seq;
ALTER SEQUENCE apm_vertex_id_seq OWNED BY apm_vertex.id;
ALTER TABLE apm_vertex ALTER COLUMN id SET DEFAULT nextval('apm_vertex_id_seq');

-- CREATE SEQUENCE metric_path_id_seq;
ALTER SEQUENCE apm_metric_path_id_seq OWNED BY apm_metric_path.id;
ALTER TABLE apm_metric_path ALTER COLUMN id SET DEFAULT nextval('apm_metric_path_id_seq');

-- CREATE SEQUENCE edge_id_seq;
ALTER SEQUENCE apm_edge_id_seq OWNED BY apm_edge.id;
ALTER TABLE apm_edge ALTER COLUMN id SET DEFAULT nextval('apm_edge_id_seq');
