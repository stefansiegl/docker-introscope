update ts_settings set ts_value='' where ts_key = 'email.smtpServer.hostname';
update tang_config set ts_value='' where ts_key = 'email.smtpServer';
update ts_operators set ts_email_address='';
update ts_report_defs set ts_scheduled=FALSE;
update ts_report_def_param_values set ts_value='' where ts_value like '%@%';
