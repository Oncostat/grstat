
#TODO min_percent=1 -> n minimal for percents ?
#TODO total by arm OK, total total aussi?
#TODO vline dans as_flextable ?

#' Summary tables for AE by SOC
#'
#' The function `ae_table_soc()` creates a summary table of maximum AE grades for each patient according to term and SOC CTCAE.
#' The resulting dataframe can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @param df_ae adverse event dataset, one row per AE, containing subjid, soc, and grade.
#' @param df_enrol enrollment dataset, one row per patient, containing subjid (and arm if needed). All patients should be in this dataset.
#' @param variant one or several of `c("max", "sup", "eq")`. `max` computes the maximum AE grade per patient, `sup` computes the number of patients having experienced at least one AE of grade higher or equal to X, and `eq` computes the number of patients having experienced at least one AE of grade equal to X.
#' @param arm name of the treatment column in `df_enrol`. Case-insensitive. Can be set to `NULL`.
#' @param term name of the the CTCAE term column in `df_ae`. Case-insensitive. Can be set to `NULL`.
#' @param sort_by_count should the table be sorted by the number of AE or by SOC alphabetically.
#' @param total whether to add a `total` column for each arm.
#' @param showNA whether to display missing grades.
#' @param digits significant digits for percentages.
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
#' @importFrom cli cli_warn
#' @importFrom dplyr across any_of arrange count cur_group filter left_join if_else mutate pull rename select summarise
#' @importFrom forcats fct_infreq
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
#' ae_table_soc(df_ae=tm$ae, df_enrol=tm$enrolres, term=NULL)
#' ae_table_soc(df_ae=tm$ae, df_enrol=tm$enrolres, term=NULL, arm=NULL)
#'
#' if (require("flextable")) {
#'
#' #the resulting flextable can be customized using the flextable package
#' ae_table_soc(tm$ae, df_enrol=tm$enrolres, total=FALSE) %>%
#'   as_flextable() %>%
#'   hline(i=~soc=="" & soc!=dplyr::lead(soc))
#' ae_table_soc(tm$ae, df_enrol=tm$enrolres, term=NULL, sort_by_count=FALSE) %>%
#'   as_flextable() %>%
#'   bold(i=~soc=="Eye disorders")
#' ae_table_soc(tm$ae, df_enrol=tm$enrolres, term=NULL, arm=NULL) %>%
#'   as_flextable() %>%
#'   highlight(i=~soc=="Hepatobiliary disorders", j="all_patients_Tot")
#' }
ae_table_soc = function(
    df_ae, ..., df_enrol,
    variant=c("max", "sup", "eq"),
    arm=NULL, term=NULL,
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
             when {.arg variant} is {.val sup} or {.val eq}. Set `total=TRUE`
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
               class="edc_ae_missing_values_warning")
    })
  }

  arm_count = df_enrol %>%
    count(arm_) %>%
    deframe() %>% as.list()
  arm_count2 = arm_count %>%
    set_names(to_snake_case)

  rtn = df %>%
    summarise(calc = evaluate_grades(grade_, variant),
              .by=any_of(c("subjid_", "arm_", "soc_", "term_"))) %>%
    unnest(calc) %>%
    mutate(soc_ = soc_ %>% fct_infreq(w=Tot) %>%
             fct_last(label_missing_soc, label_missing_pat)) %>%
    summarise(
      across(c(matches("^G\\d$"), any_of(c("NA", "Tot"))), ~{
        n = sum(.x)
        n_arm = arm_count2[[cur_group()$arm_]]
        label = glue("{n} ({p})", p=percent(n/n_arm, digits))
        label[n==0] = NA
        label
      }),
      .by=any_of(c("arm_", "soc_", "term_"))
    ) %>%
    arrange(arm_, soc_)

  if(!total) rtn = rtn %>% select(-Tot)
  if(!showNA) rtn = rtn %>% select(-"NA")
  if(!sort_by_count) rtn = rtn %>% mutate(soc_=as.character(soc_)) %>% arrange(arm_, soc_)

  spec = rtn %>%
    build_wider_spec(names_from=arm_,
                     values_from=c(matches("^G\\d$"), any_of(c("NA", "Tot"))),
                     names_glue="{arm_}_{.value}") %>%
    arrange(.name)
  rtn = rtn %>%
    rename(soc=soc_) %>%
    pivot_wider_spec(spec) %>%
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
#'
#' @return a formatted flextable
#' @rdname ae_table_soc
#' @exportS3Method flextable::as_flextable
#'
#' @importFrom dplyr case_match lag lead transmute
#' @importFrom purrr map map_int
#' @importFrom rlang check_installed set_names
#' @importFrom stringr str_detect str_replace_all
#' @importFrom tibble as_tibble_col
#' @importFrom tidyr separate_wider_regex
as_flextable.ae_table_soc = function(x,
                                     arm_colors=c("#f2dcdb", "#dbe5f1", "#ebf1dd", "#e5e0ec"),
                                     padding_v = NULL){
  check_installed("flextable")
  if (missing(padding_v)) padding_v = getOption("crosstable_padding_v", padding_v)
  table_ae_header = attr(x, "header")
  if(FALSE){
    arm_cols = names(table_ae_header) %>% set_names() %>%
      map_int(~{
        pattern = paste0("^", .x, "_(G\\d|NA|Tot)$")
        sum(str_detect(names(x), pattern))
      })
    table_ae_header = table_ae_header[arm_cols>0]
    arm_cols = arm_cols[arm_cols>0]

    col1 = names(x) %>% str_detect(names(table_ae_header)[1]) %>% which() %>% min() - 1
    colwidths = c(col1, arm_cols)
    header_labels = set_names(names(x)) %>% map(~str_replace_all(.x, ".*_", ""))
    header_labels$soc = "CTCAE SOC"
    header_labels$term = "CTCAE v4.0 Term"
  }
  # https://github.com/tidyverse/tidyr/issues/1551
  header_df = names(x) %>%
    as_tibble_col("col_keys") %>%
    separate_wider_regex(col_keys, c(h1 = ".*", "_", h2 = ".*"), too_few="align_start", cols_remove=FALSE) %>%
    transmute(
      col_keys,
      row1 = case_match(h1,
                        "soc" ~ "",
                        "term" ~ "",
                        .default=table_ae_header[h1]),
      row2 = case_match(h1,
                        "soc" ~ "CTCAE SOC",
                        "term" ~ "CTCAE v4.0 Term",
                        .default=h2)
    )

  col1 = header_df$col_keys %in% c("soc", "term") %>% which() %>% max()

  sep_cols = with(header_df, !col_keys %in% c("soc", "term") & row1!=lead(row1)) %>%
    which() %>% unname() %>% c(ncol(x))

  rtn = x %>%
    flextable::flextable() %>%
    flextable::set_header_df(mapping=header_df) %>%
    # flextable::hline_top(part="header") %>%
    flextable::hline_bottom(part="header") %>%
    flextable::merge_h(part="header") %>%
    # flextable::set_header_labels(values=header_labels) %>%
    # flextable::add_header_row(values=c(" ", table_ae_header), colwidths = colwidths) %>%
    flextable::align(i=1, part="header", align="center") %>%
    flextable::align(j=seq(col1), part="all", align="right") %>%
    flextable::padding(padding.top=0, padding.bottom=0) %>%
    flextable::set_table_properties(layout="autofit") %>%
    flextable::fontsize(size=8, part="all") %>%
    flextable::bold(part="header")
  if (length(padding_v) >= 1) {
    rtn = flextable::padding(rtn, padding.top=padding_v[1], padding.bottom=padding_v[1], part="body")
  }
  if (length(padding_v) == 2) {
    rtn = flextable::padding(rtn, padding.top=padding_v[2], padding.bottom=padding_v[2], part="header")
  }
  # a = cumsum(colwidths)[-1]
  a = sep_cols
  for(i in seq_along(a)){
    from = lag(a, default=col1)[i] + 1
    to = a[i]
    rtn = rtn %>% flextable::bg(j=seq(from, to), bg = arm_colors[i], part="all")
  }

  rtn
}


