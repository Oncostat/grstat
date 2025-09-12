
#' Tabulate Adverse Events by Grade (max, ≥x, ==x)
#'
#' `r lifecycle::badge("stable")`\cr
#' This function creates summary tables of adverse events (AEs) by grade, for each treatment arm if provided.
#' By default, it shows three variants:
#' - `"max"`: highest AE grade experienced by each patient
#' - `"sup"`: at least one AE of grade ≥ *x*
#' - `"eq"`: at least one AE of grade == *x*
#'
#' @param data_ae Data frame of adverse events, with one row per AE.
#' @param ... Unused.
#' @param data_pat Data frame of enrolled patients, with one row per patient.
#' @param variant Character vector specifying which variants to compute: `"max"`, `"sup"`, `"eq"`.
#' @param arm Name of the arm column in `data_pat`. If `NULL`, all patients are pooled.
#' @param grade Name of the AE grade column in `data_ae`.
#' @param subjid Name of the subject ID column (in both data frames).
#' @param ae_label Label used in the output tables (e.g. "AE", "Toxicity").
#' @param percent_pattern Pattern used to format counts and percentages. Use `{n}` and `{p}` as placeholders.
#' @param percent_digits Number of digits to show for percentages.
#' @param zero_value String to use when count is zero.
#' @param total Logical. If `TRUE`, adds a "Total" column across arms (only if multiple arms exist).
#' @param na_strategy A named list controlling how missing AEs or absent patients are
#'   displayed in the output tables. Must contain `display` (one of `"if_any"`
#'   or `"always"`) and `grouped` (logical).
#' @param df_ae,df_enrol Deprecated. Use `data_ae` and `data_pat` instead.
#' @param percent,digits Deprecated. Use `percent_pattern`and `percent_digits` instead.
#'
#' @return A data frame of class `ae_table_grade`, ready for use with [as_flextable()].
#'
#' @importFrom tibble remove_rownames
#' @importFrom flextable hline_top
#' @importFrom tidyr pivot_wider complete unnest_longer
#' @export
#'
#' @examples
#' db = grstat_example(N=200, p_na=0.1)
#' ae_table_grade(db$ae, data_pat=db$enrolres,
#'                total=FALSE, percent_digits=1) %>%
#'   as_flextable()
#'
#' db = grstat_example(N=20, p_na=0)
#' ae_table_grade(db$ae, data_pat=db$enrolres, arm="ARM",
#'                total=TRUE, zero_value="-",
#'                na_strategy=list(display="always", grouped=TRUE)) %>%
#'   as_flextable()
#'
ae_table_grade = function(
  data_ae,
  ...,
  data_pat,
  variant = c("max", "sup", "eq"),
  arm = NULL,
  grade = "AEGR",
  subjid = "SUBJID",
  ae_label = "AE",
  percent_pattern = "{n} ({p}%)",
  percent_digits = 0,
  zero_value = "0",
  total = TRUE,
  na_strategy = list(display="if_any", grouped=FALSE),
  #deprecated
  df_ae,
  df_enrol,
  percent = TRUE,
  digits = 0
) {
  check_dots_empty()
  if(!missing(df_enrol)){
    data_pat = df_enrol
  }
  if(!missing(df_ae)){
    data_ae = df_ae
  }
  if(!missing(digits)){
    percent_digits = digits
  }

  assert_names_exists(data_ae, lst(subjid, grade))
  assert_names_exists(data_pat, lst(subjid, arm))
  assert_names_exists(na_strategy, c("display", "grouped"))
  assert_class(total, "logical")

  if (missing(total) && is.null(arm)) {
    total = FALSE
  }

  df = .base_ae_table(data_ae, data_pat, arm, grade, subjid)

  if(isFALSE(percent)){
    lifecycle::deprecate_warn("0.1.0.9015", "ae_table_grade(percent)",
                              details = "Please use `percent_pattern` instead")
    percent_pattern = "{n}"
  }

  params = lst(total, digits, zero_value, percent_pattern, ae_label)
  # fmt: skip
  x = variant %>%
    map(~{
      switch(
        .x,
        max = max_grade(df, params=params),
        sup = any_grade(df, f=.calc_any_grade_sup, params=params),
        eq =  any_grade(df, f=.calc_any_grade_eq, params=params)
      )
    })

  arms = list(levels = levels(factor(df$arm)), label = get_label(df$arm))
  arms = df %>% distinct(subjid, arm) %>% count(arm)

  rtn = bind_rows(x) %>%
    mutate(
      label = case_when(
        .id == "max_grade" ~ glue("Patient maximum {ae_label} grade"),
        .id == "any_grade_sup" ~ glue("Patient had at least one {ae_label} of grade"),
        .id == "any_grade_eq" ~ glue("Patient had at least one {ae_label} of grade "),
        .default="ERROR"
      ),
      across(c(.id, label), as_factor),
      .after = .id
    )

  cols_missing = c(glue("No {ae_label} reported"), "All grades missing", "Some grades missing")
  if (na_strategy$display %in% c("if_any", "ifany")) {
    rtn = rtn %>%
      filter(
        if_any(
          -c(.id, label, variable),
          ~ !variable %in% cols_missing | str_detect(.x, "[1-9]")
        )
      )
  }

  if (na_strategy$grouped && length(variant) > 1) {
    rtn = rtn %>%
      mutate(
        .id = if_else(variable %in% cols_missing, factor("missing"), .id),
        .id = fct_relevel(.id, "missing"),
        label = if_else(.id == "missing", "Missing values", label)
      ) %>%
      arrange(.id) %>%
      distinct()
  }

  rtn %>%
    structure(arms = arms) %>%
    remove_rownames() %>%
    add_class("ae_table_grade")
}


