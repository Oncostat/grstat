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
#' @param confirmed Logical; if `TRUE`, use the cofirmation method to determine the best response. For CR & PR confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response. *As stated in the protocol: «For equivocal findings of progression (e.g., very small and uncertain new lesions; cystic changes or necrosis in existing lesions), treatment may continue until the next scheduled assessment». Therefore, some patients had a response after a progressive disease response, in that case best response was examine before and after PD. Scans conducted after initiating new anti-cancer therapy were not included in the ORR analyses.
#' @param show_CBR Logical; if `TRUE`, show the Clinical Best Response (CBR). CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date).
#'
#' @return a dataframe (`ORR_table()`) or a flextable (`as_flextable()`).
#'
#' @importFrom dplyr select any_of all_of
#' @importFrom GenBinomApps clopper.pearson.ci
#' @importFrom cli cli_abort
#' @importFrom crosstable crosstable
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
                     subjid="SUBJID", confirmed = FALSE, show_CBR = FALSE){
  recist = calc_best_response(data,rc_resp=rc_resp, rc_date=rc_date,
                              subjid=subjid, confirmed = confirmed)

  total = length(recist$subjid)
  response_counts = recist %>%
    crosstable(best_response, percent_pattern = "{n}") %>%
    rename(Name = variable, N = value) %>%
    mutate(N= as.numeric(N),
           Percentage = round(N / sum(N) * 100, 1)) %>%
    select(Name, N, Percentage)

  ORR = recist %>%
    filter(Overall_ORR ==1 ) %>%
    summarise(Name = "Overall ORR", N = n()) %>%
    mutate(Percentage = round(N / total * 100, 1))

  CBR = recist %>%
    filter(CBR == 1) %>%
    summarise(Name = "Clinical Benefit Rate (CBR)", N = n()) %>%
    mutate(Percentage = round(N / total * 100, 1))

  if(show_CBR){
  summary_df = bind_rows(ORR, response_counts, CBR) %>%
    mutate(IC_95 = {
      ci = clopper.pearson.ci(N, total, CI = "two.sided", alpha = 0.05)
      glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
    },
    .by= Name) %>%
    add_class("ORR_table")
  }
  else{
    summary_df = bind_rows(ORR, response_counts) %>%
      mutate(IC_95 = {
        ci = clopper.pearson.ci(N, total, CI = "two.sided", alpha = 0.05)
        glue("[{round(ci$Lower.limit*100, 1)};{round(ci$Upper.limit*100, 1)}]")
      },
      .by= Name) %>%
      add_class("ORR_table")
  }

  if (confirmed){
    nom_col = c("Confirmed Best Response during treatment",paste0("N=",total),"%","IC 95%")
  }
  else{
    nom_col = c("Unconfirmed Best Response during treatment",paste0("N=",total),"%","IC 95%")
  }

  colnames(summary_df) <- nom_col
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
as_flextable.ORR_table = function(x, ...,confirmed = FALSE, show_CBR = FALSE){
  check_dots_empty()
  Best_Response_during_treatment =  x %>%
    flextable() %>%
    width(width = c(3,1,1,1)) %>%
    delete_rows(i=1, part = "footer") %>%
    bold(bold = TRUE, part = "header") %>%
    surround(i = c(1,6), j = 1:4, border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body")

    if (colnames(x[1]) == "Unconfirmed Best Response during treatment"){
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      as_flextable(show_coltype = F, include.row_percent = FALSE, include.column_percent = FALSE, include.table_percent = FALSE) %>%
      delete_rows(i=1, part = "footer") %>%
      bold(bold = TRUE, part = "header") %>%
      surround(i = c(1,6), j = 1:4, border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body")

      if (is.na(confirmed) | confirmed == FALSE){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = 1, j = c(4),
                  value = as_paragraph(
                    c("Clopper-Pearson (Exact) method was used for confidence interval")),
                  ref_symbols =c("*"), part = "header") %>%
        valign(valign = "bottom", part = "header")
      }
      else if(confirmed == TRUE){
        Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = 1, j = c(4,1),
                  value = as_paragraph(
                    c("Clopper-Pearson (Exact) method was used for confidence interval",
                      "For CR & PR confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response. *As stated in the protocol: «For equivocal findings of progression (e.g., very small and uncertain new lesions; cystic changes or necrosis in existing lesions), treatment may continue until the next scheduled assessment». Therefore, some patients had a response after a progressive disease response, in that case best response was examine before and after PD. Scans conducted after initiating new anti-cancer therapy were not included in the ORR analyses")),
                  ref_symbols =c("*","1"), part = "header") %>%
        valign(valign = "bottom", part = "header")
        }

    if (is.na(show_CBR) | show_CBR == FALSE){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        bold(i = c(1), j = 1, bold = TRUE, part = "body")
      }
    else if(show_CBR == TRUE & confirmed == TRUE){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = c(7), j = 1,
                  value = as_paragraph(
                    c("CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date).")),
                  ref_symbols = c("2"), part = "body") %>%
        valign(valign = "bottom", part = "header") %>%
        bold(i = c(1,7), j = 1, bold = TRUE, part = "body")
    }
    else if(show_CBR == TRUE & (is.na(confirmed) | confirmed == FALSE)){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = c(7), j = 1,
                  value = as_paragraph(
                    c("CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date).")),
                  ref_symbols = c("1"), part = "body") %>%
        valign(valign = "bottom", part = "header") %>%
        bold(i = c(1,7), j = 1, bold = TRUE, part = "body")
    }
Best_Response_during_treatment
}
