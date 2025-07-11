#' Results table from a Cox Model
#'
#' @param fit
#' @param label
#'
#' @return a flextable
#' @importFrom broom.helpers tidy_plus_plus
#' @importFrom dplyr arrange case_match case_when cur_group filter left_join mutate rename_with select summarise
#' @importFrom glue glue
#' @importFrom stringr str_remove str_starts str_subset
#' @importFrom flextable align bg bold flextable fontsize hline_bottom merge_h padding set_header_df set_table_properties
#' @importFrom tidyr unite
#' @export
xx=function(fit){
  df_cox <- tidy_plus_plus(fit, exponentiate = T, conf.int = T) %>%
    unite('n', n_event, n_obs, sep='/', remove=T) %>%
    mutate(p_new = format.pval(p.value, digits = 3, eps = 0.001, na.form = ''),
           HR = ifelse(is.na(conf.low),
                       '1.00',
                       glue("{format(round(estimate, 2), nsmall = 2)} [{round(conf.low, 2)} ; {round(conf.high, 2)}]"))) %>%
    select(var_label, label, n, HR, p.value, p_new)
  return(df_cox)
}


#' Title
#'
#' @param fit
#' @param label
#'
#' @return a string
#' @export
#'
#' @examples
report_coxph = function(fit, label){
  a = broom::tidy(fit, exponentiate=TRUE, conf.int=TRUE) %>%
    filter(term=="armTTT") %>%
    mutate(across(-term, ~round(.x, 2)))
  # a$estimate
  # fit$xlevels
  glue("The Hazard Ratio of treatment for {label} was {a$estimate} [95%CI {a$conf.low}; {a$conf.high}] (adjusted p-value: {a$p.value})")
}