#' Convert AE Table to Flextable
#'
#' Converts an object of class `ae_table_grade` to a formatted `flextable`.
#'
#' @param x An object of class `ae_table_grade`.
#' @param ... Unused.
#' @param padding_v Vertical padding for cells.
#'
#' @return A `flextable` object ready to print or export.
#' @export
as_flextable.ae_table_grade = function(x, ..., padding_v = NULL) {
  check_dots_empty()
  if (missing(padding_v)) {
    padding_v = getOption("crosstable_padding_v", padding_v)
  }

  arms = attr(x, "arms")
  header_df = names(x) %>%
    as_tibble_col("col_keys") %>%
    left_join(arms, by=c("col_keys"="arm")) %>%
    mutate(
      row1 = ifelse(is.na(n), col_keys, get_label(arms$arm)),
      row2 = ifelse(is.na(n), col_keys, glue("{col_keys}\n(N={n})")),
    ) %>%
    select(-n)
  if(n_distinct(arms$arm)==1) {
    header_df = select(header_df, -row1)
  }
  border2 = structure(list(width = 2, color = "black", style = "solid"), class = "fp_border")

  x %>%
    flextable(col_keys = setdiff(names(x), ".id")) %>%
    set_header_df(mapping = header_df) %>%
    hline(part = "header") %>%
    hline(part = "body", i = ~ .id != dplyr::lead(.id)) %>%
    hline_top(part = "header", border = border2) %>%
    hline_bottom(part = "header", border = border2) %>%
    hline_bottom(part = "body", border = border2) %>%
    merge_h(part = "header") %>%
    merge_v(part = "header") %>%
    merge_v(part = "body", j = ".id", target="label") %>%
    align(part = "header", align = "center") %>%
    padding(padding.top = padding_v, padding.bottom = padding_v) %>%
    set_table_properties(layout = "autofit") %>%
    fontsize(size = 8, part = "all") %>%
    bold(part = "header")
}



# Utils ------------------------------------------------------------------


.base_ae_table = function(data_ae, data_pat, arm, grade, subjid) {
  data_ae = data_ae %>%
    rename_with(tolower) %>%
    select(subjid = all_of(tolower(subjid)), grade = all_of(tolower(grade)))

  default_arm = set_label("All patients", "Treatment arm")
  data_pat = data_pat %>%
    rename_with(tolower) %>%
    select(subjid = all_of(tolower(subjid)), arm = any_of(tolower(arm))) %>%
    mutate(arm = if (is.null(.env$arm)) default_arm else .data$arm)

  if (!is.numeric(data_ae$grade)) {
    cli_abort(
      "Grade ({.val {grade}}) must be a {.cls numeric} column, not a {.cls {class(data_ae$grade)}}.",
      class = "ae_table_grade_not_num"
    )
  }
  if (any(!data_ae$grade %in% c(1:5, NA), na.rm = TRUE)) {
    cli_abort(
      c(
        "Grade ({.val {grade}}) must be an integer between 1 and 5.",
        i = "Wrong values: {.val {setdiff(data_ae$grade, 1:5)}}"
      ),
      class = "ae_table_grade_not_1to5"
    )
  }

  data_pat %>%
    left_join(data_ae, by = "subjid") %>%
    arrange(subjid) %>%
    mutate(
      grade = .fix_grade_na(grade),
    ) %>%
    structure(ae_id = data_ae$subjid)
}