#' Graphic representation of AEs by soc (Butterfly plot)
#'
#' Produces a graphic representation of AE, counting the maximum grade each patient experienced, colored by treatment arm. Returns up to 3 representations if `arm!=NULL`.
#'
#' The function `butterfly_plot()` creates a summary table of the maximum AE grade experienced per each patient.
#' The resulting crosstable can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @inheritParams ae_table_soc
#' @inherit ae_table_soc seealso
#' @param severe name of the logical column in `df_ae` telling whether an AE is severe. Case-insensitive.
#' @param sort_by either "total" or "severe"
#' @param range_min The minimum value for the upper limit of the x-axis range. Set to `1` to always include 100%.
#'
#' @return a crosstable (dataframe)
#' @export
#' @importFrom cli cli_abort cli_warn
#' @importFrom dplyr any_of arrange count filter left_join mutate select summarise
#' @importFrom forcats fct_reorder
#' @importFrom ggplot2 aes facet_grid geom_blank geom_col ggplot labs scale_x_continuous theme unit vars
#' @importFrom glue glue
#' @importFrom rlang arg_match check_dots_empty
#' @importFrom scales label_percent
#' @importFrom stats na.omit
#' @importFrom stringr str_remove
#' @importFrom tibble lst
#'
#' @examples
#'
#' tm = grstat_example(N=100)
#' attach(tm, warn.conflicts=FALSE)
#'
#' ae2 = ae %>%
#'   dplyr::mutate(serious = sae=="Yes")
#'
#' ae2 %>%
#'   butterfly_plot(df_enrol=enrolres, range_min=0.5)
#'
#' ae2 %>%
#'   butterfly_plot(df_enrol=enrolres, severe="serious") +
#'   ggplot2::labs(caption="Darker areas represent Serious Adverse Events")
butterfly_plot = function(
    df_ae, ..., df_enrol, severe=NULL, sort_by=c("total", "severe"), range_min=NULL,
    arm="ARM", subjid="SUBJID", soc="AESOC"
){
  check_dots_empty()
  sort_by = arg_match(sort_by)

  assert_names_exists(df_ae, lst(subjid, soc, severe))
  assert_names_exists(df_enrol, lst(subjid, arm))

  df_ae = df_ae %>%
    select(subjid_=any_of2(subjid), soc_=any_of2(soc),
           severe_=any_of2(severe)) %>%
    mutate(severe_ = if(is.null(severe)) NA else severe_)
  df_enrol = df_enrol %>%
    select(subjid_=any_of2(subjid), arm_=any_of2(arm))
  df = df_enrol %>%
    left_join(df_ae, by="subjid_") %>%
    filter(!is.na(soc_))  %>%
    arrange(subjid_)

  if(!is.factor(df_enrol$arm_)) df_enrol$arm_ = factor(df_enrol$arm_)

  arms = df_enrol$arm_ %>% unique() %>% na.omit()
  if(length(arms)!=2){
    cli_abort(c("{.fn EDCimport::butterfly_plot} needs exactly 2 arms.",
                i="Arms: {.val {arms}}"),
              class="edc_butterfly_two_arms_error")
  }
  if(!is.null(severe)){
    if(!is.logical(df_ae$severe_)){
      cli_abort(c("{.arg severe} should be a logical column, not a {.type {df_ae$severe_}}. Did you forget to mutate it with `==`?"),
                class="edc_butterfly_serious_lgl_error")
    }
    if(!any(df_ae$severe_)){
      cli_warn(c("All {.arg severe} values are FALSE."),
               class="edc_butterfly_serious_false_warning")
    }
  }

  df_arm = df_enrol %>%
    count(arm_, name="n_arm") %>%
    mutate(label=glue("{arm_} (N={n_arm})") %>% fct_reorder(as.numeric(arm_)))
  left_arm = levels(arms)[1]

  a = df %>%
    summarise(any_ae = TRUE,
              any_severe = any(severe_, na.rm=TRUE),
              .by=any_of(c("subjid_", "arm_", "soc_"))) %>%
    summarise(n_ae = sum(any_ae, na.rm=TRUE),
              n_severe = sum(any_severe, na.rm=TRUE),
              .by=any_of(c("arm_", "soc_"))) %>%
    left_join(df_arm, by="arm_") %>%
    mutate(
      n_ae = n_ae * ifelse(arm_==left_arm, -1, 1),
      n_severe = n_severe * ifelse(arm_==left_arm, -1, 1),
      pct_ae = n_ae/n_arm,
      pct_severe = n_severe/n_arm,
      soc_ = fct_reorder(soc_, abs(pct_ae), .fun=max, .na_rm=TRUE),
    )

  a %>% arrange(soc_)
  a %>% arrange(abs(pct_ae))
  if(sort_by=="severe") a$soc_ = fct_reorder(a$soc_, abs(a$pct_severe), .fun=max)

  label_percent_positive = \(x) label_percent()(x) %>% str_remove("-")

  layer_blank = NULL
  if(!is.null(range_min)){
    data_blank = a %>% summarise(pct_ae = ifelse(arm_==left_arm, -range_min, range_min),
                                 .by=c(label, soc_))
    layer_blank = geom_blank(aes(x=pct_ae), data=data_blank)
  }
  layer_severe = NULL
  if(!is.null(severe)){
    layer_severe = geom_col(aes(x=pct_severe), color="grey40", width=0.6)
  }

  a %>%
    ggplot(aes(y=soc_, fill=label)) +
    geom_col(aes(x=pct_ae), alpha=0.6) +
    layer_severe +
    layer_blank +
    scale_x_continuous(labels=label_percent_positive) +
    facet_grid(cols=vars(label), scales="free_x") +
    labs(y=NULL, fill=NULL, x="Proportion of patients presenting at least 1 adverse event") +
    theme(
      legend.position="none",
      panel.spacing.x=unit(1, "mm")
    )
}


#' @rdname butterfly_plot
#' @usage ae_plot_soc(df_ae, ..., df_enrol, severe, sort_by, range_min, arm, subjid, soc)
#' @export
ae_plot_soc = butterfly_plot


# Utils ---------------------------------------------------------------------------------------


#' for each patient/soc, detect if each grade satisfies the specified
#' condition (max/eq/sup)
#' @importFrom purrr map_lgl
#' @importFrom rlang set_names
#' @importFrom tibble as_tibble_row
#' @importFrom tidyr replace_na
#' @noRd
#' @keywords internal
evaluate_grades = function(gr, variant){
  inner_calc = switch(variant, max=~max_narm(gr) == .x,
                      sup=~any(gr >= .x, na.rm=TRUE),
                      eq=~any(gr == .x, na.rm=TRUE))
  n = c(1:5) %>% set_names(paste0("G",1:5)) %>% map_lgl(inner_calc)
  n_na = c("NA"=all(is.na(n)))
  n = replace_na(n, FALSE)
  n_tot = c(Tot=sum(c(n, n_na), na.rm=TRUE))
  c(n, n_na, n_tot) %>%
    as_tibble_row()
}
