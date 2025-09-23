


# Automatic RECIST checks ---------------------------------------------------------------------


mapping = gr_recist_mapping()
mapping["target_sum"] = "RCTLSUM"
recist_check = check_recist(rc, mapping=mapping)

recist_report_html(recist_check, output_file = "output/check/recist_check_mystudy_2025-01-01.html",
                   title="RECIST Check - Study XXX - 2025/01/01", open=FALSE)
recist_report_xlsx(recist_check, output_file = "output/check/recist_check_mystudy_2025-01-01.xlsx",
                   open=FALSE)


# #1: AE sans grade ---------------------------------------------------------------------------

ae %>%
  filter(is.na(AEGR)) %>%
  select(SUBJID, SITEC, STNO, AEGR, AESDT, AESER, AETERM_S, AECIOMS) %>%
  arrange(desc(AESER), SUBJID) %>%
  edc_data_warn("AE: Grade manquant", issue_n=1)


# #2: Patients sans AE ------------------------------------------------------------------------

enrolres %>%
  full_join(eos, by="SUBJID") %>%
  mutate(d=EOSDT-ENROLLDT) %>%
  filter(is.na(d) | d>1) %>% #Exclusion des EOS juste après randomisation
  filter(!SUBJID %in% ae$SUBJID) %>%
  select(SUBJID, SITEC, STNO) %>%
  edc_data_warn("AE: Patients sans AE, à confirmer explicitement", issue_n=2)


