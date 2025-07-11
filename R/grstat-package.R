
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
  "arm_", "before_pd", "calc", "col_keys", "currently", "data",
  "date_dlt_end", "date_dlt_start", "date_inclusion", "decision",
  "decision_label", "diff_first", "dlt", "dose", "first_date",
  "first_sum", "grade_", "h1", "h2", "label", "min_sum", "n_ae",
  "n_arm", "n_dlt", "n_dlt_max", "n_dlt_min", "n_eval", "n_severe",
  "name", "pct_ae", "pct_severe", "rate", "rcdt", "rcnew", "rcntlresp",
  "rcntlyn", "rcresp", "rctlresp", "rctlsum", "rcvisit", "resp",
  "resp_num", "resp2", "rows", "sae", "severe_", "soc_", "soc_weight",
  "subj_delai", "subjid", "subjid_", "Tot", "value", "variable",
  "weight", "x"
)

# dput(sort(globals))
utils::globalVariables(globals)
