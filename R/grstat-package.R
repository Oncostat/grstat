
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
  ".", ".data", ".env", ".id", ".name", "aegr", "aegr_sae", "aerel",
  "aesoc", "aeterm", "any_ae", "any_grade_sup_na", "any_severe",
  "arm", "arm_", "arm3", "base", "baseline", "baseline_rc_date",
  "best_response", "calc", "changes", "code", "col_keys", "color",
  "data", "date_inclusion", "delai", "diff_abs_nad", "diff_first",
  "diff_min", "diff_rel_bl", "diff_rel_nad", "first_cr", "first_date",
  "first_pd", "first_sum", "global_resp", "global_resp_check",
  "global_resp_num", "grade_", "h1", "h2", "label", "level", "min_sum",
  "n_ae", "n_arm", "n_severe", "n_sites", "n_subjid", "name", "new_lesion",
  "new_lesions", "non_measurable_lesion", "non_measurable_node",
  "nontarget_resp", "nontarget_resp_num", "nontarget_yn", "not_evaluable",
  "num_timepoints", "pct_ae", "pct_severe", "percent_change", "percent_change_per_month",
  "post_pd", "rate", "rc_coef_treatement", "rc_date", "rc_num_timepoints",
  "rc_p_new_lesions", "rc_p_not_evaluable", "rc_p_nt_lesions",
  "rc_sd_tlsum_noise", "rcdt", "rcnew", "rcntlresp", "rcresp",
  "rctlmin", "rctlresp", "rctlsum", "rctlsum_b", "rcvisit", "real_target_sum_min",
  "remaining_lesion", "remaining_node", "resp", "resp_num", "resp2",
  "response", "response_num", "response_value", "sae", "severe_",
  "sizes", "soc_", "soc_weight", "subjid", "subjid_", "suivi",
  "sum_bl", "sum_nadir", "target_diam", "target_diam_sum", "target_is_node",
  "target_method", "target_resp", "target_resp_num", "target_site",
  "target_sum", "target_sum_bl", "target_sum_bl_real", "target_sum_min",
  "target_sum_real", "Tot", "value", "variable", "weight", "x", "y"
)

# dput(sort(unique(globals)))
utils::globalVariables(globals)
