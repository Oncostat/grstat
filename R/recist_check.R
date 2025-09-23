
#' Check a RECIST dataset
#'
#' `r lifecycle::badge("experimental")`\cr
#' Perform multiple checks on a RECIST dataset. The checks can be exported as an HTML or Excel report using `recist_report_html()` or `recist_report_xlsx()`.
#'
#' @param rc The recist dataset to check
#' @param mapping The character vector defining the variable mapping. Refer to [gr_recist_mapping()] for default values and adjust as needed.
#' @param exclude_post_pd Logical; if `TRUE` (default), assessments after the first PD are excluded.
#'
#' @returns a tibble of nested checks, of class `check_recist`
#' @export
#'
#' @importFrom dplyr arrange desc mutate
#' @importFrom purrr list_rbind
#' @seealso [RECIST guidelines](https://ctep.cancer.gov/protocoldevelopment/docs/recist_guideline.pdf)
#'
#' @examples
#' # we unfortunately cannot provide a flawed simulated recist dataset, at least not yet
#' \dontrun{
#' db = read_database()
#' mapping = gr_recist_mapping()
#' recist_check = check_recist(db$rc, mapping=mapping)
#' recist_check
#' recist_report_html(recist_check, title="RECIST Check - Study XXX")
#' recist_report_xlsx(recist_check)
#' }
#'
check_recist = function(rc, mapping=gr_recist_mapping(), exclude_post_pd=TRUE){
  grstat_dev_warn()
  rc = .apply_recist_mapping(rc, mapping) %>%
    .remove_post_pd(resp=target_resp, date=rc_date, do=exclude_post_pd)

  rc_short = .summarise_recist(rc)

  checks = c(
    rc_check_missing(rc),
    rc_check_target_lesions(rc),
    rc_check_constancy(rc),
    rc_check_baseline_lesions(rc),
    rc_check_derived_columns(rc),
    rc_check_target_response(rc, rc_short),
    rc_check_nontarget_response(rc),
    rc_check_global_response(rc_short)
  )

  rtn = checks %>%
    list_rbind(names_to="code") %>%
    mutate(level = factor(level, levels=c("ERROR", "WARNING", "CHECK"))) %>%
    arrange(level, desc(n_subjid)) %>%
    add_class("check_recist") %>%
    structure(mapping = mapping)

  rtn
}


#' Default mapping for RECIST dataset
#'
#' `r lifecycle::badge("experimental")`\cr
#' Generates the default mapping for a RECIST dataset. See sections below for
#' information on which columns are mandatory.
#'
#' @section Mandatory Columns:
#' These columns **must** be present in the dataset for proper RECIST assessment.
#' - **`subjid`**: Subject ID.
#' - **`rc_date`**: Date of response assessment.
#' - **`target_site`**: Site of the target lesion.
#' - **`target_diam`**: Diameter of the target lesion.
#' - **`target_resp`**: Response of the target lesion.
#' - **`nontarget_yn`**: Presence (`Yes/No`) of non-target lesions.
#' - **`nontarget_resp`**: Response of non-target lesions.
#' - **`new_lesions`**: Presence of new lesions (`Yes/No`).
#' - **`global_resp`**: Overall response assessment.
#'
#' @section Optional Columns:
#' These columns are used for additional checks but are **not required**.
#' - **`target_is_node`**: Indicates whether the target lesion is a lymph node.
#' If not set, it will be inferred based on the presence of the substring `"node"`
#' in `target_site`
#' - **`target_method`**: Imaging method used for target lesion assessment.
#' - **`target_sum`**: Sum of diameters of target lesions.
#' - **`target_sum_bl`**: Baseline sum of target lesion diameters.
#' - **`target_sum_min`**: Minimum sum of target lesion diameters observed.
#'
#' @returns a named character vector
#' @export
#'
#' @examples
#' gr_recist_mapping()
gr_recist_mapping = function(){
  c(
    subjid="SUBJID", rc_date="RCDT",
    target_site="RCTLSITE", target_diam="RCTLDIAM", target_resp="RCTLRESP",
    nontarget_yn="RCNTLYN", nontarget_resp="RCNTLRES",
    new_lesions="RCNEW", global_resp="RCRESP",

    target_is_node="RCTLNODE", target_method="RCTLMOD",
    target_sum="RCTLSUM", target_sum_bl="RCTLBL", target_sum_min="RCTLMIN"
  )
}


