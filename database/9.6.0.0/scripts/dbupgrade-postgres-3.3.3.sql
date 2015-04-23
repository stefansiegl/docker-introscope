-- upgrade database from 3.3.3 to 3.3.4

-- fix bug 806 (year not set correctly when aggregating these tables at the beginning of a year)
update ts_stats_transet_all_daily set ts_year = extract(year from ts_interval_start_time), ts_month = extract(month from ts_interval_start_time)-1, ts_week=extract(week from ts_interval_start_time), ts_day=extract(day from ts_interval_start_time), ts_hour=extract(hour from ts_interval_start_time) where ts_year != extract(year from ts_interval_start_time);
update ts_stats_transet_all_interval set ts_year = extract(year from ts_interval_start_time), ts_month = extract(month from ts_interval_start_time)-1, ts_week=extract(week from ts_interval_start_time), ts_day=extract(day from ts_interval_start_time), ts_hour=extract(hour from ts_interval_start_time) where ts_year != extract(year from ts_interval_start_time);
update ts_stats_transet_all_monthly set ts_year = extract(year from ts_interval_start_time), ts_month = extract(month from ts_interval_start_time)-1, ts_week=extract(week from ts_interval_start_time), ts_day=extract(day from ts_interval_start_time), ts_hour=extract(hour from ts_interval_start_time) where ts_year != extract(year from ts_interval_start_time);
update ts_stats_transet_all_weekly set ts_year = extract(year from ts_interval_start_time), ts_month = extract(month from ts_interval_start_time)-1, ts_week=extract(week from ts_interval_start_time), ts_day=extract(day from ts_interval_start_time), ts_hour=extract(hour from ts_interval_start_time) where ts_year != extract(year from ts_interval_start_time);

-- fix bug 806 (use java months 0-11 not 1-12)
update ts_stats_transet_all_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_user_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_usergroup_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_all_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_user_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_all_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_user_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_usergroup_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_usergroup_monthly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;

update ts_stats_transet_all_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_user_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_usergroup_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_all_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_user_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_usergroup_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_all_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_user_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_usergroup_weekly set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;

update ts_stats_transet_all_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_usergroup_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_all_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_all_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_usergroup_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_user_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_user_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_usergroup_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_user_daily set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;

update ts_stats_transet_all_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_user_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transet_usergroup_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_usergroup_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_all_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_usergroup_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_all_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_transetgroup_user_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;
update ts_stats_tranunit_user_interval set ts_month=extract(month from ts_interval_start_time)-1 where ts_month != extract(month from ts_interval_start_time)-1;

