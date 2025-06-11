
#' Calculate the "Best Reponse"
#'
#' `r lifecycle::badge("experimental")`\cr
#'
#' @param data_recist recist dataset
#' @param rc_sum name of the target lesions length sum column in `data_recist`, usually "RCTLSUM".
#' @param rc_resp name of the response column in `data_recist`, usually "RCRESP".
#' @param rc_date name of the date column in `data_recist`, usually "RCDT".
#' @param rc_star name of the column in `data_recist` that triggers the star symbol. The column should be character or factor, with `NA` for patients without symbol.
#' @param arm name of the treatment column in `data_recist`. Can be left to `NULL` to not group.
#' @param subjid name of the subject identifier column in `data_recist`.
#' @param warnings whether to warn about any problems
#' @param ... unused
#'
#' @section Methods:
#' Data are ordered on `rc_date`.
#'
#'
#' @return a ggplot
#' @export
#' @importFrom cli cli_abort
#' @importFrom dplyr arrange case_when desc distinct filter mutate n_distinct select
#' @importFrom forcats as_factor
#' @importFrom ggplot2 aes facet_wrap geom_col geom_hline geom_point ggplot labs scale_fill_manual scale_shape_manual scale_x_discrete scale_y_continuous
#' @importFrom scales breaks_width label_percent
#' @importFrom stringr str_detect
#' @importFrom tidyr replace_na
#'
#' @examples
#'
#' \dontrun{
#' rc_br = calc_best_response(rc, rc_date="RCDT", rc_sum="RCTLSUM", rc_resp="RCRESP")
#' rc_br
#'}
calc_best_response = function(data_recist, rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT",
                              subjid="SUBJID", exclude_post_pd=TRUE,
                              warnings=getOption("grstat_best_resp_warnings", TRUE)) {
  assert_class(data_recist, class="data.frame")
  assert_class(rc_sum, class="character")
  assert_class(rc_resp, class="character")
  assert_class(rc_date, class="character")
  assert_class(warnings, class="logical")
  responses = c("Complete response"="#42B540FF", "Partial response"="#006dd8",
                "Stable disease"="#925E9F", "Progressive disease"="#ED0000", "Missing"="white")

  db_wf = data_recist %>%
    select(subjid=any_of2(subjid), resp=any_of2(rc_resp), sum=any_of2(rc_sum),
           date=any_of2(rc_date)) %>%
    best_resp_check(subjid=subjid, do=warnings) %>%
    filter(!is.na(sum)) %>%
    filter(!is.na(date)) %>%
    filter(n_distinct(date)>=2, .by=subjid) %>%
    arrange(subjid) %>%
    distinct() %>%
    mutate(
      first_date = min_narm(date, na.rm=TRUE),
      min_sum = min_narm(sum, na.rm=TRUE),
      max_sum = max_narm(sum, na.rm=TRUE),
      first_sum = sum[date==first_date],
      .by=subjid,
    ) %>%
    mutate(
      first_date = date==first_date,
      resp_num = case_when(
        resp=="CR" | str_detect(resp, "(?i)complete") ~ 1,
        resp=="PR" | str_detect(resp, "(?i)partial")  ~ 2,
        resp=="SD" | str_detect(resp, "(?i)stable")   ~ 3,
        resp=="PD" | str_detect(resp, "(?i)progr")    ~ 4,
        is.na(resp) | str_detect(resp, "(?i)not [eval|avai]") ~ Inf,
        .default=-99,
      ),
      resp2 = names(responses)[replace_na(resp_num, 5)],
      resp2 = factor(resp2, levels=names(responses)),
    ) %>%
    filter(resp_num==min_narm(resp_num), .by=subjid) %>%
    filter(sum==min_narm(sum), .by=c(subjid, resp_num)) %>%
    filter(date==min_narm(date), .by=c(subjid, resp_num)) %>%
    mutate(
      diff_first = (sum - first_sum)/first_sum,
      diff_min = (sum - min_sum)/min_sum,
      subjid = forcats::fct_reorder2(as.character(subjid), resp2, diff_first)
    )
    .remove_post_pd(do=exclude_post_pd) %>%

  if(any(db_wf$resp_num==-99)){
    cli_abort("Internal error 'resp_num_error', waterfall plot may be slightly irrelevant.",
              .internal=TRUE)
  }

  db_wf
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
best_resp_check = function(df, subjid="SUBJID", do=TRUE) {
  if(isTRUE(do)) return(df)
  assert_names_exists(df, subjid)
  df %>%
    filter(is.na(sum)) %>%
    grstat_data_warn("Rows with missing target lesions length sum were ignored.", subjid=subjid,
                     class="gr_waterfall_missing_sum_warning")
  df %>%
    filter(is.na(date)) %>%
    grstat_data_warn("Rows with missing target evaluation date were ignored.", subjid=subjid,
                     class="gr_waterfall_missing_target_warning")
  df %>%
    filter(date==min(date) & !is.na(resp), .by=any_of2(subjid)) %>%
    grstat_data_warn("Response is not missing at first date", subjid=subjid,
                     class="gr_waterfall_notmissing_bl_warning")
  df %>%
    filter(n_distinct(date)<2, .by=any_of2(subjid)) %>%
    grstat_data_warn("Patients with <2 recist evaluations were ignored.", subjid=subjid,
                     class="gr_waterfall_inf2_eval_warning")

  df
}
