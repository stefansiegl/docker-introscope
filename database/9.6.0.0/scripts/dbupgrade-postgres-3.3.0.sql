-- upgrade database from 3.3.0 to 3.3.1

-- fix bug 594: P/Q reports on some Custom Week dates don't come up
drop view TranSetGroupUsersViewHourly;
drop view TranSetGroupUsersViewToday;
drop view TranSetGroupUsersViewDaily;
drop view TranSetGroupUsersViewWeekly;
drop view TranSetGroupUsersViewMonthly;
drop view TranSetGroupUsersViewYearly;
drop view TranSetGroupPerformanceStatsViewHourly;
drop view TranSetGroupPerformanceStatsViewToday;
drop view TranSetGroupPerformanceStatsViewDaily;
drop view TranSetGroupPerformanceStatsViewWeekly;
drop view TranSetGroupPerformanceStatsViewMonthly;
drop view TranSetGroupPerformanceStatsViewYearly;
drop view TranSetGroupQualityStatsViewHourly;
drop view TranSetGroupQualityStatsViewToday;
drop view TranSetGroupQualityStatsViewDaily;
drop view TranSetGroupQualityStatsViewWeekly;
drop view TranSetGroupQualityStatsViewMonthly;
drop view TranSetGroupQualityStatsViewYearly;
drop view TranSetUsersViewHourly;
drop view TranSetUsersViewToday;
drop view TranSetUsersViewDaily;
drop view TranSetUsersViewWeekly;
drop view TranSetUsersViewMonthly;
drop view TranSetUsersViewYearly;
drop view TranSetPerformanceStatsViewHourly;
drop view TranSetPerformanceStatsViewToday;
drop view TranSetPerformanceStatsViewDaily;
drop view TranSetPerformanceStatsViewWeekly;
drop view TranSetPerformanceStatsViewMonthly;
drop view TranSetPerformanceStatsViewYearly;
drop view TranSetQualityStatsViewHourly;
drop view TranSetQualityStatsViewToday;
drop view TranSetQualityStatsViewDaily;
drop view TranSetQualityStatsViewWeekly;
drop view TranSetQualityStatsViewMonthly;
drop view TranSetQualityStatsViewYearly;
drop view TranUnitUsersViewHourly;
drop view TranUnitUsersViewToday;
drop view TranUnitUsersViewDaily;
drop view TranUnitUsersViewWeekly;
drop view TranUnitUsersViewMonthly;
drop view TranUnitUsersViewYearly;
drop view TranUnitPerformanceStatsViewHourly;
drop view TranUnitPerformanceStatsViewToday;
drop view TranUnitPerformanceStatsViewDaily;
drop view TranUnitPerformanceStatsViewWeekly;
drop view TranUnitPerformanceStatsViewMonthly;
drop view TranUnitPerformanceStatsViewYearly;
drop view TranUnitQualityStatsViewHourly;
drop view TranUnitQualityStatsViewToday;
drop view TranUnitQualityStatsViewDaily;
drop view TranUnitQualityStatsViewWeekly;
drop view TranUnitQualityStatsViewMonthly;
drop view TranUnitQualityStatsViewYearly;
drop view UserGroupAllUsersViewHourly;
drop view UserGroupAllUsersViewToday;
drop view UserGroupAllUsersViewDaily;
drop view UserGroupAllUsersViewWeekly;
drop view UserGroupAllUsersViewMonthly;
drop view UserGroupAllUsersViewYearly;
drop view UserGroupUsersViewHourly;
drop view UserGroupUsersViewToday;
drop view UserGroupUsersViewDaily;
drop view UserGroupUsersViewWeekly;
drop view UserGroupUsersViewMonthly;
drop view UserGroupUsersViewYearly;
drop view UserGroupTranSetUsersViewHourly;
drop view UserGroupTranSetUsersViewToday;
drop view UserGroupTranSetUsersViewDaily;
drop view UserGroupTranSetUsersViewWeekly;
drop view UserGroupTranSetUsersViewMonthly;
drop view UserGroupTranSetUsersViewYearly;
drop view UserGroupPerformanceAllStatsViewHourly;
drop view UserGroupPerformanceAllStatsViewToday;
drop view UserGroupPerformanceAllStatsViewDaily;
drop view UserGroupPerformanceAllStatsViewWeekly;
drop view UserGroupPerformanceAllStatsViewMonthly;
drop view UserGroupPerformanceAllStatsViewYearly;
drop view UserGroupPerformanceStatsViewHourly;
drop view UserGroupPerformanceStatsViewToday;
drop view UserGroupPerformanceStatsViewDaily;
drop view UserGroupPerformanceStatsViewWeekly;
drop view UserGroupPerformanceStatsViewMonthly;
drop view UserGroupPerformanceStatsViewYearly;
drop view UserGroupPerformanceTranSetStatsViewHourly;
drop view UserGroupPerformanceTranSetStatsViewToday;
drop view UserGroupPerformanceTranSetStatsViewDaily;
drop view UserGroupPerformanceTranSetStatsViewWeekly;
drop view UserGroupPerformanceTranSetStatsViewMonthly;
drop view UserGroupPerformanceTranSetStatsViewYearly;
drop view UserGroupQualityAllStatsViewHourly;
drop view UserGroupQualityAllStatsViewToday;
drop view UserGroupQualityAllStatsViewDaily;
drop view UserGroupQualityAllStatsViewWeekly;
drop view UserGroupQualityAllStatsViewMonthly;
drop view UserGroupQualityAllStatsViewYearly;
drop view UserGroupQualityStatsViewHourly;
drop view UserGroupQualityStatsViewToday;
drop view UserGroupQualityStatsViewDaily;
drop view UserGroupQualityStatsViewWeekly;
drop view UserGroupQualityStatsViewMonthly;
drop view UserGroupQualityStatsViewYearly;
drop view UserGroupQualityTranSetStatsViewHourly;
drop view UserGroupQualityTranSetStatsViewToday;
drop view UserGroupQualityTranSetStatsViewDaily;
drop view UserGroupQualityTranSetStatsViewWeekly;
drop view UserGroupQualityTranSetStatsViewMonthly;
drop view UserGroupQualityTranSetStatsViewYearly;

