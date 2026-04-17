

#FIXME Ce fichier est un exemple de {grstat} qui doit être adapté à l'étude réelle
# Vous pouvez vous inspirer du code, mais il ne sera pas directement compatible avec vos populations,
# le nombre de bras, ou les définitions de votre protocole.

# Dans cet exemple, `enrolres` est le dataset d'enrollment, `rc` le dataset RECIST, `ae` le
# dataset des toxicités, et `eos` le dataset End of Study, avec les noms de colonnes génériques
# de TrialMaster.

# Guide pour bien checker ses données : https://danchaltiel.github.io/EDCimport/articles/checking.html



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
  assert_no_duplicate() %>%
  mutate(d=EOSDT-ENROLLDT) %>%
  filter(is.na(d) | d>1) %>% #Exclusion des EOS juste après randomisation
  filter(!SUBJID %in% ae$SUBJID) %>%
  select(SUBJID, SITEC, STNO) %>%
  edc_data_warn("AE: Patients sans AE, à confirmer explicitement", issue_n=2)


#sauve les warnings dans un fichier à partager avec le DM
# par défaut dans "output/check/edc_data_warnings_{project}_{date_extraction}.xlsx"
save_edc_data_warnings()
