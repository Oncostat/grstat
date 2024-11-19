


# Init --------------------------------------------------------------------

TITRE = "VAR_PROJ_NAME"
NOM_BIOSTAT = "Dr Myself"
DATE = format(today(), "%B %e, %Y")

docx.file = paste0("report/VAR_PROJ_NAME - rapport stat ", format(Sys.Date(), "%Y-%m-%d"), ".docx")
template.file = file.path("data/template.docx")
template.file = NULL
# browseURL(template.file)


doc = read_docx(path = template.file) %>%
  body_replace_all_text("EXTRACTION_DATE", format(date_extraction))


# Inclusions -------------------------------------------------------------------------------

doc = doc %>%
  body_add_title("Inclusions", level=1) %>%
  body_add_normal("Inclusions are presented in *Table @ref(table_inclusion)* and *Figure @ref(plot_inclusion)*.") %>%
  body_add_normal("There is *no apparent problem*.") %>%
  body_add_table_legend("Description of the inclusions", bookmark="table_inclusion") %>%
  body_add_crosstable(descr$inclusions) %>%
  body_add_gg2(plots$inclusions, width=16, height=9) %>%
  body_add_figure_legend("Cumulative number of inclusions, for each arms", bookmark="plot_inclusion") %>%
  body_add_break()


# Demographics --------------------------------------------------------------------------------

doc = doc %>%
  body_add_title("Demographics", level=1) %>%
  body_add_normal("Demographics are presented in Table @ref(descr_demographics).") %>%
  body_add_table_section(descr$demographics,
                         legend="Demographics") %>%
  body_add_break()


# Efficacy ------------------------------------------------------------------------------------

doc = doc %>%
  body_add_title("Efficacy", level=1) %>%
  body_add_normal("Efficacy is presented in *Figure @ref(plot_efficacy)* as a Kaplan Meier curve.") %>%
  body_add_gg2(plots$km_efficacy, width=16, height=9) %>%
  body_add_figure_legend("Kaplan Meier curve", bookmark="plot_efficacy") %>%
  body_add_break()


# Write -------------------------------------------------------------------

phase_dev = TRUE

if(phase_dev){
  write_and_open(doc)
} else {
  write_and_open(doc, docx.file)
  save_sessioninfo()
}