-- fix bug 646: remove SAP (dithering, dithering)
delete from ts_app_types where ts_name = 'SAP';

-- in at least 1 3.2 db, this is somehow "eTrust SiteMinder"
update ts_app_types set ts_name='Generic' where ts_id = 2 and ts_name != 'Generic';

-- fix bug 638: saving transet/tranunit P/Q reports doesn't work
insert into ts_report_types values (16, 1, 'TranSetPerformanceReport', false);
insert into ts_report_types values (17, 1, 'TranSetQualityReport', false);
insert into ts_report_types values (18, 1, 'TranUnitPerformanceReport', false);
insert into ts_report_types values (19, 1, 'TranUnitQualityReport', false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (67,1,1,16,'tranSetPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (68,1,17,16,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (69,1,20,16,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (70,1,1,17,'tranSetQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (71,1,17,17,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (72,1,20,17,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (73,1,1,18,'tranUnitPerformanceReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (74,1,17,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (75,1,18,18,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (76,1,20,18,'Today',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (77,1,1,19,'tranUnitQualityReport.html',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (78,1,17,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (79,1,18,19,'0',false);
insert into ts_report_type_param_values (ts_id,version_info,ts_param_key_id,ts_report_type_id,ts_value,ts_soft_delete) values (80,1,20,19,'Today',false);

-- fix bug 660: dashboard slow
create index ts_stats_transet_all_daily_YearIndex on ts_stats_transet_all_daily (ts_year);
create index ts_stats_transet_all_daily_MonthIndex on ts_stats_transet_all_daily (ts_month);
create index ts_stats_transet_all_daily_WeekIndex on ts_stats_transet_all_daily (ts_week);
create index ts_stats_transet_all_daily_DayIndex on ts_stats_transet_all_daily (ts_day);

create index ts_stats_transet_all_interval_YearIndex on ts_stats_transet_all_interval (ts_year);
create index ts_stats_transet_all_interval_MonthIndex on ts_stats_transet_all_interval (ts_month);
create index ts_stats_transet_all_interval_WeekIndex on ts_stats_transet_all_interval (ts_week);
create index ts_stats_transet_all_interval_DayIndex on ts_stats_transet_all_interval (ts_day);
create index ts_stats_transet_all_interval_HourIndex on ts_stats_transet_all_interval (ts_hour);

create index ts_stats_transet_all_monthly_YearIndex on ts_stats_transet_all_monthly (ts_year);
create index ts_stats_transet_all_monthly_MonthIndex on ts_stats_transet_all_monthly (ts_month);

create index ts_stats_transet_all_weekly_YearIndex on ts_stats_transet_all_weekly (ts_year);
create index ts_stats_transet_all_weekly_MonthIndex on ts_stats_transet_all_weekly (ts_month);
create index ts_stats_transet_all_weekly_WeekIndex on ts_stats_transet_all_weekly (ts_week);

create index ts_stats_transet_usergroup_daily_YearIndex on ts_stats_transet_usergroup_daily (ts_year);
create index ts_stats_transet_usergroup_daily_MonthIndex on ts_stats_transet_usergroup_daily (ts_month);
create index ts_stats_transet_usergroup_daily_WeekIndex on ts_stats_transet_usergroup_daily (ts_week);
create index ts_stats_transet_usergroup_daily_DayIndex on ts_stats_transet_usergroup_daily (ts_day);

create index ts_stats_transet_usergroup_interval_YearIndex on ts_stats_transet_usergroup_interval (ts_year);
create index ts_stats_transet_usergroup_interval_MonthIndex on ts_stats_transet_usergroup_interval (ts_month);
create index ts_stats_transet_usergroup_interval_WeekIndex on ts_stats_transet_usergroup_interval (ts_week);
create index ts_stats_transet_usergroup_interval_DayIndex on ts_stats_transet_usergroup_interval (ts_day);
create index ts_stats_transet_usergroup_interval_HourIndex on ts_stats_transet_usergroup_interval (ts_hour);

create index ts_stats_transet_usergroup_monthly_YearIndex on ts_stats_transet_usergroup_monthly (ts_year);
create index ts_stats_transet_usergroup_monthly_MonthIndex on ts_stats_transet_usergroup_monthly (ts_month);

create index ts_stats_transet_usergroup_weekly_YearIndex on ts_stats_transet_usergroup_weekly (ts_year);
create index ts_stats_transet_usergroup_weekly_MonthIndex on ts_stats_transet_usergroup_weekly (ts_month);
create index ts_stats_transet_usergroup_weekly_WeekIndex on ts_stats_transet_usergroup_weekly (ts_week);


create index ts_stats_transet_user_daily_YearIndex on ts_stats_transet_user_daily (ts_year);
create index ts_stats_transet_user_daily_MonthIndex on ts_stats_transet_user_daily (ts_month);
create index ts_stats_transet_user_daily_WeekIndex on ts_stats_transet_user_daily (ts_week);
create index ts_stats_transet_user_daily_DayIndex on ts_stats_transet_user_daily (ts_day);

create index ts_stats_transet_user_interval_YearIndex on ts_stats_transet_user_interval (ts_year);
create index ts_stats_transet_user_interval_MonthIndex on ts_stats_transet_user_interval (ts_month);
create index ts_stats_transet_user_interval_WeekIndex on ts_stats_transet_user_interval (ts_week);
create index ts_stats_transet_user_interval_DayIndex on ts_stats_transet_user_interval (ts_day);
create index ts_stats_transet_user_interval_HourIndex on ts_stats_transet_user_interval (ts_hour);

create index ts_stats_transet_user_monthly_YearIndex on ts_stats_transet_user_monthly (ts_year);
create index ts_stats_transet_user_monthly_MonthIndex on ts_stats_transet_user_monthly (ts_month);


create index ts_stats_transet_user_weekly_YearIndex on ts_stats_transet_user_weekly (ts_year);
create index ts_stats_transet_user_weekly_MonthIndex on ts_stats_transet_user_weekly (ts_month);
create index ts_stats_transet_user_weekly_WeekIndex on ts_stats_transet_user_weekly (ts_week);

create index ts_stats_transetgroup_all_daily_YearIndex on ts_stats_transetgroup_all_daily (ts_year);
create index ts_stats_transetgroup_all_daily_MonthIndex on ts_stats_transetgroup_all_daily (ts_month);
create index ts_stats_transetgroup_all_daily_WeekIndex on ts_stats_transetgroup_all_daily (ts_week);
create index ts_stats_transetgroup_all_daily_DayIndex on ts_stats_transetgroup_all_daily (ts_day);

create index ts_stats_transetgroup_all_interval_YearIndex on ts_stats_transetgroup_all_interval (ts_year);
create index ts_stats_transetgroup_all_interval_MonthIndex on ts_stats_transetgroup_all_interval (ts_month);
create index ts_stats_transetgroup_all_interval_WeekIndex on ts_stats_transetgroup_all_interval (ts_week);
create index ts_stats_transetgroup_all_interval_DayIndex on ts_stats_transetgroup_all_interval (ts_day);
create index ts_stats_transetgroup_all_interval_HourIndex on ts_stats_transetgroup_all_interval (ts_hour);

create index ts_stats_transetgroup_all_monthly_YearIndex on ts_stats_transetgroup_all_monthly (ts_year);
create index ts_stats_transetgroup_all_monthly_MonthIndex on ts_stats_transetgroup_all_monthly (ts_month);

create index ts_stats_transetgroup_all_weekly_YearIndex on ts_stats_transetgroup_all_weekly (ts_year);
create index ts_stats_transetgroup_all_weekly_MonthIndex on ts_stats_transetgroup_all_weekly (ts_month);
create index ts_stats_transetgroup_all_weekly_WeekIndex on ts_stats_transetgroup_all_weekly (ts_week);

create index ts_stats_transetgroup_usergroup_daily_YearIndex on ts_stats_transetgroup_usergroup_daily (ts_year);
create index ts_stats_transetgroup_usergroup_daily_MonthIndex on ts_stats_transetgroup_usergroup_daily (ts_month);
create index ts_stats_transetgroup_usergroup_daily_WeekIndex on ts_stats_transetgroup_usergroup_daily (ts_week);
create index ts_stats_transetgroup_usergroup_daily_DayIndex on ts_stats_transetgroup_usergroup_daily (ts_day);

create index ts_stats_transetgroup_usergroup_interval_YearIndex on ts_stats_transetgroup_usergroup_interval (ts_year);
create index ts_stats_transetgroup_usergroup_interval_MonthIndex on ts_stats_transetgroup_usergroup_interval (ts_month);
create index ts_stats_transetgroup_usergroup_interval_WeekIndex on ts_stats_transetgroup_usergroup_interval (ts_week);
create index ts_stats_transetgroup_usergroup_interval_DayIndex on ts_stats_transetgroup_usergroup_interval (ts_day);
create index ts_stats_transetgroup_usergroup_interval_HourIndex on ts_stats_transetgroup_usergroup_interval (ts_hour);

create index ts_stats_transetgroup_usergroup_monthly_YearIndex on ts_stats_transetgroup_usergroup_monthly (ts_year);
create index ts_stats_transetgroup_usergroup_monthly_MonthIndex on ts_stats_transetgroup_usergroup_monthly (ts_month);

create index ts_stats_transetgroup_usergroup_weekly_YearIndex on ts_stats_transetgroup_usergroup_weekly (ts_year);
create index ts_stats_transetgroup_usergroup_weekly_MonthIndex on ts_stats_transetgroup_usergroup_weekly (ts_month);
create index ts_stats_transetgroup_usergroup_weekly_WeekIndex on ts_stats_transetgroup_usergroup_weekly (ts_week);

create index ts_stats_transetgroup_user_daily_YearIndex on ts_stats_transetgroup_user_daily (ts_year);
create index ts_stats_transetgroup_user_daily_MonthIndex on ts_stats_transetgroup_user_daily (ts_month);
create index ts_stats_transetgroup_user_daily_WeekIndex on ts_stats_transetgroup_user_daily (ts_week);
create index ts_stats_transetgroup_user_daily_DayIndex on ts_stats_transetgroup_user_daily (ts_day);

create index ts_stats_transetgroup_user_interval_YearIndex on ts_stats_transetgroup_user_interval (ts_year);
create index ts_stats_transetgroup_user_interval_MonthIndex on ts_stats_transetgroup_user_interval (ts_month);
create index ts_stats_transetgroup_user_interval_WeekIndex on ts_stats_transetgroup_user_interval (ts_week);
create index ts_stats_transetgroup_user_interval_DayIndex on ts_stats_transetgroup_user_interval (ts_day);
create index ts_stats_transetgroup_user_interval_HourIndex on ts_stats_transetgroup_user_interval (ts_hour);

create index ts_stats_transetgroup_user_monthly_YearIndex on ts_stats_transetgroup_user_monthly (ts_year);
create index ts_stats_transetgroup_user_monthly_MonthIndex on ts_stats_transetgroup_user_monthly (ts_month);

create index ts_stats_transetgroup_user_weekly_YearIndex on ts_stats_transetgroup_user_weekly (ts_year);
create index ts_stats_transetgroup_user_weekly_MonthIndex on ts_stats_transetgroup_user_weekly (ts_month);
create index ts_stats_transetgroup_user_weekly_WeekIndex on ts_stats_transetgroup_user_weekly (ts_week);



-- Updating database version
update ts_domains set ts_db_versions='3.3.1';
