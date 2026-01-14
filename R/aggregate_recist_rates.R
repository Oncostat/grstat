#' Calculate BOR
#'
#' @description
#' The function `aggregate_recist_rates()` creates a summary table of recist for each possible response.
#' The resulting dataframe can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @param data A dataset containing longitudinal RECIST data in long format.
#' @param ... Not used. Ensures that only named arguments are passed.
#' @param rc_resp The column containing the RECIST response (e.g., `"CR"`, `"PR"`, `"SD"`, `"PD"`). Default is `"RCRESP"`.
#' @param rc_date The column containing the assessment date. Default is `"RCDT"`.
#' @param subjid The column containing the subject ID. Default is `"SUBJID"`.
#' @param confirmed Logical; if `TRUE`, use the cofirmation method to determine the best response. For CR & PR confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response.
#' @param show_CBR Logical; if `TRUE`, show the Clinical Best Response (CBR). CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date).
#'
#' @return a dataframe (`aggregate_recist_rates()`) or a flextable (`as_flextable()`).
#'
#' @importFrom dplyr select any_of all_of
#' @importFrom cli cli_abort
#' @importFrom crosstable crosstable
#' @export
#'
#' @examples
#' recist = grstat_example()$recist
#' recist %>%
#'  calc_best_response(rc_resp = "rcresp", rc_date = "rcdt",
#'                     subjid = "subjid", rc_sum = "rctlsum", confirmed = FALSE) %>%
#'  aggregate_recist_rates_2(show_CBR = FALSE) %>%
#'  as_flextable()
#' #It is also possible to use the confirmation method for the BOR
#' recist %>%
#'  calc_best_response(rc_resp = "rcresp", rc_date = "rcdt",
#'                     subjid = "subjid", rc_sum = "rctlsum", confirmed = TRUE) %>%
#'  aggregate_recist_rates_2(show_CBR = FALSE %>%
#'  as_flextable()
#'
#' #Or show the Clinical Benefice Rate
#' recist %>%
#'  calc_best_response(rc_resp = "rcresp", rc_date = "rcdt",
#'                     subjid = "subjid", rc_sum = "rctlsum", confirmed = TRUE) %>%
#'  aggregate_recist_rates_2(show_CBR = TRUE) %>%
#'  as_flextable()
aggregate_recist_rates = function(data, ..., show_CBR = FALSE){
  confirmed = attr(data, "confirmed")
  recist = data %>%
    distinct()

  if(length(recist$subjid) != length(data$subjid)){
    cli_abort(c("data should be in wide format relative to subjid",
                i="Please check that there is no duplicate"))
  }

  total = length(recist$subjid)
  response_counts = recist %>%
    count(best_response, .drop=FALSE) %>%
    mutate(p=round(n / sum(n) * 100, 1))

  BOR = recist %>%
    filter(overall_response==1) %>%
    count(best_response = "Best Overall Response (BOR)") %>%
    mutate(p = round(n / total * 100, 1))

  CBR = NULL
  if(show_CBR){
    CBR = recist %>%
      filter(clinical_benefit==1) %>%
      count(best_response = "Clinical Benefit Rate (CBR)") %>%
      mutate(p = round(n / total * 100, 1))
  }
  summary_df = bind_rows(response_counts, BOR, CBR) %>%
    mutate(ic_95 = {
      ci = clopper_pearson_ci(n, total, CI = "two.sided", alpha = 0.05)
      glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
    },
    .by= best_response) %>%
    add_class("aggregate_recist_rates") %>%
    structure(show_CBR=show_CBR, confirmed = confirmed, total = total)

  summary_df
}

#' Turns an `aggregate_recist_rates` object into a formatted `flextable`
#'
#' @param x a dataframe, resulting of `aggregate_recist_rates()`
#' @param ... unused
#'
#' @return a formatted flextable
#' @rdname aggregate_recist_rates
#' @export
#'
#' @importFrom flextable surround delete_rows footnote as_paragraph set_header_labels
#' @importFrom officer fp_border
as_flextable.aggregate_recist_rates = function(x, ...){
  check_dots_empty()
  show_CBR = attr(x, "show_CBR")
  confirmed = attr(x, "confirmed")
  total = attr(x,"total")
  label_CP = "Clopper-Pearson (Exact) method was used for confidence interval"
  label_confirmed = "For CR & PR, confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response."
  label_CBR = "CBR was defined as the presence of a partial response (PR), a complete response (CR), or a stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date)."
  best_response_during_treatment =  x %>%
    flextable() %>%
    set_table_properties(layout="autofit") %>%
    bold(bold = TRUE, part = "header") %>%
    surround(i = c(5, 6), border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body") %>%
    bold(i = 6, bold = TRUE, part = "body") %>%
    set_header_labels(n=paste0("N=",total), p = "%", ic_95 = "IC 95%") %>%
    footnote(j = "ic_95",
             value = as_paragraph(label_CP),
             ref_symbols ="*", part = "header")

    if (!confirmed){
    best_response_during_treatment =  best_response_during_treatment %>%
      set_header_labels(best_response="Unconfirmed Best Response during treatment")

    } else{
      best_response_during_treatment =  best_response_during_treatment %>%
      set_header_labels(best_response="Confirmed Best Response during treatment") %>%
      footnote(i = 1, j = "best_response",
                value = as_paragraph(label_confirmed),
                ref_symbols =c("**"), part = "header")
      }

    if(show_CBR){
    best_response_during_treatment =  best_response_during_treatment %>%
      bold(i = 7, bold = TRUE, part = "body") %>%
      footnote( i = 7, j = "best_response",
                value = as_paragraph(label_CBR),
                ref_symbols = "***", part = "body")
    }

  best_response_during_treatment %>%
    valign(valign = "bottom", part = "header")
}
