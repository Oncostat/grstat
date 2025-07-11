
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
  "arm", "arm_", "arm3", "base", "calc", "changes", "col_keys",
  "currently", "data", "date_end_fu", "date_enrol", "date_inclusion",
  "decision", "decision_label", "delai", "diff_first", "dlt", "dose",
  "first_date", "first_sum", "grade_", "h1", "h2", "label", "min_sum",
  "n_ae", "n_arm", "n_dlt", "n_dlt_max", "n_dlt_min", "n_eval",
  "n_severe", "name", "not_evaluable", "num_timepoints", "pct_ae",
  "pct_severe", "percent_change", "percent_change_per_month", "rate",
  "rc_coef_treatement", "rc_num_timepoints", "rc_p_new_lesions",
  "rc_p_not_evaluable", "rc_p_nt_lesions", "rc_sd_tlsum_noise",
  "rcdt", "rcnew", "rcntlresp", "rcresp", "rctlmin", "rctlresp",
  "rctlsum", "rctlsum_b", "rcvisit", "resp", "resp_num", "resp2",
  "rows", "sae", "severe_", "sizes", "soc_", "soc_weight", "subjid",
  "subjid_", "suivi", "Tot", "value", "variable", "weight", "x"
)

# dput(sort(globals))
utils::globalVariables(globals)
