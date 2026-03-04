
#' Calculate Best RECIST Response
#'
#' `r lifecycle::badge("experimental")`\cr
#' Computes the best RECIST response per subject based on target lesion sum and response categories.
#' Ties are resolved using lesion sum, then by date.
#'
#' @param data_recist A dataset containing longitudinal RECIST data in long format.
#' @param ... Not used. Ensures that only named arguments are passed.
#' @param rc_sum The column containing the sum of target lesions. Default is `"RCTLSUM"`.
#' @param rc_resp The column containing the RECIST response (e.g., `"CR"`, `"PR"`, `"SD"`, `"PD"`). Default is `"RCRESP"`.
#' @param rc_date The column containing the assessment date. Default is `"RCDT"`.
#' @param subjid The column containing the subject ID. Default is `"SUBJID"`.
#' @param warnings Logical; if `TRUE` (default is taken from `getOption("grstat_best_resp_warnings", TRUE)`), emits warnings during internal checks.
#' @param cycle_length Numeric, Time between two cycle (used for confirmation), default = 28 days following PharmaSUG 2023 – Paper QT047 recommendation
#' @param use_pharmasug Logical, if `TRUE`, the confirmation of response will be defnied following PharmaSUG 2023 – Paper QT047 recommendation. Default is RECIST 1.1 guideline
#'
#'
#' @return A tibble with one row per subject, containing:
#' - `subjid`: Subject ID
#' - `best_response`: The best RECIST response observed before progression
#' - `date`: The date corresponding to the best response
#' - `target_sum`: Sum of target lesions at that date
#' - `target_sum_diff_first`: Relative difference in target sum compared to baseline
#' - `target_sum_diff_min`: Relative difference in target sum compared to the minimum observed
#'
#' @details
#' The function identifies the best response using the following logic:
#' 1. Responses are ordered: `CR` > `PR` > `SD` > `PD` > `Missing`
#' 2. Among the best responses the earliest assessment date is selected. For a confirmed response, the earliest date of the confirmed response will be selected
#' 3. Only subjects with at least two assessments and non-missing target sum are considered
#'
#'
#' @export
#' @importFrom dplyr arrange distinct filter mutate n_distinct select slice_min slice_head
#' @importFrom forcats fct_reorder
#'
#' @examples
#' db = grstat_example()
#' db$recist %>%
#'   calc_best_response()
calc_best_response = function(data_recist, ...,
                              rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT",
                              subjid="SUBJID", exclude_post_pd=TRUE,
                              warnings=getOption("grstat_best_resp_warnings", TRUE),
                              confirmed = FALSE, cycle_length = 28, use_pharmasug = FALSE) {
  assert_class(data_recist, class="data.frame")
  assert_class(rc_sum, class="character")
  assert_class(rc_resp, class="character")
  assert_class(rc_date, class="character")
  assert_class(warnings, class="logical")
  assert_names_exists(data_recist, lst(subjid, rc_sum, rc_date, rc_resp))
  grstat_dev_warn()

  data_recist = data_recist %>%
    select(subjid=any_of2(subjid), response=any_of2(rc_resp), sum=any_of2(rc_sum),
           date=any_of2(rc_date)) %>%
    distinct()

  na_date = data_recist %>%
    filter(is.na(date))
  if (length(na_date$date)>0) {
    cli_abort("Some date are missing. Please check if it is normal and remove them from the recist dataset",
              class = "grstat_data_warn_na_date",
              call = parent.frame())
  }

  data_recist = data_recist %>%
    .check_best_resp(do=warnings) %>%
    .remove_post_pd(resp = response, date = date) %>%
    filter(n_distinct(date)>=2, .by=subjid) %>%
    arrange(subjid, date) %>%
    mutate(
      first_date = min_narm(date, na.rm=TRUE),
      min_sum = min_narm(sum, na.rm=TRUE),
      first_sum = sum[date==first_date],
      response_num = .recist_to_num(response),
      response_num = ifelse(is.na(response),NA,response_num),
      next_response_num = lead(response_num),
      next_response_num_2 = lead(response_num,2),
      next_date = lead(date),
      delta_date = as.numeric(difftime(next_date, date, units="days")),
      delta_date = replace_na(delta_date, 0),
      #previous_response_num = lag(response_num),
      #previous_date = lag(date),
      #previous_response_num_2 = lag(response_num,2),
      #delta_date = as.numeric(date - previous_date),
      #delta_date = as.numeric(difftime(date, previous_date, units="days")),
      #delta_date = replace_na(delta_date, 0),
      delta_date_before_PD_or_end = cumsum(delta_date),
      delta_date_before_PD_or_end = ifelse(response_num==4, 0, delta_date_before_PD_or_end),
      delta_date_before_PD_or_end = replace_na(delta_date_before_PD_or_end, 0),
      duree_suivi_max = max(delta_date_before_PD_or_end),
      #bestresponse_withinprotocole = ifelse(previous_response_num==response_num, 1, 0 ),
      .by=subjid
    ) %>%
    mutate(
      first_date = date==first_date,
      diff_first = (sum - first_sum)/first_sum,
      diff_first = ifelse (is.na(diff_first),0,diff_first),
      diff_min = (sum - min_sum)/min_sum
    ) %>%
    filter(!is.na(response))

  if (!isTRUE(confirmed)){
    data_recist = data_recist %>%
      slice_min(order_by =response_num, by=subjid, with_ties = FALSE) %>%
      mutate(response_final = .recist_from_num(response_num),
             bestresponse = response_num)
  # } else {
  #   data_recist = data_recist %>%
  #     mutate(response_confirmed = .response_confirmed(response_num = response_num,
  #                                                   previous_response_num = previous_response_num,
  #                                                   delta_date = delta_date,
  #                                                   cycle_length = cycle_length,
  #                                                   previous_response_num_2 = previous_response_num_2,
  #                                                   use_pharmasug = use_pharmasug)
  #     ) %>%
  #     mutate(bestresponse = min(response_confirmed), .by=subjid) %>%
  #     mutate(response_num_lead = lead(response_num),
  #            response_num_lead_2 = lead(response_num,2),
  #            date_for_confirm = .date_selection_for_response_confirmed(response_num = response_num,
  #                                             bestresponse = bestresponse,
  #                                             response_num_lead = response_num_lead,
  #                                             response_num_lead_2 = response_num_lead_2,
  #                                             use_pharmasug = use_pharmasug)
  #     ) %>%
  #     filter(date_for_confirm==TRUE) %>%
  #     slice_min(order_by =date ,by=subjid) %>%
  #     mutate(response_final = .recist_from_num(bestresponse))
  # }

  } else {
    data_recist = data_recist %>%
      # mutate(next_response_num = lead(response_num),
      #        next_response_num_2 = lead(response_num,2),
      #        next_date = lead(date),
      #        delta_date_futur = as.numeric(difftime(next_date, date, units="days")),
      #        delta_date_futur = replace_na(delta_date_futur, 0),
      #        .by = subjid) %>%
      mutate(response_confirmed = .response_confirmed_V2(response_num = response_num,
                                                      next_response_num = next_response_num,
                                                      delta_date = delta_date,
                                                      cycle_length = cycle_length,
                                                      next_response_num_2 = next_response_num_2,
                                                      use_pharmasug = use_pharmasug)
      ) %>%
      mutate(bestresponse = min(response_confirmed), .by=subjid) %>%
      filter(bestresponse==response_confirmed) %>%
      slice_min(order_by =date ,by=subjid) %>%
      mutate(response_final = .recist_from_num(bestresponse))
  }

  data_recist %>%
    mutate(response_final = factor(response_final,
                                       levels = c("CR", "PR", "SD", "PD", "Not evaluable"),
                                       labels = c("Complete response","Partial response",
                                                  "Stable disease", "Progressive disease", "Not evaluable"))
    ) %>%
    mutate(six_months_confirmation = duree_suivi_max >= 183) %>%
    select(subjid, best_response=response_final, date, target_sum=sum,
           target_sum_diff_first=diff_first, target_sum_diff_min=diff_min, six_months_confirmation) %>%
    structure(confirmed = confirmed)
}


