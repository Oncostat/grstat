#' Calculate BOR
#'
#' @description
#' The function `aggregate_recist_rates()` creates a summary table of recist for each possible response.
#' The resulting dataframe can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @param data A dataset containing longitudinal RECIST data in long format.
#' @param ... Not used. Ensures that only named arguments are passed.
#' @param derived_endpoints Character; Derived endpoints to compute from BOR. One or several of c("ORR", "CBR", "DCR"). See vignette("BOR") for endpoint definitions.
#'
#' @return a dataframe (`aggregate_recist_rates()`) or a flextable (`as_flextable()`).
#'
#' @importFrom dplyr select any_of all_of
#' @importFrom cli cli_abort
#' @export
#'
#' @examples
#' recist = grstat_example()$recist
#' recist %>%
#'  calc_best_response(rc_resp = "rcresp", rc_date = "rcdt",
#'                     subjid = "subjid", rc_sum = "rctlsum", confirmed = FALSE) %>%
#'  aggregate_recist_rates(derived_endpoints=c("ORR", "CBR", "DCR")) %>%
#'  as_flextable()
#' #It is also possible to use the confirmation method for the ORR
#' recist %>%
#'  calc_best_response(rc_resp = "rcresp", rc_date = "rcdt",
#'                     subjid = "subjid", rc_sum = "rctlsum", confirmed = TRUE) %>%
#'  aggregate_recist_rates(derived_endpoints=c("ORR")) %>%
#'  as_flextable()
#'
aggregate_recist_rates = function(data, ..., derived_endpoints=c("ORR", "CBR", "DCR")){
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

  ORR = CBR = DCR = data.frame()

  if("ORR" %in% derived_endpoints){
  ORR = recist %>%
    filter(best_response=="Complete response" | best_response=="Partial response") %>%
    count(best_response = "Objective Response Rate (ORR)") %>%
    mutate(p = round(n / total * 100, 1))
  }

  if("CBR" %in% derived_endpoints){
    CBR = recist %>%
      filter(best_response=="Complete response" | best_response=="Partial response" | six_months_confirmation) %>%
      count(best_response = "Clinical Benefit Rate (CBR)") %>%
      mutate(p = round(n / total * 100, 1))
  }

  if("DCR" %in% derived_endpoints){
    DCR = recist %>%
      filter(best_response=="Complete response" | best_response=="Partial response" | best_response=="Stable disease") %>%
      count(best_response = "Disease Control Rate (DCR)") %>%
      mutate(p = round(n / total * 100, 1))
  }

  summary_df = bind_rows(response_counts, ORR, CBR, DCR) %>%
    mutate(ic_95 = {
      ci = clopper_pearson_ci(n, total, CI = "two.sided", alpha = 0.05)
      glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
    },
    .by= best_response) %>%
    add_class("aggregate_recist_rates") %>%
    apply_labels(best_response = "Best Overall Response",
                 n = "Number of patient",
                 p = "Percentage",
                 ic_95 = "IC 95%") %>%
    structure(derived_endpoints=derived_endpoints, confirmed = confirmed, total = total)

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
  derived_endpoints = attr(x, "derived_endpoints")
  confirmed = attr(x, "confirmed")
  total = attr(x,"total")
  label_CP = "Clopper-Pearson (Exact) method was used for confidence interval"
  label_confirmed = "For CR & PR, confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response."
  label_ORR = "ORR was defined as the presence of a partial response (PR) or a complete response (CR)."
  label_CBR = "CBR was defined as the presence of a partial response (PR), a complete response (CR), or a stable disease (SD) lasting at least six months."
  label_DCR = "DCR was defined as the presence of a partial response (PR), a complete response (CR), or a stable disease (SD)."
  best_response_during_treatment =  x %>%
    flextable() %>%
    set_table_properties(layout="autofit") %>%
    bold(bold = TRUE, part = "header") %>%
    surround(i = 5, border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body") %>%
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
  if("ORR" %in% derived_endpoints){
    best_response_during_treatment =  best_response_during_treatment %>%
      bold(i = ~ best_response == "Objective Response Rate (ORR)", bold = TRUE, part = "body") %>%
      footnote( i = ~ best_response == "Objective Response Rate (ORR)", j = "best_response",
                value = as_paragraph(label_ORR),
                ref_symbols ="ORR", part = "body")
  }
  if("CBR" %in% derived_endpoints){
    best_response_during_treatment =  best_response_during_treatment %>%
      bold(i = ~ best_response == "Clinical Benefit Rate (CBR)", bold = TRUE, part = "body") %>%
      footnote( i = ~ best_response == "Clinical Benefit Rate (CBR)", j = "best_response",
                value = as_paragraph(label_CBR),
                ref_symbols ="CBR", part = "body")
  }
  if("DCR" %in% derived_endpoints){
    best_response_during_treatment =  best_response_during_treatment %>%
      bold(i = ~ best_response == "Disease Control Rate (DCR)", bold = TRUE, part = "body") %>%
      footnote( i = ~ best_response == "Disease Control Rate (DCR)", j = "best_response",
                value = as_paragraph(label_DCR),
                ref_symbols ="DCR", part = "body")
  }

  best_response_during_treatment %>%
    valign(valign = "bottom", part = "header")
}
