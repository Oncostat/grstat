
#TODO min_percent=1 -> n minimal for percents ?
#TODO total by arm OK, total total aussi?
#TODO vline dans as_flextable ?

#' Summary tables for AE by SOC
#'
#' @description
#' `r lifecycle::badge("stable")`\cr
#' The function `ae_table_soc()` creates a summary table of AE grades for each patient by group (usually according CTCAE SOC or term).
#' The resulting dataframe can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @param data_ae adverse event dataset, one row per AE, containing `subjid`, `grade`, `group1`, and potentially `group2`.
#' @param data_pat enrollment dataset, one row per patient, containing `subjid` (and `arm` if needed). All patients should be in this dataset.
#' @param measure one or several of `c("max", "sup", "eq")`. `max` computes the maximum AE grade per patient, `sup` computes the number of patients having experienced at least one AE of grade higher or equal to X, and `eq` computes the number of patients having experienced at least one AE of grade equal to X.
#' @param arm name of the treatment column in `data_pat`. Case-insensitive. Can be set to `NULL`.
#' @param group1,group2 name of the 1st and 2nd order grouping columns in `data_ae`. Case-insensitive. Use labels for the flextable output. Usually, `group1` is the SOC and `group2` the term, but it can be any other grouping variable. `group2` can be set to `NULL` if not needed.
#' @param sort_by_count whether to sort by the number of AE or by `group1` alphabetically.
#' @param total whether to add a `total` column for each arm.
#' @param showNA whether to display missing grades. Only relevant if `ae_groups` is not used.
#' @param digits significant digits for percentages.
#' @param ae_groups a named list specifying the grade values for each group.
#' @param warn_miss whether to warn for missing values.
#' @param grade  name of the AE grade column in `data_ae`. Case-insensitive.
#' @param subjid name of the patient ID in both `data_ae` and `data_pat`. Case-insensitive.
#' @param ... unused
#'
#' @return a dataframe (`ae_table_soc()`) or a flextable (`as_flextable()`).
#'
#' @seealso [ae_table_grade()], [ae_table_soc()], [ae_plot_grade()], [ae_plot_grade_sum()], [butterfly_plot()]
#'
#' @importFrom cli cli_warn
#' @importFrom dplyr across all_of any_of arrange cur_column cur_group everything filter mutate pick pull rename rename_with select summarise
#' @importFrom forcats fct_infreq fct_relevel
#' @importFrom glue glue
#' @importFrom purrr iwalk keep map
#' @importFrom rlang arg_match ensym has_name is_empty set_names
#' @importFrom tidyr build_wider_spec pivot_wider_spec unnest
#' @export
#'
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#'
#' ae_table_soc(data_ae=ae, data_pat=enrolres)
#' ae_table_soc(data_ae=ae, data_pat=enrolres, arm="arm")
#'
#' #sub population
#' ae_table_soc(data_ae=ae, data_pat=head(enrolres, 10), arm="arm")
#'
#' #the resulting flextable can be customized using the flextable package
#' library(flextable)
#' ae_table_soc(ae, data_pat=enrolres, total=FALSE) %>%
#'   as_flextable() %>%
#'   hline(i=~soc=="" & soc!=dplyr::lead(soc))
#' ae_table_soc(ae, data_pat=enrolres, term=NULL, sort_by_count=FALSE) %>%
#'   as_flextable() %>%
#'   bold(i=~soc=="Eye disorders")
#' ae_table_soc(ae, data_pat=enrolres, term="aeterm", arm=NULL) %>%
#'   as_flextable() %>%
#'   highlight(i=~soc=="Hepatobiliary disorders", j="all_patients_Tot")
ae_table_soc = function(
    data_ae, ..., data_pat,
    measure=c("max", "sup", "eq"),
    group1="AESOC", group2=NULL,
    arm=NULL, 
    cols = c(grade="AEGR", subjid="SUBJID"),
    ae_groups = NULL,
    sort_by_count=TRUE, total=TRUE, showNA=TRUE, digits=0, warn_miss=FALSE
){
  
  dots = list(...)
  data_ae = if(has_name(dots, "df_ae")) dots$df_ae else data_ae
  data_pat = if(has_name(dots, "df_enrol")) dots$df_enrol else data_pat
  measure = if(has_name(dots, "variant")) dots$variant else measure
  group1 = if(has_name(dots, "soc")) dots$soc else group1
  group2 = if(has_name(dots, "term")) dots$term else group2
  cols = as.list(cols)
  cols$grade = if(has_name(dots, "grade")) dots$grade else cols$grade
  cols$subjid = if(has_name(dots, "subjid")) dots$subjid else cols$subjid
  check_dots_empty2(except = c("df_ae", "df_enrol", "variant", "soc", "term", "grade", "subjid"))
  cols$group1 = group1
  cols$group2 = group2
  cols$arm = arm

  # default_arm = set_label("All patients", "Treatment arm")
  null_group2 = is.null(group2)
  null_arm = is.null(arm)
  measure = arg_match(measure)

  #TODO check dans grstat actuel si un data_ae sans term provoque une erreur 
  # assert_names_exists(data_ae, keep_at(cols, c("subjid", "group1", "group2", "grade")))
  # assert_names_exists(data_pat, keep_at(cols, c("subjid", "arm")))

  label_missing_group1 = "Missing"
  label_missing_pat = "No Declared AE"

  if(measure!="max" && missing(total) && total){
    cli_warn("Total has been set to `FALSE` as totals are not very interpretable
             when {.arg measure} is {.val sup} or {.val eq}. Set `total=FALSE`
             explicitly to silence this warning.")
    total=FALSE
  }

  # data_ae = data_ae %>%
  #   select(subjid=any_of2(subjid), group1=any_of2(group1),
  #          group2=any_of2(group2), grade=any_of2(grade)) %>%
  #   mutate(group1 = if_else(group1 %in% c(0, NA), label_missing_group1, group1))
  # data_pat = data_pat %>%
  #   select(subjid=any_of2(subjid), arm=any_of2(arm)) %>%
  #   mutate(arm = if(is.null(.env$arm)) default_arm else .data$arm)
  # if(!is.numeric(data_ae$grade)){
  #   cli_abort("Grade ({.val {grade}}) should be a numeric column.")
  # }

  # df = data_pat %>%
  #   left_join(data_ae, by="subjid") %>%
  #   arrange(subjid) %>%
  #   mutate(
  #     arm = to_snake_case(arm),
  #     group1 = if_else(!subjid %in% data_ae$subjid, label_missing_pat, group1)
  #   )
  df = .data_ae_table_soc(data_ae, data_pat, cols)
  #Legacy
  # if(has_name(dots, "soc")) df$group1 = set_label(group1, "CTCAE SOC")
  # if(has_name(dots, "term")) df$group2 = set_label(group2, "CTCAE v4.0 Term")  

  #check missing data
  if(warn_miss){
    miss = names(df) %>% set_names() %>% map(~{
      df %>% filter(is.na(!!ensym(.x))) %>% pull(subjid) %>% unique() %>% sort()
    }) %>% keep(~!is_empty(.x))
    miss %>% iwalk(~{
      cli_warn("{.fn ae_table_soc}: Missing values in column {.val {.y}} for patients {.val {.x}}.",
               class="grstat_ae_missing_values_warning")
    })
  }

  # arm_count = data_pat %>%
  #   count(arm) %>%
  #   deframe() %>% as.list()
  # arm_count2 = arm_count %>%
  #   set_names(to_snake_case)
  arm_count = attr(df, "arm_count")  
  arm_count2 = arm_count %>% set_names(to_snake_case)

  extra_cols = if(total) c("Tot") else NULL
  
  default = list("G1"=1, "G2"=2, "G3"=3, "G4"=4, "G5"=5)
  if(isTRUE(showNA)) default[["NA"]] = NA
  ae_groups = .get_ae_groups(ae_groups, default=default)

  rtn = df %>%
    summarise(calc = .evaluate_grades(grade, measure, ae_groups),
              .by=any_of(c("subjid", "arm", "group1", "group2"))) %>%
    unnest(calc) %>%
    mutate(
      group1 = group1 %>% fct_infreq(w=Tot) %>%
        fct_last(label_missing_group1, label_missing_pat)
    ) %>%
    summarise(
      across(c(all_of(names(ae_groups)), any_of(extra_cols)), ~{
        n = sum(.x)
        n_arm = arm_count2[[cur_group()$arm]]
        label = glue("{n} ({p})", p=percent(n/n_arm, digits))
        label[n==0] = NA
        label
      }),
      .by=any_of(c("arm", "group1", "group2"))
    ) %>%
    arrange(arm, group1)

  if(!total) rtn = rtn %>% select(-any_of("Tot"))
  if(!showNA) rtn = rtn %>% select(-any_of("NA"))
  if(!sort_by_count) {
    rtn = rtn %>%
      mutate(across(any_of(c("group1", "group2")), ~factor(as.character(.x))),
             group1 = fct_relevel(group1, label_missing_pat, after=Inf)) %>%
      arrange(arm, group1)
  }

  spec = rtn %>%
    build_wider_spec(names_from=arm,
                     values_from=c(all_of(names(ae_groups)), any_of(c("NA", "Tot"))),
                     names_glue="{arm}__{.value}") %>%
    arrange(.name)


  #TODO use labels for group1 and group2, then in the flextable!
  rtn = rtn %>%
    rename(group1=group1, group2=any_of("group2")) %>%
    pivot_wider_spec(spec) %>%
    arrange(group1, pick(any_of("group2"))) %>%
    mutate(across(everything(), ~set_label(.x, cur_column()))) %>%
    rename_with(to_snake_case) %>%
    copy_label_from(df) %>% 
    add_class("ae_table_soc")

# print(get_label(rtn))
# browser()
  
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
#' @importFrom dplyr case_when lag mutate transmute
#' @importFrom flextable align bg bold flextable fontsize hline hline_bottom merge_h merge_v padding set_header_df set_table_properties valign
#' @importFrom rlang check_dots_empty
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
        col_keys == "group1" ~ "",
        col_keys == "group2" ~ "",
        .default = table_ae_header[h1]
      ),
      row2 = case_when(
        col_keys == "group1" ~ labels["group1"],
        col_keys == "group2" ~ labels["group2"],
        .default = h2
      ),
    )

  col1 = header_df$col_keys %in% c("group1", "group2") %>% which() %>% max()

  sep_cols = with(header_df, !col_keys %in% c("group1", "group2") & row1!=lead(row1)) %>%
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
  if (!is.null(x[["group2"]])) {
    b = structure(list(width=1, color="grey", style="solid"), class="fp_border")
    rtn = rtn %>%
      merge_v(j="group1") %>%
      valign(j="group1", valign="top") %>%
      hline(i=~group1!=dplyr::lead(group1), border=b)
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


#' @importFrom cli cli_abort
#' @importFrom dplyr arrange count if_else left_join mutate select
#' @importFrom tibble deframe
#' @noRd
#' @keywords internal
.data_ae_table_soc = function(data_ae, data_pat, cols){  
  label_missing_group1 = "Missing"
  label_missing_pat = "No Declared AE"
  default_arm = set_label("All patients", "Treatment arm")
  col_gp2 = if("group2" %in% names(cols)) "group2" else NULL
  col_arm = if("arm" %in% names(cols)) "arm" else NULL  
  cols_ae = c("subjid", "grade", "group1", col_gp2)
  cols_pat = c("subjid", col_arm)
  assert_names_exists(data_ae, cols[cols_ae])
  assert_names_exists(data_pat, cols[cols_pat])
  
  data_ae = data_ae %>%
    select(subjid=any_of2(cols$subjid), group1=any_of2(cols$group1),
           group2=any_of2(cols$group2), grade=any_of2(cols$grade)) %>%
    mutate(
      group1 = if_else(group1 %in% c(0, NA), label_missing_group1, group1) %>% copy_label_from(group1)
    )

  data_pat = data_pat %>%
    select(subjid=any_of2(cols$subjid), arm=any_of2(cols$arm)) %>%
    mutate(arm = if(is.null(cols$arm)) default_arm else .data$arm)
  if(!is.numeric(data_ae$grade)){
    cli_abort("Grade ({.val {grade}}) should be a numeric column.")
  }

  arm_count = data_pat %>%
    count(arm) %>%
    deframe() %>% as.list()

  rtn = data_pat %>%
    left_join(data_ae, by="subjid") %>%
    arrange(subjid) %>%
    mutate(
      arm = to_snake_case(arm),
      group1 = if_else(!subjid %in% data_ae$subjid, label_missing_pat, group1)
    ) %>% 
    copy_label_from(data_pat) %>% 
    copy_label_from(data_ae)

  # browser()
  attr(rtn, "arm_count") = arm_count

  rtn
}

#' for each patient/group, detect if each grade satisfies the specified
#' condition (max/eq/sup)
#' @importFrom purrr map_lgl
#' @importFrom rlang set_names
#' @importFrom tibble as_tibble_row
#' @importFrom tidyr replace_na
#' @noRd
#' @keywords internal
.evaluate_grades = function(gr, measure, ae_groups){
  inner_calc = switch(measure, max=~max_narm(gr) == .x,
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
#' @importFrom purrr map_lgl
#' @importFrom rlang is_named
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
