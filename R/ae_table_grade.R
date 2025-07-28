
#' Summary tables for AE
#'
#' `r lifecycle::badge("stable")`\cr
#' The function `ae_table_grade()` creates a summary table of maximum AE grades for each patient according to the CTCAE grade.
#' The resulting dataframe can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @param percent whether to show percentages with counts. Defaults to TRUE. Can also be "only" to not show counts.
#' @param ae_label the label of adverse events, usually "AE" or "SAE".
#' @inheritParams ae_table_soc
#' @inherit ae_table_soc seealso
#'
#' @return a crosstable
#' @importFrom cli cli_abort
#' @importFrom dplyr arrange case_match case_when cur_group filter left_join mutate rename_with select summarise
#' @importFrom forcats fct_relevel fct_reorder
#' @importFrom glue glue
#' @importFrom rlang check_dots_empty check_installed
#' @importFrom stringr str_remove str_starts str_subset
#' @importFrom tibble lst
#' @importFrom tidyr unpack
#' @importFrom tidyselect matches
#' @export
#'
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#'
#' ae_table_grade(df_ae=ae, df_enrol=enrolres, arm=NULL) %>%
#'   as_flextable(header_show_n=TRUE)
#'
#' ae_table_grade(df_ae=ae, df_enrol=enrolres, arm="arm") %>%
#'   as_flextable(header_show_n=TRUE)
#'
#' #To get SAE only, filter df_ae first
#' ae %>%
#'   dplyr::filter(sae=="Yes") %>%
#'   ae_table_grade(df_enrol=enrolres, arm="arm", ae_label="SAE") %>%
#'   as_flextable(header_show_n=TRUE)
#'
#' #To describe a sub-population, filter df_enrol first
#' enrolres2 = enrolres %>%
#'   dplyr::filter(arm=="Control")
#' ae %>%
#'   ae_table_grade(df_enrol=enrolres2, arm="arm") %>%
#'   as_flextable(header_show_n=TRUE)
#'
#' #You can also filter the AE table
#' ae %>%
#'   ae_table_grade(df_enrol=enrolres, arm="arm") %>%
#'   dplyr::filter(!variable %in% c("Grade 1", "Grade 2")) %>%
#'   as_flextable(header_show_n=TRUE)
ae_table_grade = function(
    df_ae, ..., df_enrol,
    variant=c("max", "sup", "eq"),
    arm=NULL, grade="AEGR", subjid="SUBJID",
    ae_label="AE",
    percent=TRUE, digits=2,
    total=TRUE
){
  check_installed("crosstable", "for `ae_table_grade()` to work.")
  check_dots_empty()

  assert_names_exists(df_ae, lst(subjid, grade))
  assert_names_exists(df_enrol, lst(subjid, arm))
  assert_class(total, "logical")

  if(missing(total) && is.null(arm)) total = FALSE
  if(isTRUE(total)) total = "row"
  default_arm = set_label("All patients", "Treatment arm")

  df_ae = df_ae %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), grade=tolower(grade))
  df_enrol = df_enrol %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), arm=tolower(arm)) %>%
    mutate(arm=if(is.null(.env$arm)) default_arm else .data$arm)
  if(!is.numeric(df_ae$grade)){
    cli_abort("Grade ({.val {grade}}) must be a {.cls numeric} column, not a {.cls {class(df_ae$grade)}}.",
              class="ae_table_grade_not_num")
  }
  if(any(!df_ae$grade %in% c(1:5, NA), na.rm=TRUE)){
    cli_abort(c("Grade ({.val {grade}}) must be an integer between 1 and 5.",
                i="Wrong values: {.val {setdiff(df_ae$grade, 1:5)}}"),
              class="ae_table_grade_not_1to5")
  }

  df = df_enrol %>%
    left_join(df_ae, by="subjid") %>%
    arrange(subjid) %>%
    mutate(
      grade = .fix_grade_na(grade),
    )

  variant = case_match(variant, "max"~"max_grade", "sup"~"any_grade_sup",
                       "eq"~"any_grade_eq")
  rex = variant %>% paste(collapse="|") %>% paste0("^(", ., ")")

  percent_pattern = if(isTRUE(percent)) "{n} ({scales::percent(n/n_col_na,1)})"
                    else if(percent=="only") "{n/n_col}" else "{n}"
  percent_pattern = list(body=percent_pattern, total_col=percent_pattern)

  lab_no_ae = glue("No {ae_label} reported")

  rtn = df %>%
    summarise(
      max_grade_na = case_when(!cur_group()$subjid %in% df_ae$subjid ~ lab_no_ae,
                              all(is.na(grade), na.rm=TRUE) ~ "All grades missing",
                              .default="NOT NA"),
      max_grade = .max_grade(grade),

      any_grade_sup_na = case_when(!cur_group()$subjid %in% df_ae$subjid ~ lab_no_ae,
                                     any(is.na(grade), na.rm=TRUE) ~ "Some grades missing",
                                     .default="NOT NA"),
      any_grade_sup = .any_grade_sup(grade),

      any_grade_eq_na   = any_grade_sup_na,
      any_grade_eq = .any_grade_eq(grade),
      .by=c(subjid, arm)
    ) %>%
    unpack(c(max_grade, any_grade_sup, any_grade_eq)) %>%
    crosstable::crosstable(matches(rex),
               by=arm, total=total,
               percent_digits=digits,
               percent_pattern=percent_pattern) %>%
    filter(variable!="NA") %>%
    mutate(
      .all_NOT = all(str_starts(variable, "NOT")),
      variable = if_else(.all_NOT, str_remove(variable, "NOT "), variable),
      across(-c(label, variable, .all_NOT), ~if_else(.all_NOT, "0", .x)),
      .by = .id
    ) %>%
    select(-.all_NOT) %>%
    filter(!str_starts(variable, "NOT")) %>%
    filter(variable!="NA") %>%
    mutate(
      label = case_when(
        str_starts(.id, "max_grade_") ~ glue("Patient maximum {ae_label} grade"),
        str_starts(.id, "any_grade_sup_") ~ glue("Patient had at least one {ae_label} of grade"),
        str_starts(.id, "any_grade_eq_") ~ glue("Patient had at least one {ae_label} of grade "),
        .default="ERROR"
      ),
      .id = str_remove(.id, "_[^_]*$") %>% factor(levels=variant),
      label = fct_reorder(label, as.numeric(.id)),
      variable = suppressWarnings(fct_relevel(variable, lab_no_ae, after=0)),
      variable = suppressWarnings(fct_relevel(variable, "Grade = 5", after=Inf)),
      variable = suppressWarnings(fct_relevel(variable, ~str_subset(.x, "missing"), after=Inf)),
    ) %>%
    arrange(.id, label, variable)

  rtn
}



