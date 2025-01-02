

# Read the database ---------------------------------------------------------------------------

# tm = read_trialmaster(
#   "data/the_export_of_the_study_SAS_XPORT_2024_05_24_14_50.zip",
#   pw="the_password_of_the_study",
#   use_cache=TRUE,
#   clean_names_fun=janitor::clean_names
# )

tm = edc_example()

load_list(tm)

edc_warn_extraction_date(max_days=30)


# Global variables ----------------------------------------------------------------------------

plots = list()
descr = list()
VERBOSE = FALSE

edc_options(
  edc_subjid_ref=enrolreq$subjid,
)