#' @importFrom cli cli_abort
#' @importFrom dplyr case_when
#' @importFrom stringr str_detect
.encode_response = function(x){
  rtn = case_when(
    str_detect(x, "(?i)(\\W|^)(CR)(\\W|$)") | str_detect(x, "(?i)complete") ~ 1,
    str_detect(x, "(?i)(\\W|^)(PR)(\\W|$)") | str_detect(x, "(?i)partial")  ~ 2,
    str_detect(x, "(?i)(\\W|^)(SD)(\\W|$)") | str_detect(x, "(?i)stable")   ~ 3,
    str_detect(x, "(?i)(\\W|^)(PD)(\\W|$)") | str_detect(x, "(?i)progres")  ~ 4,
    is.na(x) | x %in% c("NE", "NA") | str_detect(x, "(?i)not [eval|avai]")  ~ 5,
    .default=-99,
  )
  if(any(rtn == -99)){
    wrong = sort(unique(x[rtn == -99]))
    ok = c("CR", "PR", "SD", "PD", "NA", "NE")
    cli_abort(c("Could not parse the following values as responses: {.val {wrong}}.",
                i="Please reformat them using the standard notation: {.or {.val {ok}}}."),
              class="response_encode_error")
  }
  rtn
}





#' @noRd
#' @keywords internal
#' @importFrom dplyr filter n_distinct
.check_best_resp = function(df, do=TRUE) {
  if(!isTRUE(do)) return(df)
  df %>%
    filter(date==min(date) & !response %in% c(NA, "Not Evaluable"), .by=subjid) %>%
    grstat_data_warn("Response is not missing at baseline.",
                     class="check_best_resp_bl_notmissing_warning")
  df %>%
    filter(date==min(date) & is.na(sum), .by=subjid) %>%
    grstat_data_warn("Target Lesions Length Sum is missing at baseline.",
                     class="check_best_resp_bl_summissing_warning")
  df %>%
    filter(n_distinct(date)<2, .by=subjid) %>%
    grstat_data_warn("Patients with <2 recist evaluations were ignored.",
                     class="check_best_resp_inf2_eval_warning")

    df %>% filter(n()>1, .by=c(subjid, date)) %>%
    grstat_data_warn("Patients with duplicate date of recist evalution but different evaluation are present in the data set",
                     class="check_best_resp_duplic_eval_warning")
  df
}


