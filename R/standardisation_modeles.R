#' Results table from a Cox Model
#'
#' @param cox_surv an object of class coxph 
#' @param arm name of the treatment column in `df_surv`. Case-insensitive. Can be set to `NULL`.
#' @param digits significant digits
#' @param pval which test to get the p-value from, defaults to wald
#'
#' @return a flextable
#' @importFrom broom.helpers tidy_plus_plus
#' @importFrom dplyr arrange case_match case_when cur_group filter left_join mutate rename_with select summarise
#' @importFrom glue glue
#' @importFrom survival coxph
#' @importFrom stringr str_remove str_starts str_subset
#' @importFrom flextable align bg bold flextable fontsize hline_bottom merge_h padding set_header_df set_table_properties
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
#' ae_table_grade(df_ae=ae, df_enrol=enrolres, arm="ARM") %>%
#'   as_flextable(header_show_n=TRUE)
#'
