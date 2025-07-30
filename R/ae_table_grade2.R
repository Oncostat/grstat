


# db = grstat_example(N=200, p_na=0.1)
# ae_table_grade2(db$ae, df_enrol = db$enrolres, arm=NULL, total=FALSE, digits = 0) %>% 
#   as_flextable(padding_v = 0) %>% print()
# ae_table_grade2(db$ae, df_enrol = db$enrolres, arm="ARM", total=TRUE, digits = 1) %>% 
#   as_flextable(padding_v = 0) %>% print()
# ae_table_grade2(db$ae, df_enrol = db$enrolres, arm="ARM", total=FALSE, digits = 2) %>% 
#   as_flextable(padding_v = 0) %>% print()
ae_table_grade2 = function(
  df_ae,
  ...,
  df_enrol,
  variant = c("max", "sup", "eq"),
  arm = NULL,
  grade = "AEGR",
  subjid = "SUBJID",
  ae_label = "AE",
  percent_pattern = "{n} ({p}%)",
  percent_digits = 0,
  zero_value = "0",
  total = TRUE,
  #deprecated
  percent = TRUE,
  digits = 0
) {
  check_dots_empty()

  assert_names_exists(df_ae, lst(subjid, grade))
  assert_names_exists(df_enrol, lst(subjid, arm))
  assert_class(total, "logical")

  if (missing(total) && is.null(arm)) {
    total = FALSE
  }

  df = .base_ae_table(df_ae, df_enrol, arm, grade, subjid)

  #TODO : et si un des bras s'appelle déjà "Total" ?
  if(isFALSE(percent)){
    lifecycle::deprecate_warn("0.1.0.9015", "ae_table_grade(percent)", 
                              details = "Please use `percent_pattern` instead")
    percent_pattern = "{n}"
  }

  params = lst(total, digits, zero_value, percent_pattern)
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
  bind_rows(x) %>%
    mutate(      
      label = case_when(
        .id == "max_grade" ~ glue("Patient maximum {ae_label} grade"),
        .id == "any_grade_sup" ~ glue("Patient had at least one {ae_label} of grade"),
        .id == "any_grade_eq" ~ glue("Patient had at least one {ae_label} of grade "),
        .default="ERROR"
      ),      
      .after = .id
    ) %>% 
    structure(arms = arms) %>% 
    add_class("ae_table_grade")
}

#' @export
as_flextable.ae_table_grade = function(x, ..., padding_v = NULL) {
  if (missing(padding_v)) {
    padding_v = getOption("crosstable_padding_v", padding_v)
  }

  arms = attr(x, "arms")
  header_df = names(x) %>%
    as_tibble_col("col_keys") %>%
    mutate(
      row1 = ifelse(col_keys %in% arms$levels, arms$label, col_keys),
      row2 = col_keys,
    )
  if(length(arms$levels)==1) {
    header_df = select(header_df, -row1)
  }
  border2 = structure(list(width = 2, color = "black", style = "solid"), class = "fp_border")
  
  x %>%
    flextable(col_keys = setdiff(names(x), ".id")) %>%
    set_header_df(mapping = header_df) %>%
    hline(part = "header") %>%
    hline(part = "body", i = ~ .id != lead(.id)) %>%
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



# Utils -----

.base_ae_table = function(df_ae, df_enrol, arm, grade, subjid) {
  df_ae = df_ae %>%
    rename_with(tolower) %>%
    select(subjid = all_of(tolower(subjid)), grade = all_of(tolower(grade)))
  
  default_arm = set_label("All patients", "Treatment arm")
  df_enrol = df_enrol %>%
    rename_with(tolower) %>%
    select(subjid = all_of(tolower(subjid)), arm = any_of(tolower(arm))) %>%
    mutate(arm = if (is.null(.env$arm)) default_arm else .data$arm)

  if (!is.numeric(df_ae$grade)) {
    cli_abort(
      "Grade ({.val {grade}}) must be a {.cls numeric} column, not a {.cls {class(df_ae$grade)}}.",
      class = "ae_table_grade_not_num"
    )
  }
  if (any(!df_ae$grade %in% c(1:5, NA), na.rm = TRUE)) {
    cli_abort(
      c(
        "Grade ({.val {grade}}) must be an integer between 1 and 5.",
        i = "Wrong values: {.val {setdiff(df_ae$grade, 1:5)}}"
      ),
      class = "ae_table_grade_not_1to5"
    )
  }

  df_enrol %>%
    left_join(df_ae, by = "subjid") %>%
    arrange(subjid) %>%
    mutate(
      grade = .fix_grade_na(grade),
    ) %>%
    structure(ae_id = df_ae$subjid)
}



np = function(n, p, digits=0, zero_value="0", pattern="{n} ({p}%)") {
  pc = scales::label_percent(accuracy=10^(-digits), suffix="")
  p = pc(p)
  ifelse(is.null(zero_value) | n>0, glue(pattern), zero_value)
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
        max_gr == 0 ~ "No declared AE",
        is.na(max_gr) ~ "Grade all missing",
        .default = paste("Grade", max_gr)
      ),
      max_gr = max_gr %>% fct_relevel("No declared AE"),
      np = np(n, p, digits=params$digits, zero_value=params$zero_value, 
              pattern=params$percent_pattern),
      arm = fct_last(arm, "Total")
    ) %>%
    rename(variable = max_gr) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = "max_grade",
      # label = glue("Patient maximum {ae_label} grade"),
      .before = 0
    )
}

