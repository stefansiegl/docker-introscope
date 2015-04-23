-- drop static views

DROP AGGREGATE array_accumulate(int);
DROP FUNCTION format_ip_address(int8);

drop view vw_biz_event_metadata; 
drop view vw_defect_app_server_time; 
drop view vw_defect_brta_time; 
drop view vw_defect_slowlow_comptime; 
drop view vw_defect_slowlow_backcomptime; 
drop view TSGrpSlaPerfTimeSlaVw;
drop view UsGrpSlaPerfTimeSlaVw;
