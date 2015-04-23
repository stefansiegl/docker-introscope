-- update database from 4.2.2 to 4.2.3

-- TT51279: Database upgrade scripts should include insert script for ipv6 address range
insert into ts_sm_web_servers(ts_id, ts_sm_group_id, ts_name, ts_from_ip_address, ts_to_ip_address, ts_ip_address_type, ts_port, ts_soft_delete, version_info) values(2, 1, 'Default SiteMinder Web Servers', 0, 340282366920938463463374607431768211455, 2, 0, false, 1);


-- Updating database version
update ts_domains set ts_db_versions='4.2.3.0';
