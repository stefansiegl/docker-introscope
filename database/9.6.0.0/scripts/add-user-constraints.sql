alter table ts_defect_meta_values 
    add constraint FKE00FC8E235F57ED 
    foreign key (ts_defect_id) 
    references ts_defects on delete cascade;
alter table ts_defects 
    add constraint FK34AA2B62545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_defects_interval 
    add constraint FK6C189902545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transet_user_daily 
    add constraint FK8ED105ED545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transet_user_interval 
    add constraint FK7FB8BC71545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transet_user_monthly 
    add constraint FK12ED12E1545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transet_user_weekly 
    add constraint FK6BF2532D545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transetgroup_user_daily 
    add constraint FK95AB2C5C545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transetgroup_user_interval 
    add constraint FKE4174BA2545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transetgroup_user_monthly 
    add constraint FKCBD75990545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_transetgroup_user_weekly 
    add constraint FK405CFA9E545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_tranunit_user_daily 
    add constraint FK28B2FE55545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_tranunit_user_interval 
    add constraint FKFF230B09545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_tranunit_user_monthly 
    add constraint FKBC329149545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
alter table ts_stats_tranunit_user_weekly 
    add constraint FKE4F67C5545ADA6D 
    foreign key (ts_user_id) 
    references ts_users;
