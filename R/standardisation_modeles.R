#' Results table from a Cox Model
#'
#' @param fit an object of class coxph, output of the survival::coxph function
#'
#' @return an object of class regtable
#' @importFrom broom.helpers tidy_plus_plus
#' @importFrom dplyr arrange case_match case_when cur_group filter left_join mutate rename_with select summarise
#' @importFrom glue glue
#' @importFrom stringr str_remove str_starts str_subset
#' @importFrom tidyr unite
#' @export
#'
cox_regtable = function(fit){
  rtn = tidy_plus_plus(fit, exponentiate = T, conf.int = T) %>%
    unite('n', n_event, n_obs, sep='/', remove=T) %>%
    #On crée une p-value avec 3 chiffres sign. ou <0.001
    mutate(p_new = format.pval(p.value, digits = 3, eps = 0.001, na.form = ''),
           HR = ifelse(is.na(conf.low),
                       '1.00',
                       glue("{format(round(estimate, 2), nsmall = 2)} [{round(conf.low, 2)};{round(conf.high, 2)}]"))) %>%
    select(var_label, label, n, HR, p_new) %>%
    group_by(var_label) %>%
    mutate(rep = row_number()) %>%
    ungroup() %>%
    mutate(var_label = ifelse(rep > 1, '', var_label),
           label = ifelse(label == var_label, '', label)) %>%
    select(-rep) %>%
    add_class("regtable")

  attr(rtn, "header") =
    c(
      var_label = 'Variable',
      label = '',
      n = 'Number of events/N',
      HR = 'HR [95% CI]',
      p_new = 'p-value'
    )
  return(rtn)
}

#' Turns a `regtable` object into a formatted `flextable`
#'
#' @param x a dataframe, resulting of `cox_regtable()`
#' @param padding_v a numeric of lenght up to 2, giving the vertical padding of body (1) and header (2)
#' @param ... unused
#'
#' @return a formatted flextable
#' @rdname regtable
#' @export
#'
#' @importFrom dplyr case_match lag lead transmute
#' @importFrom flextable align bg bold flextable fontsize hline_bottom merge_h padding set_header_labels set_table_properties
#' @importFrom purrr map map_int
#' @importFrom rlang check_dots_empty set_names
#' @importFrom stringr str_detect str_replace_all
#' @importFrom tibble as_tibble_col
#' @importFrom tidyr separate_wider_regex
as_flextable.regtable = function(x,
                                     ...,
                                     padding_v = 10){
  check_dots_empty()
  table_reg_header = attr(x, "header")


  header_df = names(x) %>%
    as_tibble_col("col_keys") %>%
    separate_wider_regex(col_keys, c(h1 = ".*", "_", h2 = ".*"), too_few="align_start", cols_remove=FALSE) %>%
    transmute(
      col_keys
    )


  rtn = x %>%
    flextable() %>%
    set_header_labels(values = table_reg_header) %>%
    hline_bottom(part="header") %>%
    merge_h(part="header") %>%
    align(i=1, part="header", align="center") %>%
    align(j=seq('Variable'), part="all", align="right") %>%
    padding(padding.top=0, padding.bottom=0) %>%
    set_table_properties(layout="autofit") %>%
    fontsize(size=12, part="all") %>%
    bold(part="header")
  if (length(padding_v) >= 1) {
    rtn = padding(rtn, padding.top=padding_v[1], padding.bottom=padding_v[1], part="body")
  }
  if (length(padding_v) == 2) {
    rtn = padding(rtn, padding.top=padding_v[2], padding.bottom=padding_v[2], part="header")
  }

  rtn
}



#' Result sentence
#'
#' @param fit an object of class coxph, output of the survival::coxph function
#' @param label a string corresponding to the label for treatment
#' @param arm a string corresponding to the treatment arm variable name in the coxph
#'
#' @return a string
#' @export
report_coxph = function(fit, label, arm){

  a = broom::tidy(fit, exponentiate=TRUE, conf.int=TRUE) %>%
    filter(substr(term, 1, nchar(arm))==arm) %>%
    mutate(across(-term, ~round(.x, 2)))

  if(nrow(a) == 0){
    cli_abort("({.val {arm}}) is not present in given fit.")
  }

  glue("The Hazard Ratio of treatment for {label} was {a$estimate} [95%CI {a$conf.low}; {a$conf.high}] (adjusted p-value: {a$p.value})")
}