#' Create a RECIST check report (HTML or Excel)
#'
#' `r lifecycle::badge("experimental")`\cr
#' Generate a report as an HTML or Excel file base on RECIST checks made by [check_recist()].
#'
#' @param recist_check the result of [check_recist()]
#' @param output_file the report file name.
#' @param output_dir the directory of output.
#' @param title the HTML report title.
#' @param open whether to open the report afterward.
#'
#' @returns `output_file` invisibly. Called for side effects.
#' @export
#' @importFrom cli cli_abort
#' @importFrom rlang check_installed
#'
#' @inherit check_recist examples
recist_report_html = function(recist_check,
                              output_file="recist_check_{project}_{date_extraction}.html",
                              output_dir="output/check",
                              title = "RECIST Check - {project} - {date_extraction}",
                              open=FALSE){
  check_installed("rmarkdown", "for `recist_report_html()` to work.")
  assert_class(recist_check, "check_recist")
  assert_extension(output_file, ext="html")
  output_path = get_report_path(output_dir, output_file)
  title = get_report_title(title)

  rmd_path = system.file("templates", "template_recist_check.Rmd", package="grstat")
  if(!file.exists(rmd_path)){
    cli_abort("Recist check template doesn't exists: {.path {rmd_path}}.",
              .internal=TRUE)
  }

  rmarkdown::render(rmd_path, output_file=output_path, quiet=TRUE,
                    params=list(recist_check=recist_check, report_title=title))

  if(open){
    utils::browseURL(output_file)
  }
  invisible(output_file)
}


#' @rdname recist_report_html
#' @export
#' @importFrom cli cli_abort
#' @importFrom rlang check_installed
#'
#' @inherit check_recist examples
recist_report_xlsx = function(recist_check,
                              output_file="recist_check_{project}_{date_extraction}.xlsx",
                              output_dir="output/check",
                              open=FALSE){
  check_installed("openxlsx", "for `recist_report_xlsx()` to work.")
  assert_class(recist_check, "check_recist")
  assert_extension(output_file, ext="xlsx")
  output_file = get_report_path(output_dir, output_file)

  wb = openxlsx::createWorkbook()
  sup0 = which(recist_check$n_subjid>0)
  for(i in sup0){
    x = recist_check[i, ]
    sheet = x$code
    data = x$data[[1]]
    color = if(nrow(data)==0) "green" else "red"
    openxlsx::addWorksheet(wb, sheet, tabColour=color, gridLines=FALSE)
    openxlsx::writeData(wb, sheet, x$message, colNames=FALSE)
    openxlsx::writeDataTable(wb, sheet, data, startRow=2)
    openxlsx::setColWidths(wb, sheet, cols = 2:ncol(data), widths="auto")
  }
  rtn = openxlsx::saveWorkbook(wb, output_file, overwrite=TRUE, returnValue=TRUE)
  if(!isTRUE(rtn)){
    cli_abort("Could not save the Excel file at {.path {output_file}}.")
  }
  if(isTRUE(open)){
    utils::browseURL(output_file)
  }
  invisible(rtn)
}



# Checks --------------------------------------------------------------------------------------


#' * Consistant missing values on `target_diam` & `target_site`
#' @noRd
#' @importFrom dplyr across distinct filter select
#' @importFrom tibble lst
#' @importFrom tidyselect all_of
rc_check_missing = function(rc){
  rtn = lst()

  #missing values target_diam & target_site
  rtn$target_missing_values = rc %>%
    filter(is.na(target_diam) != is.na(target_site)) %>%
    select(subjid, rc_date, target_site, target_diam) %>%
    recist_issue("Target Lesion diameter and site should not be missing",
                 level="ERROR")

  #missing values on responses: all or nothing
  resp_cols = c("new_lesions", "target_resp", "nontarget_resp", "global_resp")
  rtn$resp_missing_values = rc %>%
    filter(!(nontarget_yn=="No" & is.na(nontarget_resp))) %>%
    select(subjid, rc_date, nontarget_yn, all_of(resp_cols)) %>%
    filter(rowSums(across(all_of(resp_cols), is.na)) < 4) %>%
    filter(rowSums(across(all_of(resp_cols), is.na)) > 0) %>%
    distinct() %>%
    recist_issue("Response should not be missing, put NE if applicable.", level="WARNING")

  rtn
}