# Utils ---------------------------------------------------------------------------------------


#' @importFrom dplyr na_if
.fix_grade_na = function(x){
  as.numeric(na_if(as.character(x), "NA"))
}


#' @importFrom glue glue
#' @importFrom purrr map
#' @importFrom rlang set_names
#' @importFrom tibble as_tibble
.max_grade = function(grade){
  seq(5) %>%
    set_names(~paste0("max_grade_", .x)) %>%
    map(~ifelse(max_narm(grade) == .x ,
                glue("Grade {.x}"), glue("NOT Grade {.x}"))) %>%
    as_tibble()
}


#' @importFrom glue glue
#' @importFrom purrr map
#' @importFrom rlang set_names
#' @importFrom tibble as_tibble
.any_grade_sup = function(grade){
  seq(5) %>%
    set_names(~paste0("any_grade_sup_", .x)) %>%
    map(~ifelse(any(grade >= .x, na.rm=TRUE),
                glue("Grade \u2265 {.x}"), glue("NOT Grade \u2265 {.x}")) %>%
          str_replace("Grade \u2265 5", "Grade = 5")) %>%
    as_tibble()
}


#' @importFrom glue glue
#' @importFrom purrr map
#' @importFrom rlang set_names
#' @importFrom tibble as_tibble
.any_grade_eq = function(grade){
  seq(5) %>%
    set_names(~paste0("any_grade_eq_", .x)) %>%
    map(~ifelse(any(grade == .x, na.rm=TRUE),
                glue("Grade {.x}"), glue("NOT Grade {.x}"))) %>%
    as_tibble()
}
