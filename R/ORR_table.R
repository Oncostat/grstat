#' Calculate ORR
#'
#' @description
#' The function `ORR_table()` creates a summary table of recist for each possible response.
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
#' @return a dataframe (`ORR_table()`) or a flextable (`as_flextable()`).
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
#' ORR_table(recist)
#'
#' #the resulting data.frame can be customized using the flextable package
#' library(flextable)
#' ORR_table(recist) %>%
#'   as_flextable()
#' #Is also possible to use the confirmation method for the ORR
#' ORR_table(recist, confirmed = TRUE) %>%
#'   as_flextable()
#'
#' #Or show the Clinical Benefice Rate
#' ORR_table(recist, show_CBR = TRUE) %>%
#'   as_flextable()
ORR_table = function(data, ..., rc_resp="RCRESP", rc_date="RCDT",
                     subjid="SUBJID", confirmed = FALSE, show_CBR = FALSE, cycle_length =28){
  recist = calc_best_response(data, rc_resp=rc_resp, rc_date=rc_date,
                              subjid=subjid, confirmed = confirmed, cycle_length = cycle_length)

  total = length(recist$subjid)
  response_counts = recist %>%
    crosstable(best_response, percent_pattern = "{n}") %>%
    rename(Name = variable, N = value) %>%
    mutate(N = as.numeric(N),
           Percentage = round(N / sum(N) * 100, 1)) %>%
    select(Name, N, Percentage)

  ORR = recist %>%
    filter(Overall_Response==1) %>%
    summarise(Name = "Overall ORR", N = n()) %>%
    mutate(Percentage = round(N / total * 100, 1))

  CBR = recist %>%
    filter(Clinical_Benefit==1) %>%
    summarise(Name = "Clinical Benefit Rate (CBR)", N = n()) %>%
    mutate(Percentage = round(N / total * 100, 1))

  if(show_CBR){
  summary_df = bind_rows(ORR, response_counts, CBR) %>%
    mutate(IC_95 = {
      ci = clopper_pearson_ci(N, total, CI = "two.sided", alpha = 0.05)
      glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
    },
    .by= Name) %>%
    add_class("ORR_table") %>%
    add_class("show_CBR_TRUE")
  } else {
    summary_df = bind_rows(ORR, response_counts) %>%
      mutate(IC_95 = {
        ci = clopper_pearson_ci(N, total, CI = "two.sided", alpha = 0.05)
        glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
      },
      .by= Name) %>%
      add_class("ORR_table")%>%
      add_class("show_CBR_FALSE")
  }

  if (confirmed){
    summary_df = summary_df %>%
      structure(Name="Confirmed Best Response during treatment", N=paste0("N=",total), Percentage = "%", IC_95 = "IC 95%") %>%
      add_class("confirmed_TRUE")
  } else {
    summary_df = summary_df %>%
      structure(Name="Unconfirmed Best Response during treatment", N=paste0("N=",total), Percentage = "%", IC_95 = "IC 95%") %>%
      add_class("confirmed_FALSE")
  }

  summary_df
}


#' Turns an `ORR_table` object into a formatted `flextable`
#'
#' @param x a dataframe, resulting of `ORR_table()`
#' @param ... unused
#'
#' @return a formatted flextable
#' @rdname ORR_table
#' @export
#'
#' @importFrom flextable surround delete_rows footnote as_paragraph
#' @importFrom officer fp_border
as_flextable.ORR_table = function(x, ...){
  check_dots_empty()
  colnames(x) = c(attr(x,"Name"), attr(x,"N"), attr(x,"Percentage"), attr(x,"IC_95"))
  Best_Response_during_treatment =  x %>%
    flextable() %>%
    width(width = c(3, 1, 1, 1)) %>%
    delete_rows(i = 1, part = "footer") %>%
    bold(bold = TRUE, part = "header") %>%
    surround(i = c(1, 6), j = 1:4, border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body")

    if ("confirmed_FALSE" %in% class(x)){
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      footnote(i = 1, j = 4,
                value = as_paragraph("Clopper-Pearson (Exact) method was used for confidence interval"),
                ref_symbols ="*", part = "header") %>%
      valign(valign = "bottom", part = "header")
    } else{
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
      footnote(i = 1, j = c(4, 1),
                value = as_paragraph(c("Clopper-Pearson (Exact) method was used for confidence interval",
                    "For CR & PR confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response.")),
                ref_symbols =c("*", "1"), part = "header") %>%
      valign(valign = "bottom", part = "header")
      }

  if ("show_CBR_FALSE" %in% class(x)){
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      bold(i = 1, j = c(1:4), bold = TRUE, part = "body")
  } else if("show_CBR_TRUE" %in% class(x) & "confirmed_TRUE" %in% class(x)){
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      bold(i = c(1, 7), j = c(1:4), bold = TRUE, part = "body") %>%
      footnote( i = 7, j = 1,
                value = as_paragraph("CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date)."),
                ref_symbols = "2", part = "body") %>%
      valign(valign = "bottom", part = "header")
  } else{
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      bold(i = c(1, 7), j = c(1:4), bold = TRUE, part = "body") %>%
      footnote( i = 7, j = 1,
                value = as_paragraph("CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date)."),
                ref_symbols = "1", part = "body") %>%
      valign(valign = "bottom", part = "header")
  }
  Best_Response_during_treatment
}
