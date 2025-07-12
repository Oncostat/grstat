
#' @keywords internal
#' @importFrom rlang %||% :=
#' @importFrom cli qty col_green col_red
#' @importFrom lifecycle deprecated
"_PACKAGE"


# Reexports -----------------------------------------------------------------------------------

#' @importFrom dplyr %>%
#' @export
dplyr::`%>%`

#' @importFrom tibble tibble
#' @export
tibble::tibble

#' @importFrom flextable as_flextable
#' @export
flextable::as_flextable

# Global settings -----------------------------------------------------------------------------

#helper: copy-paste the CHECK output in a string, apply f(), and append to globalVariables()
f = function(x) x %>% stringr::str_squish() %>% str_replace_all("[ \n]", '", "') %>% cat('"', ., '"', sep="")


globals = c(
  ".", ".data", ".env", ".id", ".name", "aegr", "aerel", "aesoc",
  "aeterm", "any_ae", "any_grade_sup_na", "any_severe", "arm",
  "arm_", "baseline", "baseline_rc_date", "before_pd", "calc",
  "code", "col_keys", "currently", "data", "date_dlt_end", "date_dlt_start",
  "date_inclusion", "decision", "decision_label", "details", "diff_abs_nad",
  "diff_first", "diff_rel_bl", "diff_rel_nad", "dlt", "dose", "first_cr",
  "first_date", ".first_pd", "first_sum", "global_resp", "global_resp_check",
  "global_resp_num", "grade_", "h1", "h2", "header", "label", "level",
  "min_sum", "n_ae", "n_arm", "n_dlt", "n_dlt_max", "n_dlt_min",
  "n_eval", "n_severe", "n_sites", "n_subjid", "name", "new_lesion",
  "new_lesions", "non_measurable_lesion", "non_measurable_node",
  "nontarget_resp", "nontarget_resp_num", "nontarget_yn", "pct_ae",
  "pct_severe", "post_pd", "rate", "rc_date", "rcdt", "rcnew",
  "rcntlresp", "rcntlyn", "rcresp", "rctlresp", "rctlsum", "rcvisit",
  "real_target_sum_min", "remaining_lesion", "remaining_node",
  "resp", "resp_num", "resp2", ".response_num", "response_num", "response_value",
  "rows", "sae", "severe_", "soc_", "soc_weight", "subj_delai",
  "subjid", "subjid_", "sum_bl", "sum_nadir", "target_diam", "target_diam_sum",
  "target_is_node", "target_method", "target_resp", "target_resp_num",
  "target_site", "target_sum", "target_sum_bl", "target_sum_bl_real",
  "target_sum_min", "Tot", "value", "variable", "weight", "x",
  "x1", "best_response", "color", "diff_min", "response", "y"
)

# dput(sort(unique(globals)))
utils::globalVariables(globals)
