

#' GR report template
#'
#' Create a `docx` template to be used with `{officer}` for a standardized report.
#'
#' @param title Study complete title
#' @param acronym Study acronym
#' @param phase Study phase
#' @param cset_number Study CSET identifier
#' @param eudract_number Study EUDRACT identifier
#' @param ctgov_number Study identifier on clinicaltrial.gov
#' @param date_report Date of the report
#' @param date_first Date of first patient inclusion
#' @param date_last Date of last patient inclusion
#' @param date_cutoff Date of analysis cut-off
#' @param date_freeze Date of database freeze
#' @param authors A dataframe describing the report authors
#' @param sponsor A dataframe describing the study's sponsor
#'
#' @returns A `docx` object that can be saved or used with `{officer}`
#' @export
#' @importFrom flextable body_replace_flextable_at_bkm
#' @importFrom rlang check_dots_empty check_installed
#'
#' @examples
#' authors = bind_rows(
#'   c(name="Dr Armin Clusion", role="Coordinating investigator", address="Gustave Roussy", phone="+33",
#'     email="name@gustaveroussy.fr"),
#'   c(name="Jeanne Alise ", role="Biostatistician", address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
#'   c(name="Bertrand Domise", role="Data-manager", address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
#'   c(name="Arnaud Cébo", role="Pharmacovigilant", address="Gustave Roussy, Pharmacovigilance Unit"),
#' )
#' sponsor = data.frame(name="Gustave Roussy", address="114 Rue Edouard Vaillant", code="94805 Villejuif Cedex")
#'
#' doc = gr_officer_template(
#'   title="The Great Study", acronym="TGreStu",
#'   phase="III",
#'   date_report="2025-01-01",
#'   date_first="2024-01-01",
#'   date_last="2024-06-01",
#'   date_cutoff="2024-09-01",
#'   date_freeze="2024-09-01",
#'   authors = authors,
#'   sponsor = sponsor
#' ) %>%
#'   officer::body_add("This is a great study, and here are the stats.")
#'
#' path = tempfile(fileext=".docx")
#' print(doc, path)
#' browseURL(path)
gr_officer_template = function(
    title,
    acronym,
    ...,
    phase="III",
    cset_number="CSET20xx/xxx",
    eudract_number="20xx-xx",
    ctgov_number="xxxxx",
    date_report="",
    date_first="",
    date_last="",
    date_cutoff="",
    date_freeze="",
    authors=NULL,
    sponsor=data.frame(name="Gustave Roussy", address="114 Rue Edouard Vaillant", code="94805 Villejuif Cedex")
){
  check_dots_empty()
  check_installed("officer", "for `create_officer_template()` to work.")

  if(is.null(authors)) authors = .gr_authors()
  base_template = system.file("officer_template.docx", package="grstat", mustWork=TRUE)

  rtn = officer::read_docx(base_template) %>%
    .body_replace_text_at_bkms(
      TRIAL_TITLE=title,
      TRIAL_ACRONYM=acronym,
      TRIAL_CSET=cset_number,
      TRIAL_EUDRACT=eudract_number,
      TRIAL_CTGOV=ctgov_number,
      TRIAL_PHASE=phase,
      DATE_REPORT=date_report,
      DATE_FIRST=date_first,
      DATE_LAST=date_last,
      DATE_CUTOFF=date_cutoff,
      DATE_FREEZE=date_freeze
    ) %>%
    officer::footers_replace_text_at_bkm("TRIAL_NAME_FOOTER", acronym) %>%
    body_replace_flextable_at_bkm("TRIAL_AUTHORS",
                                  .flextable_authors(authors, title="REPORT AUTHORS")) %>%
    body_replace_flextable_at_bkm("TRIAL_SPONSOR",
                                  .flextable_authors(sponsor, title="SPONSOR"))
  rtn
}


#' @importFrom dplyr bind_rows
.gr_authors = function(...){
  rtn = bind_rows(...)
  if(length(rtn)==0){
    rtn = bind_rows(
      c(name="xxx", role="Coordinating investigator", address="Gustave Roussy", phone="+33",
        email="name@gustaveroussy.fr"),
      c(name="xxx", role="Biostatistician", address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
      c(name="xxx", role="Data-manager", address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
      c(name="xxx", role="Pharmacovigilant", address="Gustave Roussy, Pharmacovigilance Unit"),
    )
  }
  rtn
}

#' @importFrom dplyr across any_of if_else mutate
#' @importFrom flextable as_chunk as_paragraph bold border_inner_v border_outer compose delete_part flextable font fontsize merge_v padding set_table_properties width
#' @importFrom tidyr unite
.flextable_authors = function(authors, title="REPORT AUTHORS"){
  authors %>%
    mutate(
      x1=title,
      across(any_of("phone"), ~if_else(is.na(.x), NA, paste("Telephone:", .x))),
      across(any_of("email"), ~if_else(is.na(.x), NA, paste("E-mail:", .x))),
    ) %>%
    unite("details", -c(x1, name, any_of("role")), sep="\n", na.rm=TRUE) %>%
    unite("header", c(name, any_of("role")), sep=", ", na.rm=TRUE) %>%
    flextable(col_keys=c("x1", "x2")) %>%
    compose(
      j="x2",
      value=as_paragraph(as_chunk(header, props=officer::fp_text(bold=TRUE)), as_chunk("\n"), as_chunk(details))
    ) %>%
    merge_v(j="x1") %>%
    delete_part("header") %>%
    border_outer() %>%
    border_inner_v() %>%
    set_table_properties(layout="fixed") %>%
    width(j = 1, width = 4.87 / 2.54) %>%
    width(j = 2, width = 11.06 / 2.54) %>%
    fontsize(i = 1, size = 11, part = "body") %>%
    fontsize(i = -1, size = 10, part = "body") %>%
    font(fontname="Arial", part = "body") %>%
    bold(j=1) %>%
    padding(padding.top=1, padding.bottom=1)
}

#' @importFrom cli cli_abort
.body_replace_text_at_bkms = function(doc, ..., envir=parent.frame()){
  l=list(...)
  for(i in names(l)){
    value = l[[i]]
    if(length(value)!=1) cli_abort("Value {.val {i}} should be of length 1 and is {.val {value}}")
    doc = officer::body_replace_text_at_bkm(doc, bookmark=i, value=value)
  }
  doc
}
