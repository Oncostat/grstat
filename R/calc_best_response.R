
#' Calculate Best RECIST Response
#'
#' `r lifecycle::badge("experimental")`\cr
#' Computes the best RECIST response per subject based on target lesion sum and response categories.
#' Ties are resolved using lesion sum, then by date.
#'
#' @param data_recist A dataset containing longitudinal RECIST data in long format.
#' @param rc_sum The column containing the sum of target lesions. Default is `"RCTLSUM"`.
#' @param rc_resp The column containing the RECIST response (e.g., `"CR"`, `"PR"`, `"SD"`, `"PD"`). Default is `"RCRESP"`.
#' @param rc_date The column containing the assessment date. Default is `"RCDT"`.
#' @param subjid The column containing the subject ID. Default is `"SUBJID"`.
#' @param exclude_post_pd Logical; if `TRUE` (default), assessments after the first PD are excluded.
#' @param warnings Logical; if `TRUE` (default is taken from `getOption("grstat_best_resp_warnings", TRUE)`), emits warnings during internal checks.
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
#' 2. Among the best responses, the one with the smallest target lesion sum is selected
#' 3. If still tied, the earliest assessment date is selected
#' 4. Only subjects with at least two assessments and non-missing target sum are considered
#' 5. By default, all assessments after the first PD are excluded (`exclude_post_pd = TRUE`)
#'
#'
#' @export
#' @importFrom dplyr arrange distinct filter mutate n_distinct select slice_min
#' @importFrom forcats fct_reorder
#'
#' @examples
#' db = grstat_example()
#' db$recist %>%
#'   calc_best_response()
calc_best_response = function(data_recist, ...,
                              rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT",
                              subjid="SUBJID", exclude_post_pd=TRUE,
                              warnings=getOption("grstat_best_resp_warnings", TRUE)) {
  assert_class(data_recist, class="data.frame")
  assert_class(rc_sum, class="character")
  assert_class(rc_resp, class="character")
  assert_class(rc_date, class="character")
  assert_class(warnings, class="logical")

  data_recist %>%
    select(subjid=any_of2(subjid), response=any_of2(rc_resp), sum=any_of2(rc_sum),
           date=any_of2(rc_date)) %>%
    .check_best_resp(do=warnings) %>%
    filter(!is.na(sum)) %>%
    filter(n_distinct(date)>=2, .by=subjid) %>%
    arrange(subjid, date) %>%
    distinct() %>%
    mutate(
      first_date = min_narm(date, na.rm=TRUE),
      min_sum = min_narm(sum, na.rm=TRUE),
      first_sum = sum[date==first_date],
      .by=subjid,
    ) %>%
    mutate(
      first_date = date==first_date,
      response_num = .encode_response(response),
      response = fct_reorder(as.character(response), response_num),
      diff_first = (sum - first_sum)/first_sum,
      diff_min = (sum - min_sum)/min_sum
    ) %>%
    .remove_post_pd(do=exclude_post_pd) %>%
    slice_min(response_num, with_ties=TRUE, na_rm=TRUE, by=c(subjid)) %>%
    slice_min(sum,          with_ties=TRUE, na_rm=TRUE, by=c(subjid, response_num)) %>%
    slice_min(subjid,      with_ties=FALSE, na_rm=TRUE, by=c(subjid, response_num)) %>%
    select(subjid, best_response=response, date, target_sum=sum,
           target_sum_diff_first=diff_first, target_sum_diff_min=diff_min)

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


#' @importFrom cli cli_inform
#' @importFrom dplyr filter if_else mutate select
.remove_post_pd = function(df, do){
  if(!isTRUE(do)) return(df)
  rtn = df %>%
    mutate(first_pd=if_else(any(response_num==4, na.rm=TRUE),
                            min_narm(date[response_num==4]),
                            as.Date(Inf)),
           .by=subjid) %>%
    filter(date<=first_pd, .by=subjid) %>%
    select(-first_pd)

  if(getOption("verbose_remove_post_pd", FALSE)){
    cli_inform("Removed {nrow(df)-nrow(rtn)} rows post-progression (on {nrow(df)} total).")
  }

  rtn
}


#' @noRd
#' @keywords internal
#' @importFrom dplyr filter n_distinct
.check_best_resp = function(df, do=TRUE) {
  if(!isTRUE(do)) return(df)

  df %>%
    filter(date==min(date) & !is.na(response), .by=subjid) %>%
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

  df
}
