
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
    "any_severe", "arm_", "calc", "col_keys", "diff_first", "first_date",
    "first_sum", "grade_", "h1", "h2", "label", "min_sum",
    "n_ae", "n_arm", "n_severe", "name", "pct_ae", "pct_severe", "resp", "resp2", "resp_num",
    "sae", "severe_", "soc_", "subjid", "subjid_", "value", "variable", "weight", "x")
)
