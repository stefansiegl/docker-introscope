-- This file updates the sequences used for the
-- Primary Key generation of the tables

SELECT setval('apm_agent_id_seq', (select max(id) from apm_agent));

SELECT setval('apm_owner_id_seq', (select max(id) from apm_owner));

SELECT setval('apm_vertex_type_id_seq', (select max(id) from apm_vertex_type));

SELECT setval('apm_vertex_id_seq', (select max(id) from apm_vertex));

SELECT setval('apm_metric_path_id_seq', (select max(id) from apm_metric_path));

SELECT setval('apm_edge_id_seq', (select max(id) from apm_edge));

