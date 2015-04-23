-- index names are of the form: <table name>_<index name>
CREATE INDEX application_server_name_index ON application_server(name);
CREATE INDEX agent_name_index ON agent(name);
CREATE INDEX owner_name_index ON owner(name);
CREATE INDEX vertex_name_index ON vertex(name);
CREATE INDEX vertex_typename_index ON vertex_type(name);
