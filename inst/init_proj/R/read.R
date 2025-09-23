

# Read the database ---------------------------------------------------------------------------

archive = "data/the_export_of_the_study_SAS_XPORT_2024_05_24_14_50.zip"

tm = archive %>%
  read_trialmaster(
    pw="the_password_of_the_study",
    use_cache=TRUE,
  ) %>%
  set_project_name("My Study")


load_database(tm)

edc_warn_extraction_date(max_days=30)

edc_viewer()


# Global variables ----------------------------------------------------------------------------

arms = enrolres %>% select(SUBJID, ARM)
patients = sort(unique(enrolres$SUBJID))
n_patients = length(patients)
setdiff(1:max(as.numeric(as.character(patients))), patients) #pas de patient xx


tbl = list() #tables
fig = list() #figures
txt = list() #text
pop = list() #populations
VERBOSE = FALSE

edc_options(
  edc_subjid_ref=patients,
)

