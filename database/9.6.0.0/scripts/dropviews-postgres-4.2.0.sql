-- drop static views

DROP AGGREGATE array_accumulate(int);
DROP FUNCTION format_ip_address(int8);

drop view view_biz_event_metadata; 
drop view view_defect_app_server_time; 
drop view view_defect_brta_time; 
drop view view_defect_slowest_lowest_comp_time; 
drop view view_defect_slowest_lowest_back_comp_time; 
drop view TranSetGroupSlaPerformanceTimeSlaView;
drop view UserGroupSlaPerformanceTimeSlaView;
