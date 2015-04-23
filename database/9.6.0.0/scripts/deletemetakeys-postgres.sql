-- remove unreferenced defect meta keys
alter table ts_defect_meta_values drop constraint FKE00FC8E3955976;
delete from ts_defect_meta_keys where ts_id > 1000 and ts_id not in
  (select distinct ts_metakey_id from ts_defect_meta_values);
alter table ts_defect_meta_values add constraint FKE00FC8E3955976
  foreign key (ts_metakey_id) references ts_defect_meta_keys;
