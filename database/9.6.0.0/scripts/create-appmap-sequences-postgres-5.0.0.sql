-- This file creates the sequences required for the 
-- Primary Key generation of the tables
	
--CREATE SEQUENCE application_server_id_seq;
ALTER SEQUENCE application_server_id_seq OWNED BY application_server.id;
ALTER TABLE application_server ALTER COLUMN id SET DEFAULT nextval('application_server_id_seq');

-- CREATE SEQUENCE agent_id_seq;
ALTER SEQUENCE agent_id_seq OWNED BY agent.id;
ALTER TABLE agent ALTER COLUMN id SET DEFAULT nextval('agent_id_seq');

-- CREATE SEQUENCE owner_id_seq;
ALTER SEQUENCE owner_id_seq OWNED BY owner.id;
ALTER TABLE owner ALTER COLUMN id SET DEFAULT nextval('owner_id_seq');


-- CREATE SEQUENCE vertex_type_id_seq;
ALTER SEQUENCE vertex_type_id_seq OWNED BY vertex_type.id;
ALTER TABLE vertex_type ALTER COLUMN id SET DEFAULT nextval('vertex_type_id_seq');


-- CREATE SEQUENCE vertex_id_seq;
ALTER SEQUENCE vertex_id_seq OWNED BY vertex.id;
ALTER TABLE vertex ALTER COLUMN id SET DEFAULT nextval('vertex_id_seq');

-- CREATE SEQUENCE metric_path_id_seq;
ALTER SEQUENCE metric_path_id_seq OWNED BY metric_path.id;
ALTER TABLE metric_path ALTER COLUMN id SET DEFAULT nextval('metric_path_id_seq');

-- CREATE SEQUENCE edge_id_seq;
ALTER SEQUENCE edge_id_seq OWNED BY edge.id;
ALTER TABLE edge ALTER COLUMN id SET DEFAULT nextval('edge_id_seq');
