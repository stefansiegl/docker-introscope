-- ts_transets
ALTER TABLE ts_transets ADD COLUMN ts_iscp_agnt_mtr_all_comp smallint NOT NULL DEFAULT 0;

--ts_tran_comp_details
ALTER TABLE ts_tran_comp_details ADD COLUMN ts_trantrace_guid character varying(200);
ALTER TABLE ts_tran_comp_details ADD COLUMN ts_agent_name character varying(200);
ALTER TABLE ts_tran_comp_details ADD COLUMN ts_agent_process character varying(200);
ALTER TABLE ts_tran_comp_details ADD COLUMN ts_agent_host character varying(200);
ALTER TABLE ts_tran_comp_details ADD COLUMN ts_has_tran_trace boolean NOT NULL DEFAULT false;

create index ts_tran_comp_dtls_TTGuidIdx on ts_tran_comp_details (ts_trantrace_guid);

-- left out of 9.0.7.2 upgrade script
update ts_hourly_aggregation_log set ts_stats_date=date_trunc('hour',ts_start_time) - interval '1 hour' where ts_stats_date is null;
