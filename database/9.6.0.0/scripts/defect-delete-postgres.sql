-- cleanup after bulk defect deletions

vacuum full ts_defects;
reindex table ts_defects;
analyze ts_defects;

vacuum full ts_defect_meta_values;
reindex table ts_defect_meta_values;
analyze ts_defect_meta_values;

vacuum full ts_tran_comp_details;
reindex table ts_tran_comp_details;
analyze ts_tran_comp_details;