#' Target Lesions
#' * Up to a maximum of five lesions total (and a maximum of two lesions per organ)
#' * Should not be bone lesions
#' @noRd
#' @importFrom dplyr count filter select summarise
#' @importFrom stringr str_detect
rc_check_target_lesions = function(rc){
  rtn = list()

  #Target Lesion should be <5
  rtn$target_lesions_sup5 = rc %>%
    filter(!is.na(target_site) & !is.na(target_diam)) %>%
    count(subjid, rc_date) %>%
    filter(n>5) %>%
    summarise(dates = toString(rc_date), .by=-rc_date) %>%
    recist_issue("Target Lesion: More than 5 sites", level="ERROR")

  #Target Lesion should be <2 per site
  rtn$target_sites_sup2 = rc %>%
    filter(!is.na(target_site)) %>%
    count(subjid, rc_date, target_site) %>%
    filter(n>2) %>%
    summarise(dates = toString(rc_date), .by=-rc_date) %>%
    recist_issue("Target Lesion: More than 2 lesions per site", level="ERROR")

  #Target Lesion should be <2 lymph nodes
  rtn$target_nodes_sup2 = rc %>%
    filter(target_is_node) %>%
    summarise(n=n(),
              sites=toString(sort(target_site)),
              .by=c(subjid, rc_date)) %>%
    filter(n>2) %>%
    summarise(dates = toString(rc_date), .by=-rc_date) %>%
    recist_issue("Target Lesion: More than 2 lesions are lymph nodes", level="ERROR")

  #Should not be bone lesions
  rtn$target_bone_lesion = rc %>%
    filter(str_detect(tolower(target_site), "bone")) %>%
    filter(!str_detect(tolower(target_site), "marrow")) %>%
    select(subjid, rc_date, target_site) %>%
    recist_issue("Target Lesions should not be bone lesions", level="CHECK")

  rtn
}