#' @noRd
#' @keywords internal
#' #' @details
#' La fonction permet de déterminer pour chaque réponse quelle est la réponse confirmé associé en prenant en compte les réponses précédentes
.response_confirmed = function(response_num = response_num,
                             previous_response_num = previous_response_num,
                             delta_date = delta_date,
                             cycle_length = cycle_length,
                             previous_response_num_2 = previous_response_num_2,
                             use_pharmasug = use_pharmasug) {
case_when(
  use_pharmasug == TRUE & response_num <= 2 & previous_response_num == 3 & previous_response_num_2 <= 2   ~ 2,
  response_num == 1 & previous_response_num == 1 & delta_date >= cycle_length                ~ 1,
  response_num == 1 & previous_response_num == 1 & delta_date < cycle_length                 ~ 3,
  response_num == 1 & previous_response_num == 2 & delta_date >= cycle_length                ~ 2,
  response_num == 1 & previous_response_num == 2 & delta_date < cycle_length                 ~ 3,
  response_num == 1 & previous_response_num == 3                                             ~ 3,
  response_num == 1 & previous_response_num == 5 & previous_response_num_2 == 1              ~ 1,
  response_num == 1 & previous_response_num == 5                                             ~ 5,

  response_num == 2 & previous_response_num <= 2 & delta_date >= cycle_length                ~ 2,
  response_num == 2 & previous_response_num <= 2 & delta_date < cycle_length                 ~ 3,
  response_num == 2 & previous_response_num == 3 & previous_response_num_2 ==3               ~ 3,
  response_num == 2 & previous_response_num == 3 & previous_response_num_2 ==5               ~ 3,
  response_num == 2 & previous_response_num == 5 & previous_response_num_2 ==3               ~ 3,
  response_num == 2 & previous_response_num == 5 & previous_response_num_2 ==5               ~ 5,
  response_num == 2 & previous_response_num == 5 & previous_response_num_2 <= 2              ~ 2,

  response_num == 4                                                                          ~ 4,
  is.na(previous_response_num) & response_num <= 2                                           ~ 5,
  is.na(previous_response_num_2)& (previous_response_num==3 | previous_response_num ==5) &
    response_num <= 2                                                                        ~ 5,

  .default = response_num
)
}

