
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


# Global settings -----------------------------------------------------------------------------

#helper: copy-paste the CHECK output in a string, apply f(), and append to globalVariables()
f = function(x) x %>% stringr::str_squish() %>% str_replace_all("[ \n]", '", "') %>% cat('"', ., '"', sep="")

utils::globalVariables(
  c(".", ".data", ".env", ".id", ".name", ":=", "Tot", "add_class", "any_ae", "any_grade_sup_na",
    "any_of2", "any_severe", "arm_", "assert", "assert_names_exists", "calc", "col_keys",
    "copy_label_from", "fct_last", "fct_rev", "grade_", "grade_max", "h1", "h2", "label",
    "max_narm", "n_ae", "n_arm", "n_severe", "name", "pct_ae", "pct_severe", "scale_fill_manual",
    "set_label", "severe_", "showNA", "soc_", "sort_by_count", "subjid_", "to_snake_case",
    "value", "variable", "weight", "aegr", "aesoc", "assert_class", "assert_no_duplicate",
    "can_be_numeric", "dataset", "diff_first", "edc_data_warn", "edc_lookup", "fct_yesno",
    "first_date", "first_sum", "get_subjid_cols", "min_sum", "resp", "resp2", "resp_num",
    "sae", "subjid", "x")
)
