#' Calculate BOR
#'
#' `r lifecycle::badge("experimental")`\cr
#' The function `aggregate_recist_rates()` creates a summary table of recist for each possible response.
#' The resulting dataframe can be piped to `as_flextable()` to get a nicely formatted flextable.
#'
#' @param data A dataset containing longitudinal RECIST data in long format.
#' @param ... Not used. Ensures that only named arguments are passed.
#' @param derived_endpoints Character; Derived endpoints to compute from BOR. One or several of c("ORR", "CBR", "DCR"). See vignette("BOR") for endpoint definitions.
#'
#' @return a dataframe (`aggregate_recist_rates()`) or a flextable (`as_flextable()`).
#'
#' @importFrom cli cli_abort
#' @importFrom glue glue
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
aggregate_recist_rates = function(data, ..., derived_endpoints=c("ORR", "CBR", "DCR"), data_arm = NULL, cols_arm = c(subjid="subjid",arm="arm")){

  assert_names_exists(data, c("best_response", "six_months_confirmation", "subjid"))
  if(!is.null(data_arm)) {assert_class(data_arm, class="data.frame")}
  if(!is.null(data_arm)) {assert_names_exists(data_arm, cols_arm)}

  if(anyDuplicated(data$subjid)){
    cli_abort(c("data should be in wide format relative to subjid",
                i="Please check that there is no duplicate"))
  }


  confirmed = attr(data, "confirmed")
  best_response_label = c("Complete response","Partial response", "Stable disease", "Progressive disease", "Not evaluable")
  if(!is.null(data_arm)){
    recist = data %>%
      mutate(six_months_confirmation = as.logical(six_months_confirmation),
             best_response = factor(best_response,
                                    levels = best_response_label)) %>%
      left_join(data_arm, by = "subjid")

    response_counts = recist %>%
      group_by(arm) %>%
      count(best_response, .drop = FALSE) %>%
      mutate(p = round(n / sum(n) * 100, 1))

  }
  else{
    recist = data %>%
      mutate(six_months_confirmation = as.logical(six_months_confirmation),
             best_response = factor(best_response,
                                    levels = best_response_label),
             arm= "All patient")

    response_counts = recist %>%
      group_by(arm) %>%
      count(best_response, .drop=FALSE) %>%
      mutate(p=round(n / sum(n) * 100, 1))
  }

  n_total = recist %>%
    group_by(arm) %>%
    summarise(n_total=n())

  total_global = length(recist$subjid)

  ORR = CBR = DCR = data.frame()

  if("ORR" %in% derived_endpoints){
    ORR = recist %>%
      summarise(
        n = sum(best_response %in% c("Complete response", "Partial response"), na.rm=TRUE),
        p = round(n / total * 100, 1),
        best_response = "Objective Response Rate (ORR)",
      )
  }

  if("CBR" %in% derived_endpoints){
    CBR = recist %>%
      summarise(
        n = sum(best_response %in% c("Complete response", "Partial response") | six_months_confirmation, na.rm=TRUE),
        p = round(n / total * 100, 1),
        best_response = "Clinical Benefit Rate (CBR)",
      )
  }

  if("DCR" %in% derived_endpoints){
    DCR = recist %>%
      summarise(
        n = sum(best_response %in% c("Complete response", "Partial response","Stable disease"), na.rm=TRUE),
        p = round(n / total * 100, 1),
        best_response = "Disease Control Rate (DCR)",
      )
  }

  summary_df = bind_rows(response_counts, ORR, CBR, DCR) %>%
    ungroup() %>%
    left_join(n_total, by = "arm") %>%
    mutate(ic_95 = {
      ci = clopper_pearson_ci(n, n_total, CI = "two.sided", alpha = 0.05)
      glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
    },
    .by= c(best_response,arm)) %>%
    arrange(arm) %>%
    select(-n_total) %>%
    apply_labels(best_response = "Best Overall Response",
                 n = "Number of patient",
                 p = "Percentage",
                 ic_95 = "IC 95%") %>%
    pivot_wider(names_from = arm,values_from = c(n, p,ic_95), names_vary = "slowest", names_sep = "__") %>%
    structure(derived_endpoints=derived_endpoints, confirmed = confirmed, total = total_global, n_total = n_total, data_arm = data_arm) %>%
    add_class("aggregate_recist_rates")

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
#' @importFrom officer fp_border
#' @importFrom rlang check_dots_empty
#' @importFrom tidyr separate_wider_delim
#'
as_flextable.aggregate_recist_rates = function(x, ...){
  check_dots_empty()
  derived_endpoints = attr(x, "derived_endpoints")
  confirmed = attr(x, "confirmed")
  total = attr(x,"total")

  best_response_during_treatment =  x %>%
    flextable() %>%
    set_table_properties(layout="autofit") %>%
    bold(bold = TRUE, part = "header") %>%
    surround(i = 5, border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body") %>%
    bold(i = 6, bold = TRUE, part = "body") %>%
    set_header_labels(n=paste0("N=",total), p = "%", ic_95 = "IC 95%")

  if("ORR" %in% derived_endpoints){
    label_ORR = "ORR was defined as the presence of a partial response (PR) or a complete response (CR)."
    best_response_during_treatment =  best_response_during_treatment %>%
      bold(i = ~ best_response == "Objective Response Rate (ORR)", bold = TRUE, part = "body") %>%
      footnote( i = ~ best_response == "Objective Response Rate (ORR)", j = "best_response",
                value = as_paragraph(label_ORR),
                ref_symbols ="ORR", part = "body")
  }
  if("CBR" %in% derived_endpoints){
    label_CBR = "CBR was defined as the presence of a partial response (PR), a complete response (CR), or a stable disease (SD) lasting at least six months."
    best_response_during_treatment =  best_response_during_treatment %>%
      bold(i = ~ best_response == "Clinical Benefit Rate (CBR)", bold = TRUE, part = "body") %>%
      footnote( i = ~ best_response == "Clinical Benefit Rate (CBR)", j = "best_response",
                value = as_paragraph(label_CBR),
                ref_symbols ="CBR", part = "body")
  }
  if("DCR" %in% derived_endpoints){
    label_DCR = "DCR was defined as the presence of a partial response (PR), a complete response (CR), or a stable disease (SD)."
    best_response_during_treatment =  best_response_during_treatment %>%
      bold(i = ~ best_response == "Disease Control Rate (DCR)", bold = TRUE, part = "body") %>%
      footnote( i = ~ best_response == "Disease Control Rate (DCR)", j = "best_response",
                value = as_paragraph(label_DCR),
                ref_symbols ="DCR", part = "body")
  }

  label_CP = "Clopper-Pearson (Exact) method was used for confidence interval"
  best_response_during_treatment = best_response_during_treatment %>%
    footnote(j = "ic_95",
             value = as_paragraph(label_CP),
             ref_symbols ="*", part = "header")

  if (!confirmed){
    best_response_during_treatment =  best_response_during_treatment %>%
      set_header_labels(best_response="Unconfirmed Best Response during treatment")

  } else{
    label_confirmed = "For CR & PR, confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response."
    best_response_during_treatment =  best_response_during_treatment %>%
      set_header_labels(best_response="Confirmed Best Response during treatment") %>%
      footnote(i = 1, j = "best_response",
               value = as_paragraph(label_confirmed),
               ref_symbols =c("**"), part = "header")
  }

  best_response_during_treatment %>%
    valign(valign = "bottom", part = "header")
}
