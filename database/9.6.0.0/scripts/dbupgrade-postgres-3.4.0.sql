-- upgrade database from 3.4.0 to 3.4.1

-- bug 982
alter table ts_usergroup_id_parameters drop column ts_description;
alter table ts_usergroup_id_parameters alter column ts_name type varchar(20000);

-- create array accumulate function
create aggregate array_accumulate(basetype = int,
                          sfunc = array_append,
                          stype = int[],
                          initcond = '{}'
                         );

CREATE OR REPLACE FUNCTION format_ip_address(int8)
  RETURNS text AS
$BODY$
    select to_char(($1 >> 24) & 255, 'FM999') || '.' ||
           to_char(($1 >> 16) & 255, 'FM999') || '.' ||
           to_char(($1 >> 8)  & 255, 'FM999') || '.' ||
           to_char($1         & 255, 'FM999')
$BODY$
  LANGUAGE 'sql' IMMUTABLE STRICT;


insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (14, 'Introscope', 'appServerTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (15, 'Introscope', 'brtaTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (16, 'Introscope', 'slowestLowestComponent', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (17, 'Introscope', 'slowestLowestComponentTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (18, 'Introscope', 'slowestLowestBackendComponent', 1, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (19, 'Introscope', 'slowestLowestBackendComponentTime', 2, true, false, 1);
insert into ts_defect_meta_keys(ts_id, ts_source, ts_name, ts_value_type, ts_displayed, ts_soft_delete, version_info) values (20, 'Introscope', 'agentHost|agentProcess|agentName', 1, false, false, 1);

create or replace view view_defect_app_server_time as 
select ts_defect_id, CAST(ts_value as int) as time 
from ts_defect_meta_values m 
where m.ts_metakey_id=14;

create or replace view view_defect_brta_time as 
select ts_defect_id, CAST(ts_value as int) as time 
from ts_defect_meta_values m 
where m.ts_metakey_id=15;

create or replace view view_defect_slowest_lowest_comp_time as 
select ts_defect_id, CAST(ts_value as int) as time 
from ts_defect_meta_values m 
where m.ts_metakey_id=17;

create or replace view view_defect_slowest_lowest_back_comp_time as 
select ts_defect_id, CAST(ts_value as int) as time 
from ts_defect_meta_values m 
where m.ts_metakey_id=19;
  
CREATE OR REPLACE VIEW view_biz_event_defect_network_time_by_app_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, 
count(d.ts_id) AS count, 
min(d.ts_transaction_time - d.ts_data_center_time) AS min, 
max(d.ts_transaction_time - d.ts_data_center_time) AS max, 
avg(d.ts_transaction_time - d.ts_data_center_time) AS average, 
array_accumulate(d.ts_transaction_time - d.ts_data_center_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 20 
GROUP BY d.ts_biz_event_id, m.ts_value;
  
CREATE OR REPLACE VIEW view_biz_event_defect_network_time_by_web_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
format_ip_address(d.ts_server_ip_address) || '|' || d.ts_server_mac_address AS category, 
count(d.ts_id) AS count, 
min(d.ts_transaction_time - d.ts_data_center_time) AS min, 
max(d.ts_transaction_time - d.ts_data_center_time) AS max, 
avg(d.ts_transaction_time - d.ts_data_center_time) AS average, 
array_accumulate(d.ts_transaction_time - d.ts_data_center_time) AS time_array
FROM ts_defects d
WHERE d.ts_defect_type = 1
GROUP BY d.ts_biz_event_id, category;
  
CREATE OR REPLACE VIEW view_biz_event_defect_network_time_by_slowest_lowest_back_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, 
count(d.ts_id) AS count, 
min(d.ts_transaction_time - d.ts_data_center_time) AS min, 
max(d.ts_transaction_time - d.ts_data_center_time) AS max, 
avg(d.ts_transaction_time - d.ts_data_center_time) AS average, 
array_accumulate(d.ts_transaction_time - d.ts_data_center_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 18
GROUP BY d.ts_biz_event_id, m.ts_value;
  
  
CREATE OR REPLACE VIEW view_biz_event_defect_network_time_by_slowest_lowest_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, 
count(d.ts_id) AS count, 
min(d.ts_transaction_time - d.ts_data_center_time) AS min, 
max(d.ts_transaction_time - d.ts_data_center_time) AS max, 
avg(d.ts_transaction_time - d.ts_data_center_time) AS average, 
array_accumulate(d.ts_transaction_time - d.ts_data_center_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 16
GROUP BY d.ts_biz_event_id, m.ts_value;
  
CREATE OR REPLACE VIEW view_biz_event_defect_network_time_by_usergroup AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
g.ts_name AS category, count(d.ts_id) AS count, 
min(d.ts_transaction_time - d.ts_data_center_time) AS min, 
max(d.ts_transaction_time - d.ts_data_center_time) AS max, 
avg(d.ts_transaction_time - d.ts_data_center_time) AS average, 
array_accumulate(d.ts_transaction_time - d.ts_data_center_time) AS time_array
FROM ts_defects d, ts_users u, ts_user_def_groups g
WHERE u.ts_id = d.ts_user_id AND u.ts_userdef_group_id = g.ts_id AND d.ts_defect_type = 1
GROUP BY d.ts_biz_event_id, u.ts_userdef_group_id, g.ts_name;
  
CREATE OR REPLACE VIEW view_biz_event_defect_time_by_app_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_transaction_time) AS min, 
max(d.ts_transaction_time) AS max, 
avg(d.ts_transaction_time) AS average, 
array_accumulate(d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 20 
GROUP BY d.ts_biz_event_id, m.ts_value;
  
CREATE OR REPLACE VIEW view_biz_event_defect_time_by_web_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
format_ip_address(d.ts_server_ip_address) || '|' || d.ts_server_mac_address AS category, 
count(d.ts_id) AS count, 
min(d.ts_transaction_time) AS min, 
max(d.ts_transaction_time) AS max, 
avg(d.ts_transaction_time) AS average, 
array_accumulate(d.ts_transaction_time) AS time_array
FROM ts_defects d
WHERE d.ts_defect_type = 1
GROUP BY d.ts_biz_event_id, category;
  
  
CREATE OR REPLACE VIEW view_biz_event_defect_time_by_slowest_lowest_back_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_transaction_time) AS min, 
max(d.ts_transaction_time) AS max, 
avg(d.ts_transaction_time) AS average, 
array_accumulate(d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 18
GROUP BY d.ts_biz_event_id, m.ts_value;
  
CREATE OR REPLACE VIEW view_biz_event_defect_time_by_slowest_lowest_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, 
count(d.ts_id) AS count, 
min(d.ts_transaction_time) AS min, 
max(d.ts_transaction_time) AS max, 
avg(d.ts_transaction_time) AS average, 
array_accumulate(d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 16
GROUP BY d.ts_biz_event_id, m.ts_value;
  
CREATE OR REPLACE VIEW view_biz_event_defect_time_by_usergroup AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
g.ts_name AS category, 
count(d.ts_id) AS count, 
min(d.ts_transaction_time) AS min, 
max(d.ts_transaction_time) AS max, 
avg(d.ts_transaction_time) AS average, 
array_accumulate(d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_users u, ts_user_def_groups g
WHERE u.ts_id = d.ts_user_id AND u.ts_userdef_group_id = g.ts_id AND d.ts_defect_type = 1
GROUP BY d.ts_biz_event_id, u.ts_userdef_group_id, g.ts_name;

CREATE OR REPLACE VIEW view_biz_event_defect_time_by_user_agent AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_transaction_time) AS min, 
max(d.ts_transaction_time) AS max, 
avg(d.ts_transaction_time) AS average, 
array_accumulate(d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, ts_defect_meta_keys k
WHERE d.ts_id = m.ts_defect_id AND m.ts_metakey_id=k.ts_id
AND d.ts_defect_type = 1 AND k.ts_name = 'User-Agent'
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_network_time_by_user_agent AS 
SELECT d.ts_biz_event_id AS biz_event_id, 
m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_transaction_time - d.ts_data_center_time) AS min, 
max(d.ts_transaction_time - d.ts_data_center_time) AS max, 
avg(d.ts_transaction_time - d.ts_data_center_time) AS average, 
array_accumulate(d.ts_transaction_time - d.ts_data_center_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, ts_defect_meta_keys k
WHERE d.ts_id = m.ts_defect_id AND m.ts_metakey_id=k.ts_id
AND d.ts_defect_type = 1 AND k.ts_name = 'User-Agent'
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_app_time_by_app_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - b.time ) AS min, 
max(a.time - b.time ) AS max, 
avg(a.time - b.time ) AS average, 
array_accumulate(a.time - b.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, 
view_defect_app_server_time a, 
view_defect_slowest_lowest_comp_time b
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 20 
AND a.ts_defect_id=d.ts_id AND b.ts_defect_id=d.ts_id 
GROUP BY d.ts_biz_event_id, m.ts_value;


CREATE OR REPLACE VIEW view_biz_event_defect_app_time_by_web_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, format_ip_address(d.ts_server_ip_address) || '|' || d.ts_server_mac_address AS category, 
count(d.ts_id) AS count, 
min(a.time - b.time - c.time) AS min, 
max(a.time - b.time - c.time) AS max, 
avg(a.time - b.time - c.time) AS average, 
array_accumulate(a.time - b.time - c.time) AS time_array
FROM ts_defects d,
view_defect_app_server_time a, 
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_defect_type = 1 AND a.ts_defect_id=d.ts_id AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, category;

CREATE OR REPLACE VIEW view_biz_event_defect_app_time_by_slowest_lowest_back_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - b.time - c.time) AS min, 
max(a.time - b.time - c.time) AS max, 
avg(a.time - b.time - c.time) AS average, 
array_accumulate(a.time - b.time - c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_app_server_time a, 
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 18
AND a.ts_defect_id=d.ts_id AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_app_time_by_slowest_lowest_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - b.time - c.time) AS min, 
max(a.time - b.time - c.time) AS max, 
avg(a.time - b.time - c.time) AS average, 
array_accumulate(a.time - b.time - c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_app_server_time a, 
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 16
AND a.ts_defect_id=d.ts_id AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;


CREATE OR REPLACE VIEW view_biz_event_defect_app_time_by_user_agent AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - b.time - c.time) AS min, 
max(a.time - b.time - c.time) AS max, 
avg(a.time - b.time - c.time) AS average, 
array_accumulate(a.time - b.time - c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, ts_defect_meta_keys k,
view_defect_app_server_time a, 
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND m.ts_metakey_id = k.ts_id AND d.ts_defect_type = 1 AND k.ts_name='User-Agent'
AND a.ts_defect_id=d.ts_id AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_app_time_by_usergroup AS 
SELECT d.ts_biz_event_id AS biz_event_id, g.ts_name AS category, count(d.ts_id) AS count, 
min(a.time - b.time - c.time) AS min, 
max(a.time - b.time - c.time) AS max, 
avg(a.time - b.time - c.time) AS average, 
array_accumulate(a.time - b.time - c.time) AS time_array
FROM ts_defects d, ts_users u, ts_user_def_groups g,
view_defect_app_server_time a, 
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE u.ts_id = d.ts_user_id AND u.ts_userdef_group_id = g.ts_id AND d.ts_defect_type = 1
AND a.ts_defect_id=d.ts_id AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, u.ts_userdef_group_id, g.ts_name;

CREATE OR REPLACE VIEW view_biz_event_defect_logic_time_by_app_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(b.time - c.time) AS min, 
max(b.time - c.time) AS max, 
avg(b.time - c.time) AS average, 
array_accumulate(b.time - c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,  
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 20 
AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;


CREATE OR REPLACE VIEW view_biz_event_defect_logic_time_by_web_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, format_ip_address(d.ts_server_ip_address) || '|' || d.ts_server_mac_address AS category, 
count(d.ts_id) AS count, 
min(b.time - c.time) AS min, 
max(b.time - c.time) AS max, 
avg(b.time - c.time) AS average, 
array_accumulate(b.time - c.time) AS time_array
FROM ts_defects d,
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_defect_type = 1 AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, category;

CREATE OR REPLACE VIEW view_biz_event_defect_logic_time_by_slowest_lowest_back_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(b.time - c.time) AS min, 
max(b.time - c.time) AS max, 
avg(b.time - c.time) AS average, 
array_accumulate(b.time - c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 18
AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_logic_time_by_slowest_lowest_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(b.time - c.time) AS min, 
max(b.time - c.time) AS max, 
avg(b.time - c.time) AS average, 
array_accumulate(b.time - c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 16
AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_logic_time_by_user_agent AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(b.time - c.time) AS min, 
max(b.time - c.time) AS max, 
avg(b.time - c.time) AS average, 
array_accumulate(b.time - c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, ts_defect_meta_keys k,
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND m.ts_metakey_id = k.ts_id AND d.ts_defect_type = 1 AND k.ts_name='User-Agent'
AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_logic_time_by_usergroup AS 
SELECT d.ts_biz_event_id AS biz_event_id, g.ts_name AS category, count(d.ts_id) AS count, 
min(b.time - c.time) AS min, 
max(b.time - c.time) AS max, 
avg(b.time - c.time) AS average, 
array_accumulate(b.time - c.time) AS time_array
FROM ts_defects d, ts_users u, ts_user_def_groups g,
view_defect_slowest_lowest_comp_time b,
view_defect_slowest_lowest_back_comp_time c
WHERE u.ts_id = d.ts_user_id AND u.ts_userdef_group_id = g.ts_id AND d.ts_defect_type = 1
AND b.ts_defect_id=d.ts_id AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, u.ts_userdef_group_id, g.ts_name;

CREATE OR REPLACE VIEW view_biz_event_defect_backend_time_by_app_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(c.time) AS min, 
max(c.time) AS max, 
avg(c.time) AS average, 
array_accumulate(c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,  
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 20 
AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;


CREATE OR REPLACE VIEW view_biz_event_defect_backend_time_by_web_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, format_ip_address(d.ts_server_ip_address) || '|' || d.ts_server_mac_address AS category, 
count(d.ts_id) AS count, 
min(c.time) AS min, 
max(c.time) AS max, 
avg(c.time) AS average, 
array_accumulate(c.time) AS time_array
FROM ts_defects d,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_defect_type = 1  AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, category;

CREATE OR REPLACE VIEW view_biz_event_defect_backend_time_by_slowest_lowest_back_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(c.time) AS min, 
max(c.time) AS max, 
avg(c.time) AS average, 
array_accumulate(c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 18
AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_backend_time_by_slowest_lowest_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(c.time) AS min, 
max(c.time) AS max, 
avg(c.time) AS average, 
array_accumulate(c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 16
AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_backend_time_by_user_agent AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(c.time) AS min, 
max(c.time) AS max, 
avg(c.time) AS average, 
array_accumulate(c.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, ts_defect_meta_keys k,
view_defect_slowest_lowest_back_comp_time c
WHERE d.ts_id = m.ts_defect_id AND m.ts_metakey_id = k.ts_id AND d.ts_defect_type = 1 AND k.ts_name='User-Agent'
AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_backend_time_by_usergroup AS 
SELECT d.ts_biz_event_id AS biz_event_id, g.ts_name AS category, count(d.ts_id) AS count, 
min(c.time) AS min, 
max(c.time) AS max, 
avg(c.time) AS average, 
array_accumulate(c.time) AS time_array
FROM ts_defects d, ts_users u, ts_user_def_groups g,
view_defect_slowest_lowest_back_comp_time c
WHERE u.ts_id = d.ts_user_id AND u.ts_userdef_group_id = g.ts_id AND d.ts_defect_type = 1
AND c.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, u.ts_userdef_group_id, g.ts_name;

CREATE OR REPLACE VIEW view_biz_event_defect_web_time_by_app_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_data_center_time - a.time) AS min, 
max(d.ts_data_center_time - a.time) AS max, 
avg(d.ts_data_center_time - a.time) AS average, 
array_accumulate(d.ts_data_center_time - a.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,  
view_defect_app_server_time a
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 20 
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;


CREATE OR REPLACE VIEW view_biz_event_defect_web_time_by_web_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, format_ip_address(d.ts_server_ip_address) || '|' || d.ts_server_mac_address AS category, 
count(d.ts_id) AS count, 
min(d.ts_data_center_time - a.time) AS min, 
max(d.ts_data_center_time - a.time) AS max, 
avg(d.ts_data_center_time - a.time) AS average, 
array_accumulate(d.ts_data_center_time - a.time) AS time_array
FROM ts_defects d,
view_defect_app_server_time a
WHERE d.ts_defect_type = 1  AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, category;

CREATE OR REPLACE VIEW view_biz_event_defect_web_time_by_slowest_lowest_back_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_data_center_time - a.time) AS min, 
max(d.ts_data_center_time - a.time) AS max, 
avg(d.ts_data_center_time - a.time) AS average, 
array_accumulate(d.ts_data_center_time - a.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_app_server_time a
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 18
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_web_time_by_slowest_lowest_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_data_center_time - a.time) AS min, 
max(d.ts_data_center_time - a.time) AS max, 
avg(d.ts_data_center_time - a.time) AS average, 
array_accumulate(d.ts_data_center_time - a.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_app_server_time a
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 16
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_web_time_by_user_agent AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(d.ts_data_center_time - a.time) AS min, 
max(d.ts_data_center_time - a.time) AS max, 
avg(d.ts_data_center_time - a.time) AS average, 
array_accumulate(d.ts_data_center_time - a.time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, ts_defect_meta_keys k,
view_defect_app_server_time a
WHERE d.ts_id = m.ts_defect_id AND m.ts_metakey_id = k.ts_id AND d.ts_defect_type = 1 AND k.ts_name='User-Agent'
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_web_time_by_usergroup AS 
SELECT d.ts_biz_event_id AS biz_event_id, g.ts_name AS category, count(d.ts_id) AS count, 
min(d.ts_data_center_time - a.time) AS min, 
max(d.ts_data_center_time - a.time) AS max, 
avg(d.ts_data_center_time - a.time) AS average, 
array_accumulate(d.ts_data_center_time - a.time) AS time_array
FROM ts_defects d, ts_users u, ts_user_def_groups g,
view_defect_app_server_time a
WHERE u.ts_id = d.ts_user_id AND u.ts_userdef_group_id = g.ts_id AND d.ts_defect_type = 1
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, u.ts_userdef_group_id, g.ts_name;

CREATE OR REPLACE VIEW view_biz_event_defect_client_time_by_app_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - d.ts_transaction_time) AS min, 
max(a.time - d.ts_transaction_time) AS max, 
avg(a.time - d.ts_transaction_time) AS average, 
array_accumulate(a.time - d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,  
view_defect_brta_time a
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 20 
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;


CREATE OR REPLACE VIEW view_biz_event_defect_client_time_by_web_server AS 
SELECT d.ts_biz_event_id AS biz_event_id, format_ip_address(d.ts_server_ip_address) || '|' || d.ts_server_mac_address AS category, 
count(d.ts_id) AS count, 
min(a.time - d.ts_transaction_time) AS min, 
max(a.time - d.ts_transaction_time) AS max, 
avg(a.time - d.ts_transaction_time) AS average, 
array_accumulate(a.time - d.ts_transaction_time) AS time_array
FROM ts_defects d,
view_defect_brta_time a
WHERE d.ts_defect_type = 1  AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, category;

CREATE OR REPLACE VIEW view_biz_event_defect_client_time_by_slowest_lowest_back_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - d.ts_transaction_time) AS min, 
max(a.time - d.ts_transaction_time) AS max, 
avg(a.time - d.ts_transaction_time) AS average, 
array_accumulate(a.time - d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_brta_time a
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 18
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_client_time_by_slowest_lowest_comp AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - d.ts_transaction_time) AS min, 
max(a.time - d.ts_transaction_time) AS max, 
avg(a.time - d.ts_transaction_time) AS average, 
array_accumulate(a.time - d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m,
view_defect_brta_time a
WHERE d.ts_id = m.ts_defect_id AND d.ts_defect_type = 1 AND m.ts_metakey_id = 16
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_client_time_by_user_agent AS 
SELECT d.ts_biz_event_id AS biz_event_id, m.ts_value AS category, count(d.ts_id) AS count, 
min(a.time - d.ts_transaction_time) AS min, 
max(a.time - d.ts_transaction_time) AS max, 
avg(a.time - d.ts_transaction_time) AS average, 
array_accumulate(a.time - d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_defect_meta_values m, ts_defect_meta_keys k,
view_defect_brta_time a
WHERE d.ts_id = m.ts_defect_id AND m.ts_metakey_id = k.ts_id AND d.ts_defect_type = 1 AND k.ts_name='User-Agent'
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, m.ts_value;

CREATE OR REPLACE VIEW view_biz_event_defect_client_time_by_usergroup AS 
SELECT d.ts_biz_event_id AS biz_event_id, g.ts_name AS category, count(d.ts_id) AS count, 
min(a.time - d.ts_transaction_time) AS min, 
max(a.time - d.ts_transaction_time) AS max, 
avg(a.time - d.ts_transaction_time) AS average, 
array_accumulate(a.time - d.ts_transaction_time) AS time_array
FROM ts_defects d, ts_users u, ts_user_def_groups g,
view_defect_brta_time a
WHERE u.ts_id = d.ts_user_id AND u.ts_userdef_group_id = g.ts_id AND d.ts_defect_type = 1
AND a.ts_defect_id=d.ts_id
GROUP BY d.ts_biz_event_id, u.ts_userdef_group_id, g.ts_name;

-- add missing index
create index ts_transetgroup_transets_map_TranSetIncarnationIndex on ts_transetgroup_transets_map (ts_transet_incarnation_id);

-- Updating database version
update ts_domains set ts_db_versions='3.4.1';
