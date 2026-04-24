

#' Graphic representation of AEs by CTCAE SOC
#'
#' Produces a graphic representation of AEs by CTCAE SOC.
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
#' @importFrom dplyr across any_of arrange count filter left_join mutate n_distinct select summarise
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
#' butterfly_plot(ae2, df_enrol=enrolres, range_min=0.5)
#' butterfly_plot(ae2, df_enrol=head(enrolres,9), range_min=0.5)
#'
#' ae2 %>%
#'   butterfly_plot(df_enrol=enrolres, severe="serious") +
#'   ggplot2::labs(caption="Darker areas represent Serious Adverse Events")
butterfly_plot = function(
    df_ae, ..., df_enrol, severe=NULL, sort_by=c("total", "severe"), range_min=NULL,
    arm="ARM", subjid="SUBJID", soc="AESOC"
){
  check_dots_empty()
  assert_not_null(df_ae, df_enrol, sort_by, subjid, soc)
  assert_names_exists(df_ae, lst(subjid, soc, severe))
  assert_names_exists(df_enrol, lst(subjid, arm))
  sort_by = arg_match(sort_by)

  df_ae = df_ae %>%
    select(subjid_=any_of2(subjid), soc_=any_of2(soc),
           severe_=any_of2(severe)) %>%
    mutate(severe_ = if(is.null(severe)) NA else severe_)
  df_enrol = df_enrol %>%
    mutate(across(any_of2(arm), factor)) %>%
    select(subjid_=any_of2(subjid), arm_=any_of2(arm))

  arms = df_enrol[["arm_"]]
  n_arms = n_distinct(arms, na.rm=TRUE)
  if(n_arms!=2){
    if(is.null(arms)) arms = "NULL"
    cli_abort(c("{.fn grstat::butterfly_plot} needs exactly 2 arms.",
                i="Found {n_arms} arm{?s} in column {.arg {arm}}: {.val {unique(arms)}}"),
              class="grstat_butterfly_two_arms_error")
  }

  arm_na = sum(is.na(arms))
  if(arm_na > 0){
    cli_abort(c("{.fn grstat::butterfly_plot} found {arm_na} missing value{?s} in {.arg arm}.",
                i = "Missing values are not allowed. Use `tidyr::drop_na({arm})` to remove them."),
              class="grstat_butterfly_arm_na_error")
  }

  df = df_enrol %>%
    left_join(df_ae, by="subjid_") %>%
    filter(!is.na(soc_))  %>%
    arrange(subjid_)

  if(!is.factor(df_enrol$arm_)) df_enrol$arm_ = factor(df_enrol$arm_)

  arms = df_enrol$arm_ %>% unique() %>% na.omit()
  if(length(arms)!=2){
    cli_abort(c("{.fn grstat::butterfly_plot} needs exactly 2 arms.",
                i="Arms: {.val {arms}}"),
              class="grstat_butterfly_two_arms_error")
  }
  if(!is.null(severe)){
    if(!is.logical(df_ae$severe_)){
      cli_abort(c("{.arg severe} should be a logical column, not a {.type {df_ae$severe_}}. Did you forget to mutate it with `==`?"),
                class="grstat_butterfly_serious_lgl_error")
    }
    if(!any(df_ae$severe_)){
      cli_warn(c("All {.arg severe} values are FALSE."),
               class="grstat_butterfly_serious_false_warning")
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

  label_percent_positive = function(x) label_percent()(x) %>% str_remove("-")

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