#' Target Lesion site and evaluation method should have one value per patient
#' Responses should have one value per date
#' @keywords internal
#' @importFrom dplyr arrange distinct filter n n_distinct select summarise
#' @importFrom rlang has_name
#' @importFrom stats na.omit
rc_check_constancy = function(rc){
  rtn = list()

  #Target Lesion sites should be constant
  rtn$target_constant_sites = rc %>%
    arrange(subjid, rc_date) %>%
    summarise(
      n_sites = length(na.omit(target_site)),
      target_sites = toString(unique(sort(target_site))),
      .by=c(subjid, rc_date)
    ) %>%
    filter(n_distinct(n_sites)>1, .by=subjid) %>%
    # nest(dates=rc_date) %>%
    summarise(dates = toString(rc_date), .by=-rc_date) %>%
    recist_issue("Target Lesions should remain unchanged  throughout the followup",
                 level="ERROR")

  #Non-Target Lesion YN should be constant
  rc %>%
    distinct(subjid, rc_date, nontarget_yn) %>%
    filter(n_distinct(nontarget_yn, na.rm=TRUE)>1, .by=c(subjid)) %>%
    # nest(dates=rc_date) %>%
    summarise(dates = toString(rc_date), .by=-rc_date) %>%
    recist_issue("Non-Target Lesions presence or absence should remain unchanged
                 throughout the followup", level="ERROR")

  #Response should be constant per date
  rc %>%
    distinct(subjid, rc_date, target_resp) %>%
    filter(n()>1, .by=c(subjid, rc_date)) %>%
    recist_issue("Target Lesions should have a consistent response per date.",
                 level="ERROR")
  rc %>%
    distinct(subjid, rc_date, nontarget_resp) %>%
    filter(n()>1, .by=c(subjid, rc_date)) %>%
    recist_issue("Non-Target Lesions should have a consistent response per date.",
                 level="ERROR")
  rc %>%
    distinct(subjid, rc_date, global_resp) %>%
    filter(n()>1, .by=c(subjid, rc_date)) %>%
    recist_issue("Global Response should have a consistent value per date.",
                 level="ERROR")

  #Target Lesion evaluation method should be constant (if provided)
  if(has_name(rc, "target_method")){
    rtn$target_method_no_dup = rc %>%
      filter(!is.na(target_method)) %>%
      select(subjid, rc_date, target_site, target_method) %>%
      filter(n_distinct(target_method)>1, .by=c(subjid, target_site)) %>%
      # nest(dates=rc_date) %>%
      summarise(dates = toString(rc_date), .by=-rc_date) %>%
      recist_issue("Target Lesions should not be assessed using more than one method.",
                   level="ERROR")
  } else {
    rtn$target_method_no_dup = recist_issue_ne(
      "Target Lesions should not be assessed using more than one method.",
      level="ERROR"
    )
  }

  rtn
}


#' Baseline Target Lesions should be at least 10mm or 15mm (lymph node)
#' @noRd
#' @importFrom dplyr arrange distinct filter mutate select
#' @importFrom tidyr pivot_longer
rc_check_baseline_lesions = function(rc){
  rtn = list()

  x = rc %>%
    filter(!is.na(target_diam) | !is.na(target_site)) %>%
    filter(rc_date==min(rc_date, na.rm=TRUE),
           .by=subjid) %>%
    arrange(subjid) %>%
    mutate(non_measurable_node = target_is_node & target_diam < 15,
           non_measurable_lesion = !target_is_node & target_diam < 10) %>%
    distinct()

  rtn$target_non_measurable_node = x %>%
    filter(non_measurable_node) %>%
    select(subjid, rc_date, target_site, target_diam) %>%
    recist_issue("Target lymph nodes should be \U2265 15 mm at baseline to be
                 considered measurable",
                 level="ERROR")
  rtn$target_non_measurable_lesion = x %>%
    filter(non_measurable_lesion) %>%
    select(subjid, rc_date, target_site, target_diam) %>%
    recist_issue("Target Lesions should be \U2265 10 mm at baseline to be
                 considered measurable",
                 level="ERROR")

  #baseline response should be missing
  rtn$baseline_resp_nonmissing = rc %>%
    arrange(subjid) %>%
    filter(rc_date==min_narm(rc_date), .by=subjid) %>%
    select(subjid, baseline_rc_date=rc_date, target_resp, nontarget_resp, global_resp) %>%
    pivot_longer(-c(subjid, baseline_rc_date),
                 names_to="response_column", values_to="response_value") %>%
    distinct() %>%
    filter(!is.na(response_value)) %>%
    recist_issue("Baseline response should be missing", level="ERROR")


  rtn
}


#' Checks on values calculated in the EDC software
#' Check target sum at any time, at baseline, and at Nadir
#' In TrialMaster, if `target_sum` is modified, `target_sum_bl` & `target_sum_min`
#' are not updated automatically.
#' This also makes duplicates possible.
#' @keywords internal
#' @importFrom dplyr arrange distinct filter mutate n_distinct select summarise
#' @importFrom stats na.omit
#' @importFrom tidyselect everything
rc_check_derived_columns = function(rc){

  rtn = list()

  if(has_name(rc, "target_sum_bl")){
    ## duplicated target_sum_bl ----
    rtn$target_sum_bl_dupl = rc %>%
      filter(!is.na(target_sum_bl)) %>%
      distinct(subjid, rc_date, target_sum_bl) %>%
      filter(n_distinct(target_sum_bl)>1, .by=subjid) %>%
      summarise(dates = toString(rc_date), .by=-rc_date) %>%
      recist_issue("Baseline Target Lesion length sum should not have
                   multiple values (System-generated column `target_sum_bl`)",
                   level="WARNING")

    ## mismatch target_sum/target_sum_bl ----
    if(has_name(rc, "target_sum")){
      rtn$target_sum_bl_wrong = rc %>%
        arrange(subjid) %>%
        mutate(target_sum_bl_real = target_sum[rc_date==min(rc_date, na.rm=TRUE)][1],
               .by=subjid) %>%
        filter((target_sum_bl != target_sum_bl_real)) %>%
        distinct(subjid, rc_date, target_sum_bl, target_sum_bl_real) %>%
        summarise(dates = toString(rc_date), .by=-rc_date) %>%
        recist_issue("Baseline Target Lesion length sum differs between
                     raw data column (`target_sum`) and system-generated
                     column (`target_sum_bl`)",
                     level="WARNING")
    }
  }

  if(has_name(rc, "target_sum_min")){

    ## mismatch target_sum/target_sum_min ----
    if(has_name(rc, "target_sum")){
      rtn$target_sum_min_wrong = rc %>%
        arrange(subjid, rc_date) %>%
        mutate(real_target_sum_min = cummin(target_sum),
               .by = subjid, .after=target_sum) %>%
        filter(any(target_sum_min != real_target_sum_min), .by=subjid) %>%
        distinct(subjid, rc_date, target_sum, target_sum_min, real_target_sum_min) %>%
        recist_issue("Minimum Target Lesion length sum differs between
                     raw data column (`target_sum`) and system-generated
                     column (`target_sum_min`)",
                     level="WARNING")
    }
  }

  if(has_name(rc, "target_sum")){
    ## duplicated target_sum at baseline ----
    rtn$target_sum_bl_real_dupl = rc %>%
      filter(rc_date==min(rc_date, na.rm=TRUE), .by=subjid) %>%
      filter(n_distinct(target_sum, na.rm=TRUE)>1, .by=subjid) %>%
      distinct(subjid, rc_date, target_sum) %>%
      recist_issue("Baseline dataset's Target Lesion length sum should not have
                   multiple values",
                   level="ERROR")

    ## duplicated target_sum at any date ----
    rtn$target_sum_date_dup = rc %>%
      filter(n_distinct(target_sum, na.rm=TRUE)>1,
             .by=c(subjid, rc_date)) %>%
      recist_issue("Dataset's Target Lesion length sum should not have
                   multiple values per date.", level="ERROR")

    ## mismatch target_sum / sum(target_diam) ----
    if(has_name(rc, "target_diam")){
      rtn$target_sum_wrong = rc %>%
        arrange(subjid) %>%
        mutate(
          target_sum = target_sum[1],
          target_diam_sum = sum(target_diam, na.rm=TRUE),
          .by=c(subjid, rc_date)
        ) %>%
        filter((target_sum != target_diam_sum)) %>%
        distinct(subjid, rc_date, target_sum, target_diam_sum) %>%
        summarise(dates = toString(rc_date), .by=-rc_date) %>%
        recist_issue("Target Lesions length sum (target_sum) is not equal to the
                     sum of diameters (target_diam).",
                     level="ERROR")
    }
  }


  rtn
}


#' Check impossible cases for Non-Target Lesions response
#' @keywords internal
#' @importFrom dplyr arrange distinct filter
rc_check_nontarget_response = function(rc){
  rtn = list()

  rtn$nonmissing_ntl = rc %>%
    filter(nontarget_yn == "No" & !is.na(nontarget_resp)) %>%
    distinct(subjid, rc_date, nontarget_yn, nontarget_resp) %>%
    arrange(nontarget_yn) %>%
    recist_issue("Patients with no Non-Target Lesions should not have a
                 NTL response.", level="ERROR")

  rtn
}


#' Check impossible cases for Target Lesions response
#' @keywords internal
#' @importFrom dplyr arrange distinct filter mutate select transmute
rc_check_target_response = function(rc, rc_short){
  rtn = list()

  #Complete Response
  #CR = Disappearance of all Target Lesions. Lymph nodes must be <10 mm.
  rtn$target_cr_remaining = rc %>%
    arrange(subjid) %>%
    filter(.recist_to_num(target_resp) == 1) %>%
    mutate(remaining_node = target_is_node & target_diam>=10,
           remaining_lesion = !target_is_node & target_diam>0) %>%
    filter(remaining_node | remaining_lesion) %>%
    distinct(subjid, rc_date, target_resp, target_site, target_diam) %>%
    recist_issue("Complete Responses should have no Target Lesions remaining
                 (>0 mm) and no pathological lymph nodes present (\U2265 10 mm)",
                 level="ERROR")

  #Complete Response
  #After a CR there is no disease, so any reapearance is a progression.
  rtn$target_cr_terminal = rc %>%
    arrange(subjid, rc_date) %>%
    distinct(subjid, rc_date, target_resp, target_sum) %>%
    mutate(
      resp_num = .recist_to_num(target_resp),
      first_cr = min_narm(rc_date[resp_num==1]),
      .by=subjid
    ) %>%
    filter(rc_date>first_cr) %>%
    filter(!resp_num %in% c(1, 4, 5)) %>%
    recist_issue("After a Complete Response (CR), reponses can only be CR or PD.",
                 level="ERROR")

  #Partial Response
  rtn$target_pr_wrong = rc_short %>%
    mutate(diff_rel_bl = (target_sum-sum_bl)/sum_bl) %>%
    filter(target_resp_num==2) %>%
    filter(diff_rel_bl > -0.3) %>%
    transmute(subjid, rc_date, target_resp, target_sum_baseline=sum_bl, target_sum,
              difference=percent(diff_rel_bl, 1)) %>%
    recist_issue("Partial Responses should have a decrease in TL tumor length sum
                 higher than 30%",
                 level="ERROR")

  #Partial Response
  rtn$target_pd_wrong = rc_short %>%
    mutate(diff_abs_nad = target_sum-sum_nadir,
           diff_rel_nad = diff_abs_nad/sum_nadir) %>%
    filter(target_resp_num!=4 & !post_pd) %>%
    filter(diff_rel_nad >= 1.2 & diff_abs_nad >= 5) %>%
    select(subjid, rc_date, target_resp, target_sum_nadir=sum_nadir, target_sum,
           diff_rel_nad, diff_abs_nad) %>%
    recist_issue("Target Lesions that are at least 20% and 5mm larger than the
                 nadir should be classified as Progressive Disease.",
                 level="ERROR")

  rtn
}


#' Check impossible cases for Target Lesions response
#' @keywords internal
#' @importFrom dplyr arrange case_when desc filter mutate transmute
rc_check_global_response = function(rc_short){
  rtn = list()

  rtn$global_response = rc_short %>%
    mutate(
      # no non-Target Lesion = CR
      nontarget_resp_num = ifelse(!nontarget_yn, 1, nontarget_resp_num),
      global_resp_check = case_when(
        target_resp_num == 4 | nontarget_resp_num == 4 |  new_lesion ~ 4,
        target_resp_num == 1 & nontarget_resp_num == 1 ~ 1,
        target_resp_num <= 2 ~ 2,
        target_resp_num <= 3 ~ 3,
        target_resp_num == 5 ~ 5,
        .default = -99
      )
    ) %>%
    filter(global_resp_num != global_resp_check) %>%
    arrange(desc(global_resp_check)) %>%
    transmute(subjid, rc_date,
              target_resp,
              nontarget_yn=fct_yesno(nontarget_yn),
              nontarget_resp,
              new_lesion=fct_yesno(new_lesion),
              global_resp,
              global_resp_check=.recist_from_num(global_resp_check)) %>%
    recist_issue("Global Response should be consistant with TL response,
                 NTL response, and presence of new lesions", level="ERROR")

  rtn$nlt_progression = rc_short %>%
    filter(nontarget_resp_num == 4) %>%
    filter(target_resp_num != 4 & !new_lesion) %>%
    transmute(subjid, rc_date,
              target_resp,
              nontarget_yn=fct_yesno(nontarget_yn),
              nontarget_resp,
              new_lesion=fct_yesno(new_lesion)) %>%
    recist_issue("Progressions due only to Non-Target Lesions are rare and
               should probably be confirmed", level="CHECK")


  rtn
}



# Data ----------------------------------------------------------------------------------------



#' @importFrom dplyr across ends_with mutate summarise
#' @importFrom tidyr replace_na
.summarise_recist = function(rc){

  # col_bak = c("target_sum_bak"="target_sum",
  #             "target_sum_bl_bak"="target_sum_bl",
  #             "target_sum_min_bak"="target_sum_min")
  # col_bak = NULL

  rc_short = rc %>%
    # rename(any_of(col_bak)) %>%
    # mutate(across(any_of(col_bak), ~.x[1]),
    #        .by=c(subjid, rc_date)) %>% #in case of duplicates
    summarise(
      target_resp = target_resp[1],
      nontarget_resp = nontarget_resp[1],
      global_resp = global_resp[1],
      new_lesion = any(new_lesions=="Yes"),
      nontarget_yn = any(nontarget_yn=="Yes"),
      target_sum = sum(target_diam, na.rm=TRUE),
      .by=c(subjid, rc_date)
      # .by=c(subjid, rc_date, any_of(names(col_bak)))
    ) %>%
    mutate(
      across(ends_with("_resp"), ~.recist_to_num(.x), .names="{.col}_num"),
      baseline = rc_date == min_narm(rc_date),
      post_pd = rc_date > min_narm(rc_date[global_resp_num==4]),
      sum_bl = target_sum[baseline],
      sum_nadir = cummin(replace_na(target_sum, Inf)),
      .by=c(subjid)
    )
}


#' @importFrom dplyr any_of arrange mutate select
#' @importFrom rlang has_name
#' @importFrom stringr str_detect
#' @importFrom tibble as_tibble
#' @importFrom tidyselect all_of everything
.apply_recist_mapping = function(data, mapping){

  mandatory = c("subjid", "rc_date",
                "target_site", "target_diam", "target_resp",
                "nontarget_yn", "nontarget_resp",
                "new_lesions", "global_resp")

  rtn = data %>%
    as_tibble() %>%
    select(any_of(mapping)) %>%
    select(all_of(mandatory), everything()) %>%
    arrange(subjid, rc_date) %>%
    mutate(new_lesions = fct_yesno(new_lesions),
           nontarget_yn = fct_yesno(nontarget_yn))

  if(!has_name(rtn, "target_is_node")){
    rtn$target_is_node = str_detect(tolower(rtn$target_site), "node")
  }

  rtn
}

# Issues --------------------------------------------------------------------------------------


#' @importFrom stringr str_replace_all
#' @importFrom tibble tibble
recist_issue = function(data, message, level="ERROR"){
  data = if(nrow(data)>0) data else NULL
  message = str_replace_all(message, "\\n *", " ")
  tibble(
    message,
    n_subjid=length(unique(data$subjid)),
    level,
    data=list(data)
  )
}

#Not Evaluable
#' @importFrom tibble tibble
recist_issue_ne = function(message, level="ERROR"){
  tibble(
    message,
    n_subjid=NA,
    level,
    data=NA
  )
}


# Report helpers ------------------------------------------------------------------------------


#' @importFrom fs path path_ext path_ext_remove
#' @importFrom cli cli_warn
get_report_path = function(output_dir, output_file){
  project = get_projname()
  date_extraction = get_extraction_date() %>% format("%Y-%m-%d")
  output_path = glue(output_file, .null=NULL,
                     project=project, date_extraction=date_extraction) %>%
    str_replace_all("__", "_") %>%
    str_replace_all("_\\.", "\\.")
  output_path = path(getwd(), output_dir, output_path)
  if(file.exists(output_path)){
    output_path2 = paste0(path_ext_remove(output_path), "_bak.", path_ext(output_path))
    cli_warn("{.arg output_path} already exists and was renamed
             to {.path {output_path2}}.")
    if(file.exists(output_path2)){
      cli_warn("{.arg {output_path2}} already exists and was overwritten.")
    }
    file.rename(output_path, output_path2)
  }
  output_path
}

#' @importFrom fs path path_ext path_ext_remove
#' @importFrom cli cli_warn
get_report_title = function(x){
  project = get_projname()
  date_extraction = get_extraction_date() %>% format("%Y-%m-%d")
  glue(x, .null=NULL, project=project, date_extraction=date_extraction)
}

# Print ---------------------------------------------------------------------------------------

#' @export
#' @importFrom cli cat_rule
#' @importFrom dplyr filter select
print.check_recist = function(x, n=Inf, ...){
  cat_rule("RECIST check", col="violet")
  x_tbl = remove_class(x, "check_recist") %>%
    select(-code) %>%
    filter(n_subjid>0) %>%
    format(n=n)
  cat(x_tbl[-1], sep="\n") #remove "A tibble: n × p"
}