np = function(n, p, digits=0, zero_value="0", pattern="{n} ({p}%)") {
  pc = scales::label_percent(accuracy=10^(-digits), suffix="")
  p = pc(p)
  ifelse(is.null(zero_value) | n>0, glue(pattern), glue(zero_value))
}


.add_total_arm = function(df, do=TRUE, label = "Total") {
  if (isTRUE(do) && n_distinct(df$arm) > 1) {
    df = df %>%
      mutate(arm = factor(label)) %>%
      bind_rows(df)
  }
  df
}

max_grade = function(df, params) {
  ae_id = attr(df, "ae_id")
  lab_no_ae = glue("No {params$ae_label} reported")
  lab_ae_na = "All grades missing"

  a = df %>%
    summarise(
      max_gr = max_narm(grade),
      .by = c(subjid, arm)
    ) %>%
    mutate(max_gr = ifelse(!subjid %in% ae_id, 0, max_gr))
  a %>%
    .add_total_arm(do=params$total) %>% 
    mutate(n_arm = n(), .by = arm) %>%
    summarise(n = n(), p = n() / unify(n_arm), .by = c(arm, max_gr)) %>%
    complete(arm, max_gr = c(0:5, NA), fill = list(n = 0, p = 0)) %>%
    mutate(
      max_gr = case_when(
        max_gr == 0 ~ lab_no_ae,
        is.na(max_gr) ~ lab_ae_na,
        .default = paste("Grade", max_gr)
      ),
      max_gr = max_gr %>% fct_relevel(lab_no_ae) %>% fct_last(lab_ae_na),
      np = np(n, p, digits=params$digits, zero_value=params$zero_value,
              pattern=params$percent_pattern),
      arm = fct_last(arm, "Total")
    ) %>%
    rename(variable = max_gr) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = "max_grade",
      .before = 0
    )
}

.calc_any_grade_eq = function(grade, included) {
  rtn = seq(5) %>%
    set_names(~ paste0("Grade ", .x)) %>%
    map(~ any(grade == .x, na.rm = TRUE))
  rtn[["Some grades missing"]] = all(included) & any(is.na(grade))
  rtn[["no_ae"]] = !all(included)
  rtn
}
.calc_any_grade_sup = function(grade, included) {
  rtn = seq(5) %>%
    set_names(~ paste("Grade", ifelse(.x==5, "=", "\u2265"), .x)) %>%
    map(~ any(grade >= .x, na.rm = TRUE))
  rtn[["Some grades missing"]] = all(included) & any(is.na(grade))
  rtn[["no_ae"]] = !all(included)
  rtn
}



any_grade = function(df, f, params) {
  ae_id = attr(df, "ae_id")
  id = if(caller_arg(f)==".calc_any_grade_sup") "any_grade_sup" else "any_grade_eq"
  lab_no_ae = glue("No {params$ae_label} reported")
  lab_ae_na = "Some grades missing"
  
  df %>%
    .add_total_arm(do=params$total) %>% 
    summarise(
      tmp = list(f(grade, subjid %in% ae_id)),
      .by = c(subjid, arm)
    ) %>%
    unnest_longer(tmp, indices_to = "variable") %>%
    summarise(
      n = sum(tmp),
      p = n / n(),
      .by = c(arm, variable)
    ) %>%
    mutate(
      np = np(n, p, digits=params$digits, zero_value=params$zero_value,
              pattern=params$percent_pattern),
      arm = fct_last(arm, "Total"),
      variable = factor(variable) %>% str_replace("no_ae", lab_no_ae) %>%
        fct_relevel(lab_no_ae) %>% fct_last("Grade = 5") %>% fct_last(lab_ae_na)
    ) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = id,
      .before = 0
    )
}