.calc_any_grade_eq = function(grade, included) {
  rtn = seq(5) %>%
    set_names(~ paste0("Grade ", .x)) %>%
    map(~ any(grade == .x, na.rm = TRUE))
  rtn[["Any missing grade"]] = all(included) & any(is.na(grade))
  rtn[["No declared AE"]] = !all(included)
  rtn
}
.calc_any_grade_sup = function(grade, included) {
  rtn = seq(5) %>%
    set_names(~ paste0("Grade \u2265 ", .x)) %>%
    map(~ any(grade >= .x, na.rm = TRUE))
  rtn[["Any missing grade"]] = all(included) & any(is.na(grade))
  rtn[["No declared AE"]] = !all(included)
  rtn
}



any_grade = function(df, f, params) {
  ae_id = attr(df, "ae_id")
  id = if(caller_arg(f)==".calc_any_grade_sup") "any_grade_sup" else "any_grade_eq"

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
      variable = variable %>% fct_relevel("No declared AE") %>% fct_last("Any missing grade")
    ) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = id,
      .before = 0
    )
}


# BAK -----


any_grade_eq = function(df, ae_label) {
  ae_id = attr(df, "ae_id")
  # browser()
  df %>%
    .add_total_arm() %>%
    summarise(
      tmp = list(.calc_any_grade_eq(grade, subjid %in% ae_id)),
      .by = c(subjid, arm)
    ) %>%
    unnest_longer(tmp, indices_to = "variable") %>%
    summarise(
      n = sum(tmp),
      p = n / n(),
      .by = c(arm, variable)
    ) %>%
    mutate(
      np = np(n, p),
      arm = fct_relevel(arm, "Total", after = Inf)
    ) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = "any_grade_eq",
      label = glue("Patient had at least one {ae_label} of grade"),
      .before = 0
    )
}
any_grade_sup = function(df, ae_label) {
  ae_id = attr(df, "ae_id")

  df %>%
    .add_total_arm() %>%
    summarise(
      tmp = list(.calc_any_grade_sup(grade, subjid %in% ae_id)),
      .by = c(subjid, arm)
    ) %>%
    unnest_longer(tmp, indices_to = "variable") %>%
    summarise(
      n = sum(tmp),
      p = n / n(),
      .by = c(arm, variable)
    ) %>%
    mutate(
      np = np(n, p),
      arm = fct_relevel(arm, "Total", after = Inf)
    ) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = "any_grade_sup",
      label = glue("Patient had at least one {ae_label} of grade"),
      .before = 0
    )
}
any_grade_bak = function(df, ae_label) {
  ae_id = attr(df, "ae_id")

  # browser()

  do_eq = TRUE
  do_sup = TRUE

  a = df %>%
    .add_total_arm() %>%
    summarise(
      eq = if (do_eq) list(.calc_any_grade_eq(grade, subjid %in% ae_id)),
      sup = if (do_sup) list(.calc_any_grade_sup(grade, subjid %in% ae_id)),
      .by = c(subjid, arm)
    ) %>%
    unnest_longer(any_of(c("eq", "sup")), indices_to = "grade_{col}")

  sup = a %>%
    # mutate(max_gr = ifelse(!subjid %in% ae_id, 0, max_gr)) %>%
    rename(variable = grade_sup) %>%
    summarise(
      n = sum(sup),
      p = n / n(),
      .by = c(arm, variable)
    ) %>%
    mutate(
      variable = fct_recode(variable, "Grade = 5" = "Grade \u2265 5"),
      np = np(n, p),
      arm = fct_relevel(arm, "Total", after = Inf)
    ) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = "any_grade_sup",
      label = glue("Patient had at least one {ae_label} of grade"),
      .before = 0
    )

  eq = a %>%
    rename(variable = grade_eq) %>%
    summarise(
      n = sum(eq),
      p = n / n(),
      .by = c(arm, variable)
    ) %>%
    mutate(
      np = np(n, p),
      arm = fct_relevel(arm, "Total", after = Inf)
    ) %>%
    arrange(arm, variable) %>%
    pivot_wider(id_cols = variable, names_from = arm, values_from = np) %>%
    mutate(
      .id = "any_grade_eq",
      label = glue("Patient had at least one {ae_label} of grade"),
      .before = 0
    )

  lst(sup, eq)
}
