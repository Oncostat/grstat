#' Calculate ORR
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
#' @param cycle_length Numeric, Time between two cycle (used for confirmation), default = 28 days following PharmaSUG 2023 – Paper QT047 recommendation
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
#' df = grstat_example()
#' recist = df$recist
#'
#' aggregate_recist_rates(recist)
#'
#' #the resulting data.frame can be customized using as_flextable()
#' aggregate_recist_rates(recist) %>%
#'   as_flextable()
#' #Is also possible to use the confirmation method for the ORR
#' aggregate_recist_rates(recist, confirmed = TRUE) %>%
#'   as_flextable()
#'
#' #Or show the Clinical Benefice Rate
#' aggregate_recist_rates(recist, show_CBR = TRUE) %>%
#'   as_flextable()
aggregate_recist_rates = function(data, ..., rc_resp="RCRESP", rc_date="RCDT",
                     subjid="SUBJID", confirmed = FALSE, show_CBR = FALSE, cycle_length =28){
  recist = calc_best_response(data, rc_resp=rc_resp, rc_date=rc_date,
                              subjid=subjid, confirmed = confirmed, cycle_length = cycle_length)

  if(length(unique(recist$subjid)) != length(recist$subjid)){
    cli_abort(c("data should be in wide format relative to subjid",
                i="Please check that there is no duplicate"))
  }


  total = length(recist$subjid)
  response_counts = recist %>%
    count(best_response, .drop=FALSE) %>%
    mutate(p=round(n / sum(n) * 100, 1))

  ORR = recist %>%
    filter(overall_response==1) %>%
    summarise(best_response = "Overall Response Rate (ORR)", n = n()) %>%
    mutate(p = round(n / total * 100, 1))

  CBR = NULL
  if(show_CBR){
    CBR = recist %>%
      filter(clinical_benefit==1) %>%
      summarise(best_response = "Clinical Benefit Rate (CBR)", n = n()) %>%
      mutate(p = round(n / total * 100, 1))
  }
  summary_df = bind_rows(ORR, response_counts, CBR) %>%
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
  LABEL_CP = "Clopper-Pearson (Exact) method was used for confidence interval"
  LABEL_CONFIRMED = "For CR & PR confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response."
  LABEL_CBR = "CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date)."
  Best_Response_during_treatment =  x %>%
    flextable() %>%
    set_table_properties(layout="autofit") %>%
    delete_rows(i = 1, part = "footer") %>%
    bold(bold = TRUE, part = "header") %>%
    surround(i = c(1, 6), j = 1:4, border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body")

    if (!confirmed){
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      set_header_labels(best_response="Unconfirmed Best Response during treatment", n=paste0("N=",total), p = "%", ic_95 = "IC 95%") %>%
      footnote(i = 1, j = 4,
                value = as_paragraph(LABEL_CP),
                ref_symbols ="*", part = "header") %>%
      valign(valign = "bottom", part = "header")
    } else{
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
      set_header_labels(best_response="Confirmed Best Response during treatment", n=paste0("N=",total), p = "%", ic_95 = "IC 95%") %>%
      footnote(i = 1, j = c(4, 1),
                value = as_paragraph(c(LABEL_CP, LABEL_CONFIRMED)),
                ref_symbols =c("*", "1"), part = "header") %>%
      valign(valign = "bottom", part = "header")
      }

  if (!show_CBR){
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      bold(i = 1, j = c(1:4), bold = TRUE, part = "body")
  } else if(show_CBR & confirmed){
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      bold(i = c(1, 7), j = c(1:4), bold = TRUE, part = "body") %>%
      footnote( i = 7, j = 1,
                value = as_paragraph(LABEL_CBR),
                ref_symbols = "2", part = "body") %>%
      valign(valign = "bottom", part = "header")
  } else{
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      bold(i = c(1, 7), j = c(1:4), bold = TRUE, part = "body") %>%
      footnote( i = 7, j = 1,
                value = as_paragraph(LABEL_CBR),
                ref_symbols = "1", part = "body") %>%
      valign(valign = "bottom", part = "header")
  }
  Best_Response_during_treatment
}


#' @examples
#' df = grstat_example()
#' recist %>%
#'  calc_best_response(rc_resp="RCRESP", rc_date="RCDT",
#'                     subjid="SUBJID", confirmed = FALSE) %>%
#'  aggregate_recist_rates_2(show_CBR = FALSE, cycle_length =28) %>%
#'  as_flextable()
#' #Is also possible to use the confirmation method for the ORR
#' recist %>%
#'  calc_best_response(rc_resp="RCRESP", rc_date="RCDT",
#'                     subjid="SUBJID", confirmed = TRUE) %>%
#'  aggregate_recist_rates_2(show_CBR = FALSE, cycle_length =28) %>%
#'  as_flextable()
#'
#' #Or show the Clinical Benefice Rate
#' recist %>%
#'  calc_best_response(rc_resp="RCRESP", rc_date="RCDT",
#'                     subjid="SUBJID", confirmed = TRUE) %>%
#'  aggregate_recist_rates_2(show_CBR = TRUE, cycle_length =28) %>%
#'  as_flextable()
aggregate_recist_rates_2 = function(data, ..., show_CBR = FALSE, cycle_length =28){
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

  ORR = recist %>%
    filter(overall_response==1) %>%
    summarise(best_response = "Overall Response Rate (ORR)", n = n()) %>%
    mutate(p = round(n / total * 100, 1))

  CBR = NULL
  if(show_CBR){
    CBR = recist %>%
      filter(clinical_benefit==1) %>%
      summarise(best_response = "Clinical Benefit Rate (CBR)", n = n()) %>%
      mutate(p = round(n / total * 100, 1))
  }
  summary_df = bind_rows(ORR, response_counts, CBR) %>%
    mutate(ic_95 = {
      ci = clopper_pearson_ci(n, total, CI = "two.sided", alpha = 0.05)
      glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
    },
    .by= best_response) %>%
    add_class("aggregate_recist_rates") %>%
    structure(show_CBR=show_CBR, confirmed = confirmed, total = total)

  summary_df
}
