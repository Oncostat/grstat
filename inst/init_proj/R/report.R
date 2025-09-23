


# Init --------------------------------------------------------------------

authors = dplyr::bind_rows(
  c(name="Dr Armin Clusion", role="Coordinating investigator",
    address="Gustave Roussy", phone="+33", email="name@gustaveroussy.fr"),
  c(name="Jeanne Alise ", role="Biostatistician",
    address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
  c(name="Bertrand Domise", role="Data-manager",
    address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
  c(name="Arnaud Cébo", role="Pharmacovigilant",
    address="Gustave Roussy, Pharmacovigilance Unit"),
)
sponsor = data.frame(name="Gustave Roussy", address="114 Rue Edouard Vaillant",
                     code="94805 Villejuif Cedex")

doc = gr_officer_template(
  title="Randomized Phase xxx Trial assessing the..., The Great Study",
  acronym="TGreStu",
  phase="xxx",
  date_report=format(today(), "%B %e, %Y"),
  date_first=txt$date_first_patient,
  date_last=txt$date_last_patient,
  date_cutoff=format(date_extraction),
  date_freeze=format(date_extraction),
  cset_number="CSET 2099/9999",
  eudract_number="2099-009999-99",
  ctgov_number="NCT09999999", #https://clinicaltrials.gov/study/NCT09999999
  authors = authors,
  sponsor = sponsor
)


# Filling -------------------------------------------------------------------------------------

doc = doc %>%
  body_add_gr_sections_1_9()

# Section 09: Inclusion -----------------------------------------------------------------------

doc = doc %>%
  body_add_title("Inclusions", level=1) %>%
  body_add_normal(txt$s9_inclusion1) %>%
  body_add_normal(txt$s9_inclusion2) %>%
  body_add_table_legend("Description of the patients included in the study") %>%
  body_add_flextable(tbl$s9_populations) %>%
  body_add_normal() %>%
  body_add_table_legend("Inclusions by centre") %>%
  body_add_flextable(tbl$s9_incl_centre) %>%
  body_add_normal() %>%
  body_add_gg2(plots$inclusions, width=16, height=9) %>%
  body_add_figure_legend("Cumulative number of inclusions, for each arms") %>%
  body_add_normal() %>%
  body_add_img2("graph/flowchart.png", width=19, height=19) %>%
  body_add_figure_legend("Flowchart", bookmark="flowchart") %>%
  body_add_break()


# Section 10: Description of the population at inclusion --------------------------------------

doc = doc %>%
  body_add_title("Description of the population at inclusion", level=1) %>%
  body_add_title("Population analyzed for efficacy", level=2) %>%
  body_add_title("Eligibility criteria check", level=2) %>%
  body_add_title("Initial characteristics", level=2) %>%
  body_add_title("Follow-up of the study population", level=2) %>%
  body_add_break()


# Section 11: Treatment -----------------------------------------------------------------------

doc = doc %>%
  body_add_title("Treatment", 1) %>%
  body_add_break()


# Section 12: Tolerance -----------------------------------------------------------------------

doc = doc %>%
  body_add_title("Description of the tolerance", 1) %>%
  body_add_title("Clinical toxicity", 2) %>%
  body_add_title("Biological Toxicity", 2) %>%
  body_add_title("Other observations on tolerance (optional)", 2) %>%
  body_add_title("Summary of Significant Adverse Events (SAEs)", 2) %>%
  body_add_title("Listing of toxic deaths", 2) %>%
  body_add_title("Analysis and discussion of SAE and other significant adverse events", 2) %>%
  body_add_break()

# Section 13: Efficacy ------------------------------------------------------------------------

doc = doc %>%
  body_add_title("Efficacy", level=1) %>%
  body_add_normal("Efficacy is presented in *Figure @ref(plot_efficacy)* as a Kaplan Meier curve.") %>%
  body_add_gg2(plots$km_efficacy, width=16, height=9) %>%
  body_add_figure_legend("Kaplan Meier curve", bookmark="plot_efficacy") %>%
  body_add_break()

# Section 14: Other ---------------------------------------------------------------------------

doc = doc %>%
  body_add_title("Other criteria analyses", level=1) %>%
  body_add_title("Economic evaluation", level=2) %>%
  body_add_title("Quality of life", level=2) %>%
  body_add_break()

# Section 15: Ancillary -----------------------------------------------------------------------

doc = doc %>%
  body_add_title("Ancillaries analyses", level=1) %>%
  body_add_title("Prognostic factors", level=2) %>%
  body_add_title("Biological or translational studies", level=2) %>%
  body_add_title("Imaging studies", level=2) %>%
  body_add_break()

# Write -------------------------------------------------------------------

phase_dev = TRUE

if(phase_dev){
  write_and_open(doc)
} else {
  docx.file = paste0("report/VAR_PROJ_NAME - rapport stat - ", today(), ".docx")
  write_and_open(doc, docx.file)
  save_sessioninfo()
}
