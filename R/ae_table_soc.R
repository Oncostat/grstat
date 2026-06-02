
#TODO min_percent=1 -> n minimal for percents ?
#TODO total by arm OK, total total aussi?
#TODO vline dans as_flextable ?

#' Summary tables for AE by SOC
#'
#' @description
#' `r lifecycle::badge("stable")`\cr
#' The function `ae_table_soc()` creates a summary table of AE grades for each patient according to term and SOC CTCAE.
#' The resulting dataframe can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @param df_ae adverse event dataset, one row per AE, containing subjid, soc, and grade.
#' @param df_enrol enrollment dataset, one row per patient, containing subjid (and arm if needed). All patients should be in this dataset.
#' @param variant one or several of `c("max", "sup", "eq")`. `max` computes the maximum AE grade per patient, `sup` computes the number of patients having experienced at least one AE of grade higher or equal to X, and `eq` computes the number of patients having experienced at least one AE of grade equal to X.
#' @param arm name of the treatment column in `df_enrol`. Case-insensitive. Can be set to `NULL`.
#' @param term name of the the CTCAE term column in `df_ae`. Case-insensitive. Can be set to `NULL`.
#' @param sort_by_count should the table be sorted by the number of AE or by SOC alphabetically.
#' @param total whether to add a `total` column for each arm.
#' @param showNA whether to display missing grades. Only relevant if `ae_groups` is not used.
#' @param digits significant digits for percentages.
#' @param ae_groups a named list specifying the grade values for each group.
#' @param warn_miss whether to warn for missing values.
#' @param grade  name of the AE grade column in `df_ae`. Case-insensitive.
#' @param soc name of the SOC column in `df_ae`. Case-insensitive. Grade will be considered 0 if missing (e.g. if patient if absent from `df_ae`).
#' @param subjid name of the patient ID in both `df_ae` and `df_enrol`. Case-insensitive.
#' @param ... unused
#'
#' @return a dataframe (`ae_table_soc()`) or a flextable (`as_flextable()`).
#'
#' @seealso [ae_table_grade()], [ae_table_soc()], [ae_plot_grade()], [ae_plot_grade_sum()], [butterfly_plot()]
#'
#' @importFrom cli cli_abort cli_warn
#' @importFrom dplyr across any_of arrange count cur_group filter if_else left_join mutate pick pull rename select summarise
#' @importFrom forcats fct_infreq fct_relevel
#' @importFrom glue glue
#' @importFrom purrr iwalk keep map
#' @importFrom rlang arg_match check_dots_empty ensym is_empty set_names
#' @importFrom tibble deframe lst
#' @importFrom tidyr build_wider_spec pivot_wider_spec unnest
#' @importFrom tidyselect matches
#' @export
#'
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#'
#' ae_table_soc(df_ae=ae, df_enrol=enrolres)
#' ae_table_soc(df_ae=ae, df_enrol=enrolres, arm="arm")
#'
#' #sub population
#' ae_table_soc(df_ae=ae, df_enrol=head(enrolres, 10), arm="arm")
#'
#' #the resulting flextable can be customized using the flextable package
#' library(flextable)
#' ae_table_soc(ae, df_enrol=enrolres, total=FALSE) %>%
#'   as_flextable() %>%
#'   hline(i=~soc=="" & soc!=dplyr::lead(soc))
#' ae_table_soc(ae, df_enrol=enrolres, term=NULL, sort_by_count=FALSE) %>%
#'   as_flextable() %>%
#'   bold(i=~soc=="Eye disorders")
#' ae_table_soc(ae, df_enrol=enrolres, term="aeterm", arm=NULL) %>%
#'   as_flextable() %>%
#'   highlight(i=~soc=="Hepatobiliary disorders", j="all_patients_Tot")
ae_table_soc = function(
    df_ae, ..., df_enrol,
    variant=c("max", "sup", "eq"),
    arm=NULL, term=NULL,
    ae_groups = NULL,
    sort_by_count=TRUE, total=TRUE, showNA=TRUE, digits=0, warn_miss=FALSE,
    grade="AEGR", soc="AESOC", subjid="SUBJID"
){
  check_dots_empty()
  default_arm = set_label("All patients", "Treatment arm")
  null_term = is.null(term)
  null_arm = is.null(arm)
  variant = arg_match(variant)

  assert_names_exists(df_ae, lst(subjid, term, soc, grade))
  assert_names_exists(df_enrol, lst(subjid, arm))

  label_missing_soc = "Missing SOC"
  label_missing_pat = "No Declared AE"

  if(variant!="max" && missing(total) && total){
    cli_warn("Total has been set to `FALSE` as totals are not very interpretable
             when {.arg variant} is {.val sup} or {.val eq}. Set `total=FALSE`
             explicitly to silence this warning.")
    total=FALSE
  }

  df_ae = df_ae %>%
    select(subjid_=any_of2(subjid), soc_=any_of2(soc),
           term_=any_of2(term), grade_=any_of2(grade)) %>%
    mutate(soc_ = if_else(soc_ %in% c(0, NA), label_missing_soc, soc_))
  df_enrol = df_enrol %>%
    select(subjid_=any_of2(subjid), arm_=any_of2(arm)) %>%
    mutate(arm_ = if(is.null(.env$arm)) default_arm else .data$arm_)
  if(!is.numeric(df_ae$grade_)){
    cli_abort("Grade ({.val {grade}}) should be a numeric column.")
  }

  df = df_enrol %>%
    left_join(df_ae, by="subjid_") %>%
    arrange(subjid_) %>%
    mutate(
      arm_ = to_snake_case(arm_),
      soc_ = if_else(!subjid_ %in% df_ae$subjid_, label_missing_pat, soc_)
    )

  #check missing data
  if(warn_miss){
    miss = names(df) %>% set_names() %>% map(~{
      df %>% filter(is.na(!!ensym(.x))) %>% pull(subjid_) %>% unique() %>% sort()
    }) %>% keep(~!is_empty(.x))
    miss %>% iwalk(~{
      cli_warn("{.fn ae_table_soc}: Missing values in column {.val {.y}} for patients {.val {.x}}.",
               class="grstat_ae_missing_values_warning")
    })
  }

  arm_count = df_enrol %>%
    count(arm_) %>%
    deframe() %>% as.list()
  arm_count2 = arm_count %>%
    set_names(to_snake_case)

  extra_cols = if(total) c("Tot") else NULL
  
  default = list("G1"=1, "G2"=2, "G3"=3, "G4"=4, "G5"=5)
  if(isTRUE(showNA)) default[["NA"]] = NA
  ae_groups = .get_ae_groups(ae_groups, default=default)

  rtn = df %>%
    summarise(calc = .evaluate_grades(grade_, variant, ae_groups),
              .by=any_of(c("subjid_", "arm_", "soc_", "term_"))) %>%
    unnest(calc) %>%
    mutate(
      soc_ = soc_ %>% fct_infreq(w=Tot) %>%
        fct_last(label_missing_soc, label_missing_pat)
    ) %>%
    summarise(
      across(c(all_of(names(ae_groups)), any_of(extra_cols)), ~{
        n = sum(.x)
        n_arm = arm_count2[[cur_group()$arm_]]
        label = glue("{n} ({p})", p=percent(n/n_arm, digits))
        label[n==0] = NA
        label
      }),
      .by=any_of(c("arm_", "soc_", "term_"))
    ) %>%
    arrange(arm_, soc_)

  if(!total) rtn = rtn %>% select(-any_of("Tot"))
  if(!showNA) rtn = rtn %>% select(-any_of("NA"))
  if(!sort_by_count) {
    rtn = rtn %>%
      mutate(across(any_of(c("soc_", "term_")), ~factor(as.character(.x))),
             soc_ = fct_relevel(soc_, label_missing_pat, after=Inf)) %>%
      arrange(arm_, soc_)
  }

  spec = rtn %>%
    build_wider_spec(names_from=arm_,
                     values_from=c(all_of(names(ae_groups)), any_of(c("NA", "Tot"))),
                     names_glue="{arm_}__{.value}") %>%
    arrange(.name)

  rtn = rtn %>%
    rename(soc=soc_, term=any_of("term_")) %>%
    pivot_wider_spec(spec) %>%
    arrange(soc, pick(any_of("term"))) %>%
    mutate(across(everything(), ~set_label(.x, cur_column()))) %>%
    rename_with(to_snake_case) %>%
    add_class("ae_table_soc")

  attr(rtn, "header") =
    glue("{a} (N={b})", a=names(arm_count), b=arm_count) %>%
    set_names(to_snake_case(names(arm_count))) %>%
    as.character()

  rtn
}


# https://coolors.co/palette/dbe5f1-b8cce4-f2dcdb-e5b9b7-ebf1dd-d7e3bc-e5e0ec-ccc1d9-dbeef3-b7dde8
#' Turns an `ae_table_soc` object into a formatted `flextable`
#'
#' @param x a dataframe, resulting of `ae_table_soc()`
#' @param arm_colors colors for the arm groups
#' @param padding_v a numeric of lenght up to 2, giving the vertical padding of body (1) and header (2)
#' @param ... unused
#'
#' @return a formatted flextable
#' @rdname ae_table_soc
#' @export
#'
#' @importFrom dplyr lag lead transmute
#' @importFrom flextable align bg bold flextable fontsize hline hline_bottom merge_h merge_v padding set_header_df set_table_properties valign
#' @importFrom purrr map map_int
#' @importFrom rlang check_dots_empty set_names
#' @importFrom stringr str_detect str_replace_all
#' @importFrom tibble as_tibble_col
#' @importFrom tidyr separate_wider_regex
as_flextable.ae_table_soc = function(x,
                                     ...,
                                     arm_colors=c("#f2dcdb", "#dbe5f1", "#ebf1dd", "#e5e0ec"),
                                     padding_v = NULL){
  check_dots_empty()
  if (missing(padding_v)) padding_v = getOption("crosstable_padding_v", padding_v)
  table_ae_header = attr(x, "header")
  # https://github.com/tidyverse/tidyr/issues/1551
  labels = get_label(x) %>% unlist()
  header_df = names(x) %>%
    as_tibble_col("col_keys") %>%
    mutate(label = labels[col_keys]) %>%
    separate_wider_regex(label, c(h1 = ".*", "__", h2 = ".*"),
                         too_few="align_start", cols_remove=FALSE) %>%
    transmute(
      col_keys,
      row1 = case_when(
        h1 == "soc" ~ "",
        h1 == "term" ~ "",
        .default = table_ae_header[h1]
      ),
      row2 = case_when(
        h1 == "soc" ~ "CTCAE SOC",
        h1 == "term" ~ "CTCAE v4.0 Term",
        .default = h2
      ),
    )

  col1 = header_df$col_keys %in% c("soc", "term") %>% which() %>% max()

  sep_cols = with(header_df, !col_keys %in% c("soc", "term") & row1!=lead(row1)) %>%
    which() %>% unname() %>% c(ncol(x))

  rtn = x %>%
    flextable() %>%
    set_header_df(mapping=header_df) %>%
    hline_bottom(part="header") %>%
    merge_h(part="header") %>%
    align(i=1, part="header", align="center") %>%
    align(j=seq(col1), part="all", align="right") %>%
    padding(padding.top=0, padding.bottom=0) %>%
    set_table_properties(layout="autofit") %>%
    fontsize(size=8, part="all") %>%
    bold(part="header")

  if (length(padding_v) >= 1) {
    rtn = padding(rtn, padding.top=padding_v[1], padding.bottom=padding_v[1], part="body")
  }
  if (length(padding_v) == 2) {
    rtn = padding(rtn, padding.top=padding_v[2], padding.bottom=padding_v[2], part="header")
  }
  if (!is.null(x[["term"]])) {
    b = structure(list(width=1, color="grey", style="solid"), class="fp_border")
    rtn = rtn %>%
      merge_v(j="soc") %>%
      valign(j="soc", valign="top") %>%
      hline(i=~soc!=dplyr::lead(soc), border=b)
  }
  a = sep_cols
  for(i in seq_along(a)){
    from = lag(a, default=col1)[i] + 1
    to = a[i]
    rtn = rtn %>% bg(j=seq(from, to), bg = arm_colors[i], part="all")
  }

  rtn
}


# Utils ---------------------------------------------------------------------------------------


#' for each patient/soc, detect if each grade satisfies the specified
#' condition (max/eq/sup)
#' @importFrom purrr map_lgl
#' @importFrom rlang set_names
#' @importFrom tibble as_tibble_row
#' @importFrom tidyr replace_na
#' @noRd
#' @keywords internal
.evaluate_grades = function(gr, variant, ae_groups){
  inner_calc = switch(variant, max=~max_narm(gr) == .x,
                      sup=~any(gr >= .x, na.rm=TRUE),
                      eq=~any(gr == .x, na.rm=TRUE))
  n = c(1:5) %>% set_names(paste0("G",1:5)) %>% map_lgl(inner_calc)
  n["NA"] = all(is.na(n))
  n = replace_na(n, FALSE)
  n_tot = c(Tot=sum(n, na.rm=TRUE))
  n = map_lgl(ae_groups, ~{
    nm = ifelse(is.na(.x), "NA", paste0("G",.x))
    any(n[nm])
  })

  c(n, n_tot) %>%
    as_tibble_row()
}


#' @noRd
#' @keywords internal
.get_ae_groups = function(ae_groups, default){
  if(is.null(ae_groups)) return(default)
  assert(is_named(ae_groups),
          msg = "{.arg ae_groups} should be a named list of numeric values between 1 and 5.",
          class="ae_table_soc_group_bad_class")
  if(!is.list(ae_groups)){
    assert_class(ae_groups, "numeric")
    return(as.list(ae_groups))
  }
  ok = ae_groups %>% map_lgl(~all(is.na(.x) | (is.numeric(.x) & .x>0 & .x<6),
                                  na.rm=TRUE))
  assert(all(ok),
          msg = "{.arg ae_groups} should be a named list of numeric values between 1 and 5.",
          class="ae_table_soc_group_bad_number")
  ae_groups
}