-- fix bug 817 - reports with static views slow
drop view UserTrendPerformanceTimeViewYearly;
drop view UserTrendPerformanceTimeViewMonthly;
drop view UserTrendPerformanceTimeViewWeekly;
drop view UserTrendPerformanceTimeViewDaily;
drop view UserTrendPerformanceTimeViewToday;
drop view UserTrendPerformanceTimeViewHourly;
drop view UserTrendPerformanceAllTimeViewYearly;
drop view UserTrendPerformanceAllTimeViewMonthly;
drop view UserTrendPerformanceAllTimeViewWeekly;
drop view UserTrendPerformanceAllTimeViewDaily;
drop view UserTrendPerformanceAllTimeViewToday;
drop view UserTrendPerformanceAllTimeViewHourly;
drop view UserTrendPerformanceTranSetSuccessRateViewYearly;
drop view UserTrendPerformanceTranSetSuccessRateViewMonthly;
drop view UserTrendPerformanceTranSetSuccessRateViewWeekly;
drop view UserTrendPerformanceTranSetSuccessRateViewDaily;
drop view UserTrendPerformanceTranSetSuccessRateViewToday;
drop view UserTrendPerformanceTranSetSuccessRateViewHourly;
drop view UserTrendPerformanceSuccessRateViewYearly;
drop view UserTrendPerformanceSuccessRateViewMonthly;
drop view UserTrendPerformanceSuccessRateViewWeekly;
drop view UserTrendPerformanceSuccessRateViewDaily;
drop view UserTrendPerformanceSuccessRateViewToday;
drop view UserTrendPerformanceSuccessRateViewHourly;
drop view UserTrendPerformanceAllSuccessRateViewYearly;
drop view UserTrendPerformanceAllSuccessRateViewMonthly;
drop view UserTrendPerformanceAllSuccessRateViewWeekly;
drop view UserTrendPerformanceAllSuccessRateViewDaily;
drop view UserTrendPerformanceAllSuccessRateViewToday;
drop view UserTrendPerformanceAllSuccessRateViewHourly;
drop view UserGroupTrendPerformanceTimeViewYearly;
drop view UserGroupTrendPerformanceTimeViewMonthly;
drop view UserGroupTrendPerformanceTimeViewWeekly;
drop view UserGroupTrendPerformanceTimeViewDaily;
drop view UserGroupTrendPerformanceTimeViewToday;
drop view UserGroupTrendPerformanceTimeViewHourly;
drop view UserGroupTrendPerformanceAllTimeViewYearly;
drop view UserGroupTrendPerformanceAllTimeViewMonthly;
drop view UserGroupTrendPerformanceAllTimeViewWeekly;
drop view UserGroupTrendPerformanceAllTimeViewDaily;
drop view UserGroupTrendPerformanceAllTimeViewToday;
drop view UserGroupTrendPerformanceAllTimeViewHourly;
drop view UserGroupTrendPerformanceTranSetSuccessRateViewYearly;
drop view UserGroupTrendPerformanceTranSetSuccessRateViewMonthly;
drop view UserGroupTrendPerformanceTranSetSuccessRateViewWeekly;
drop view UserGroupTrendPerformanceTranSetSuccessRateViewDaily;
drop view UserGroupTrendPerformanceTranSetSuccessRateViewToday;
drop view UserGroupTrendPerformanceTranSetSuccessRateViewHourly;
drop view UserGroupTrendPerformanceSuccessRateViewYearly;
drop view UserGroupTrendPerformanceSuccessRateViewMonthly;
drop view UserGroupTrendPerformanceSuccessRateViewWeekly;
drop view UserGroupTrendPerformanceSuccessRateViewDaily;
drop view UserGroupTrendPerformanceSuccessRateViewToday;
drop view UserGroupTrendPerformanceSuccessRateViewHourly;
drop view UserGroupTrendPerformanceAllSuccessRateViewYearly;
drop view UserGroupTrendPerformanceAllSuccessRateViewMonthly;
drop view UserGroupTrendPerformanceAllSuccessRateViewWeekly;
drop view UserGroupTrendPerformanceAllSuccessRateViewDaily;
drop view UserGroupTrendPerformanceAllSuccessRateViewToday;
drop view UserGroupTrendPerformanceAllSuccessRateViewHourly;
drop view TranSetGroupTrendPerformanceTimeViewYearly;
drop view TranSetGroupTrendPerformanceTimeViewMonthly;
drop view TranSetGroupTrendPerformanceTimeViewWeekly;
drop view TranSetGroupTrendPerformanceTimeViewDaily;
drop view TranSetGroupTrendPerformanceTimeViewToday;
drop view TranSetGroupTrendPerformanceTimeViewHourly;
drop view TranSetGroupTrendPerformanceAllTimeViewYearly;
drop view TranSetGroupTrendPerformanceAllTimeViewMonthly;
drop view TranSetGroupTrendPerformanceAllTimeViewWeekly;
drop view TranSetGroupTrendPerformanceAllTimeViewDaily;
drop view TranSetGroupTrendPerformanceAllTimeViewToday;
drop view TranSetGroupTrendPerformanceAllTimeViewHourly;
drop view TranSetGroupTrendPerformanceSuccessRateViewYearly;
drop view TranSetGroupTrendPerformanceSuccessRateViewMonthly;
drop view TranSetGroupTrendPerformanceSuccessRateViewWeekly;
drop view TranSetGroupTrendPerformanceSuccessRateViewDaily;
drop view TranSetGroupTrendPerformanceSuccessRateViewToday;
drop view TranSetGroupTrendPerformanceSuccessRateViewHourly;
drop view TranSetGroupTrendPerformanceAllSuccessRateViewYearly;
drop view TranSetGroupTrendPerformanceAllSuccessRateViewMonthly;
drop view TranSetGroupTrendPerformanceAllSuccessRateViewWeekly;
drop view TranSetGroupTrendPerformanceAllSuccessRateViewDaily;
drop view TranSetGroupTrendPerformanceAllSuccessRateViewToday;
drop view TranSetGroupTrendPerformanceAllSuccessRateViewHourly;
drop view CorrelationalSlaDataViewYearly;
drop view CorrelationalSlaDataViewMonthly;
drop view CorrelationalSlaDataViewWeekly;
drop view CorrelationalSlaDataViewDaily;
drop view CorrelationalSlaDataViewToday;
drop view CorrelationalSlaDataViewHourly;
drop view UserSlaPerformanceTranSetTimeViewYearly;
drop view UserSlaPerformanceTranSetTimeViewMonthly;
drop view UserSlaPerformanceTranSetTimeViewWeekly;
drop view UserSlaPerformanceTranSetTimeViewDaily;
drop view UserSlaPerformanceTranSetTimeViewToday;
drop view UserSlaPerformanceTranSetTimeViewHourly;
drop view UserSlaPerformanceTimeViewYearly;
drop view UserSlaPerformanceTimeViewMonthly;
drop view UserSlaPerformanceTimeViewWeekly;
drop view UserSlaPerformanceTimeViewDaily;
drop view UserSlaPerformanceTimeViewToday;
drop view UserSlaPerformanceTimeViewHourly;
drop view UserSlaPerformanceAllTimeViewYearly;
drop view UserSlaPerformanceAllTimeViewMonthly;
drop view UserSlaPerformanceAllTimeViewWeekly;
drop view UserSlaPerformanceAllTimeViewDaily;
drop view UserSlaPerformanceAllTimeViewToday;
drop view UserSlaPerformanceAllTimeViewHourly;
drop view UserSlaPerformanceTranSetSuccessRateViewYearly;
drop view UserSlaPerformanceTranSetSuccessRateViewMonthly;
drop view UserSlaPerformanceTranSetSuccessRateViewWeekly;
drop view UserSlaPerformanceTranSetSuccessRateViewDaily;
drop view UserSlaPerformanceTranSetSuccessRateViewToday;
drop view UserSlaPerformanceTranSetSuccessRateViewHourly;
drop view UserSlaPerformanceSuccessRateViewYearly;
drop view UserSlaPerformanceSuccessRateViewMonthly;
drop view UserSlaPerformanceSuccessRateViewWeekly;
drop view UserSlaPerformanceSuccessRateViewDaily;
drop view UserSlaPerformanceSuccessRateViewToday;
drop view UserSlaPerformanceSuccessRateViewHourly;
drop view UserSlaPerformanceAllSuccessRateViewYearly;
drop view UserSlaPerformanceAllSuccessRateViewMonthly;
drop view UserSlaPerformanceAllSuccessRateViewWeekly;
drop view UserSlaPerformanceAllSuccessRateViewDaily;
drop view UserSlaPerformanceAllSuccessRateViewToday;
drop view UserSlaPerformanceAllSuccessRateViewHourly;
drop view UserGroupSlaPerformanceTranSetTimeViewYearly;
drop view UserGroupSlaPerformanceTranSetTimeViewMonthly;
drop view UserGroupSlaPerformanceTranSetTimeViewWeekly;
drop view UserGroupSlaPerformanceTranSetTimeViewDaily;
drop view UserGroupSlaPerformanceTranSetTimeViewToday;
drop view UserGroupSlaPerformanceTranSetTimeViewHourly;
drop view UserGroupSlaPerformanceTimeViewYearly;
drop view UserGroupSlaPerformanceTimeViewMonthly;
drop view UserGroupSlaPerformanceTimeViewWeekly;
drop view UserGroupSlaPerformanceTimeViewDaily;
drop view UserGroupSlaPerformanceTimeViewToday;
drop view UserGroupSlaPerformanceTimeViewHourly;
drop view UserGroupSlaPerformanceAllTimeViewYearly;
drop view UserGroupSlaPerformanceAllTimeViewMonthly;
drop view UserGroupSlaPerformanceAllTimeViewWeekly;
drop view UserGroupSlaPerformanceAllTimeViewDaily;
drop view UserGroupSlaPerformanceAllTimeViewToday;
drop view UserGroupSlaPerformanceAllTimeViewHourly;
drop view UserGroupSlaPerformanceTranSetSuccessRateViewYearly;
drop view UserGroupSlaPerformanceTranSetSuccessRateViewMonthly;
drop view UserGroupSlaPerformanceTranSetSuccessRateViewWeekly;
drop view UserGroupSlaPerformanceTranSetSuccessRateViewDaily;
drop view UserGroupSlaPerformanceTranSetSuccessRateViewToday;
drop view UserGroupSlaPerformanceTranSetSuccessRateViewHourly;
drop view UserGroupSlaPerformanceSuccessRateViewYearly;
drop view UserGroupSlaPerformanceSuccessRateViewMonthly;
drop view UserGroupSlaPerformanceSuccessRateViewWeekly;
drop view UserGroupSlaPerformanceSuccessRateViewDaily;
drop view UserGroupSlaPerformanceSuccessRateViewToday;
drop view UserGroupSlaPerformanceSuccessRateViewHourly;
drop view UserGroupSlaPerformanceAllSuccessRateViewYearly;
drop view UserGroupSlaPerformanceAllSuccessRateViewMonthly;
drop view UserGroupSlaPerformanceAllSuccessRateViewWeekly;
drop view UserGroupSlaPerformanceAllSuccessRateViewDaily;
drop view UserGroupSlaPerformanceAllSuccessRateViewToday;
drop view UserGroupSlaPerformanceAllSuccessRateViewHourly;
drop view TranUnitSlaPerformanceDataViewYearly;
drop view TranUnitSlaPerformanceDataViewMonthly;
drop view TranUnitSlaPerformanceDataViewWeekly;
drop view TranUnitSlaPerformanceDataViewDaily;
drop view TranUnitSlaPerformanceDataViewToday;
drop view TranUnitSlaPerformanceDataViewHourly;
drop view TranUnitSlaPerformanceAllDataViewYearly;
drop view TranUnitSlaPerformanceAllDataViewMonthly;
drop view TranUnitSlaPerformanceAllDataViewWeekly;
drop view TranUnitSlaPerformanceAllDataViewDaily;
drop view TranUnitSlaPerformanceAllDataViewToday;
drop view TranUnitSlaPerformanceAllDataViewHourly;
drop view TranSetUserSlaPerformanceDataViewYearly;
drop view TranSetUserSlaPerformanceDataViewMonthly;
drop view TranSetUserSlaPerformanceDataViewWeekly;
drop view TranSetUserSlaPerformanceDataViewDaily;
drop view TranSetUserSlaPerformanceDataViewToday;
drop view TranSetUserSlaPerformanceDataViewHourly;
drop view TranSetSlaPerformanceDataViewYearly;
drop view TranSetSlaPerformanceDataViewMonthly;
drop view TranSetSlaPerformanceDataViewWeekly;
drop view TranSetSlaPerformanceDataViewDaily;
drop view TranSetSlaPerformanceDataViewToday;
drop view TranSetSlaPerformanceDataViewHourly;
drop view TranSetSlaPerformanceAllDataViewYearly;
drop view TranSetSlaPerformanceAllDataViewMonthly;
drop view TranSetSlaPerformanceAllDataViewWeekly;
drop view TranSetSlaPerformanceAllDataViewDaily;
drop view TranSetSlaPerformanceAllDataViewToday;
drop view TranSetSlaPerformanceAllDataViewHourly;
drop view TranSetGroupSlaPerformanceTimeViewYearly;
drop view TranSetGroupSlaPerformanceTimeViewMonthly;
drop view TranSetGroupSlaPerformanceTimeViewWeekly;
drop view TranSetGroupSlaPerformanceTimeViewDaily;
drop view TranSetGroupSlaPerformanceTimeViewToday;
drop view TranSetGroupSlaPerformanceTimeViewHourly;
drop view TranSetGroupSlaPerformanceAllTimeViewYearly;
drop view TranSetGroupSlaPerformanceAllTimeViewMonthly;
drop view TranSetGroupSlaPerformanceAllTimeViewWeekly;
drop view TranSetGroupSlaPerformanceAllTimeViewDaily;
drop view TranSetGroupSlaPerformanceAllTimeViewToday;
drop view TranSetGroupSlaPerformanceAllTimeViewHourly;
drop view TranSetGroupSlaPerformanceSuccessRateViewYearly;
drop view TranSetGroupSlaPerformanceSuccessRateViewMonthly;
drop view TranSetGroupSlaPerformanceSuccessRateViewWeekly;
drop view TranSetGroupSlaPerformanceSuccessRateViewDaily;
drop view TranSetGroupSlaPerformanceSuccessRateViewToday;
drop view TranSetGroupSlaPerformanceSuccessRateViewHourly;
drop view TranSetGroupSlaPerformanceAllSuccessRateViewYearly;
drop view TranSetGroupSlaPerformanceAllSuccessRateViewMonthly;
drop view TranSetGroupSlaPerformanceAllSuccessRateViewWeekly;
drop view TranSetGroupSlaPerformanceAllSuccessRateViewDaily;
drop view TranSetGroupSlaPerformanceAllSuccessRateViewToday;
drop view TranSetGroupSlaPerformanceAllSuccessRateViewHourly;
drop view UserQualityTranSetStatsViewYearly;
drop view UserQualityTranSetStatsViewMonthly;
drop view UserQualityTranSetStatsViewWeekly;
drop view UserQualityTranSetStatsViewDaily;
drop view UserQualityTranSetStatsViewToday;
drop view UserQualityTranSetStatsViewHourly;
drop view UserQualityStatsViewYearly;
drop view UserQualityStatsViewMonthly;
drop view UserQualityStatsViewWeekly;
drop view UserQualityStatsViewDaily;
drop view UserQualityStatsViewToday;
drop view UserQualityStatsViewHourly;
drop view UserQualityAllStatsViewYearly;
drop view UserQualityAllStatsViewMonthly;
drop view UserQualityAllStatsViewWeekly;
drop view UserQualityAllStatsViewDaily;
drop view UserQualityAllStatsViewToday;
drop view UserQualityAllStatsViewHourly;
drop view UserPerformanceTranSetStatsViewYearly;
drop view UserPerformanceTranSetStatsViewMonthly;
drop view UserPerformanceTranSetStatsViewWeekly;
drop view UserPerformanceTranSetStatsViewDaily;
drop view UserPerformanceTranSetStatsViewToday;
drop view UserPerformanceTranSetStatsViewHourly;
drop view UserPerformanceStatsViewYearly;
drop view UserPerformanceStatsViewMonthly;
drop view UserPerformanceStatsViewWeekly;
drop view UserPerformanceStatsViewDaily;
drop view UserPerformanceStatsViewToday;
drop view UserPerformanceStatsViewHourly;
drop view UserPerformanceAllStatsViewYearly;
drop view UserPerformanceAllStatsViewMonthly;
drop view UserPerformanceAllStatsViewWeekly;
drop view UserPerformanceAllStatsViewDaily;
drop view UserPerformanceAllStatsViewToday;
drop view UserPerformanceAllStatsViewHourly;

-- fix bug 856 - menu missing
update ts_report_type_param_values set ts_value='tranSetGroupPerformanceReport.html' where ts_value='tranPerformanceReport.html';
update ts_report_type_param_values set ts_value='tranSetGroupQualityReport.html' where ts_value='tranQualityReport.html';
update ts_report_def_param_values set ts_value='tranSetGroupPerformanceReport.html' where ts_value='tranPerformanceReport.html';
update ts_report_def_param_values set ts_value='tranSetGroupQualityReport.html' where ts_value='tranQualityReport.html';

-- fix bug 857 - custom dates not working on trend reports
update ts_report_param_keys set ts_query_string_name='CurrentTimeframe' where ts_id=21;
update ts_report_param_keys set ts_query_string_name='PreviousTimeframe' where ts_id=22;
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (119,1,24,13,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (120,1,25,13,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (121,1,24,14,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (122,1,25,14,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (123,1,24,7,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (124,1,25,7,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (125,1,24,8,'',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (126,1,25,8,'',false);


-- Updating database version
update ts_domains set ts_db_versions='3.3.4';