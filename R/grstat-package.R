
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

utils::globalVariables(
  c(".", ".data", ".env", ".id", ".name", "Tot", "aegr", "aesoc", "any_ae", "any_grade_sup_na",
    "any_severe", "arm_", "calc", "col_keys", "diff_first", "first_date", "arm", "rate", "aerel",
    "first_sum", "grade_", "h1", "h2", "label", "min_sum", "aegr_sae", "aeterm", "soc_weight",
    "n_ae", "n_arm", "n_severe", "name", "pct_ae", "pct_severe", "resp", "resp2", "resp_num",
    "sae", "severe_", "soc_", "subjid", "subjid_", "value", "variable", "weight", "x",
    "num_timepoints", "rc_num_timepoints", "rctlsum_b", "rc_sd_tlsum_noise", "delai", "details", "header x1",
    "percent_change_per_month", "changes", "base", "sizes", "rctlsum", "percent_change",
    "rctlmin", "rcvisit", "rcdt", "rctlresp", "rcntlresp", "rcnew", "rc_p_new_lesions", "not_evaluable",
    "rc_p_not_evaluable", "rcresp", "suivi", "arm3", "date_inclusion", "rc_p_nt_lesions", "data","rc_coef_treatement")
)