#' @noRd
#' @keywords internal
#' #' #' @details
#' La fonction permet de déterminer pour les réponses confirmées quelle est la date du début de la confirmation
.date_selection_for_response_confirmed = function(response_num = response_num,
                                      bestresponse = bestresponse,
                                      response_num_lead = response_num_lead,
                                      response_num_lead_2 = response_num_lead_2,
                                  use_pharmasug = use_pharmasug) {
    CR_c = response_num == 1 & bestresponse == 1 & response_num_lead ==1
    PR_CR_c = response_num == 1 & bestresponse == 2 & response_num_lead ==2
    CR_c_pharmasug = response_num == 1 & bestresponse == 1 &
      (response_num_lead ==3 |response_num_lead ==5) & response_num_lead_2 <=2
    CR_NE_c = response_num == 1 & bestresponse == 1 & response_num_lead ==5 & response_num_lead_2 ==1
    PR_c = response_num == 2 & bestresponse == 2 & response_num_lead <=2
    PR_c_pharmasug = response_num == 2 & bestresponse == 2 &
      (response_num_lead ==3 |response_num_lead ==5) &response_num_lead_2 <=2
    PR_NE_c = response_num == 2 & bestresponse == 2 & response_num_lead ==5 & response_num_lead_2 <=2
    SD_c = response_num == 3 & bestresponse == 3
    PD_c = response_num == 4 & bestresponse == 4
    NE_c = response_num == 5 & bestresponse == 5

    if(isTRUE(use_pharmasug)){
      CR_c | PR_CR_c | CR_NE_c | PR_c | PR_NE_c | SD_c | PD_c | NE_c | CR_c_pharmasug | PR_c_pharmasug
    } else {
      CR_c | PR_CR_c | CR_NE_c | PR_c | PR_NE_c | SD_c | PD_c | NE_c
    }
}



#' @noRd
#' @keywords internal
#' #' @details
#' La fonction permet de déterminer pour chaque réponse quelle est la réponse confirmé associé en prenant en compte les réponses précédentes
.response_confirmed_V2 = function(response_num = response_num,
                               next_response_num = next_response_num,
                               delta_date = delta_date,
                               cycle_length = cycle_length,
                               next_response_num_2 = next_response_num_2,
                               use_pharmasug = use_pharmasug) {
  case_when(
    use_pharmasug == TRUE & response_num <= 2 & next_response_num == 3 & next_response_num_2 <= 2   ~ 2,
    response_num == 1 & next_response_num == 1 & delta_date >= cycle_length                ~ 1,
    response_num == 1 & next_response_num == 1 & delta_date < cycle_length                 ~ 3,
    response_num <= 2 & next_response_num <= 2 & delta_date >= cycle_length                ~ 2,
    response_num <= 2 & next_response_num <= 2 & delta_date < cycle_length                 ~ 3,
    response_num == 1 & next_response_num == 3                                             ~ 3,
    response_num == 1 & next_response_num == 5 & next_response_num_2 == 1              ~ 1,
    response_num <= 2 & next_response_num == 5 & next_response_num_2 <= 2              ~ 2,
    response_num == 1 & next_response_num == 5                                             ~ 5,
    response_num == 1 & next_response_num == 4                                             ~ 3,
    response_num == 2 & next_response_num == 3 & next_response_num_2 ==3               ~ 3,
    response_num == 2 & next_response_num == 3 & next_response_num_2 ==5               ~ 3,
    response_num == 2 & next_response_num == 5 & next_response_num_2 ==3               ~ 3,
    response_num == 2 & next_response_num == 5 & next_response_num_2 ==5               ~ 5,
    response_num == 2 & next_response_num == 5 & next_response_num_2 <= 2              ~ 2,
    response_num == 2 & next_response_num == 4                                             ~ 3,

    is.na(next_response_num) & response_num <= 2                                           ~ 3,
    is.na(next_response_num_2)& (next_response_num==3 | next_response_num ==5) &
      response_num <= 2                                                                        ~ 3,

    .default = response_num
  )
}
