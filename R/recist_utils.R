

#' Parse RECIST response case-insensitively
#' Acronyms can be surrounded by non-word characters (e.g. "-CR-", but not "CResp")
#' @noRd
#' @importFrom cli cli_abort
#' @importFrom dplyr case_when
#' @importFrom stringr str_detect
.recist_to_num = function(x){
  rtn = case_when(
    str_detect(x, "(?i)(\\W|^)(CR)(\\W|$)") | str_detect(x, "(?i)complete") ~ 1,
    str_detect(x, "(?i)(\\W|^)(PR)(\\W|$)") | str_detect(x, "(?i)partial")  ~ 2,
    str_detect(x, "(?i)(\\W|^)(SD)(\\W|$)") | str_detect(x, "(?i)stable")   ~ 3,
    str_detect(x, "(?i)non.*cr.*pd")   ~ 3,
    str_detect(x, "(?i)(\\W|^)(PD)(\\W|$)") | str_detect(x, "(?i)progres")  ~ 4,
    is.na(x) | x %in% c("NE", "NA") | str_detect(x, "(?i)not [eval|avai]")  ~ 5,
    .default=Inf,
  )
  if(any(is.infinite(rtn))){
    wrong = sort(unique(x[is.infinite(rtn)]))
    ok = c("CR", "PR", "SD", "Non-CR Non-PD", "PD", "NA", "NE")
    cli_abort(c("Could not parse the following values as responses: {.val {wrong}}.",
                i="Please reformat them using the standard notation: {.or {.val {ok}}}."),
              call=parent.frame(),
              class="response_encode_error")
  }
  rtn
}


#' Encode numeric RECIST response as standard acronyms
#' Non-CR Non-PD are turned to SD for simplicity
#' @noRd
.recist_from_num = function(x) {
  assert(is.numeric(x))
  x[x==99] = 5
  factor(x, levels=c(1:5), labels=c("CR", "PR", "SD", "PD", "Not evaluable"))
}


#' Remove rows posterior to the first progression
#' @noRd
#' @importFrom cli cli_inform
#' @importFrom dplyr filter if_else mutate select
.remove_post_pd = function(df, resp, date, subjid="SUBJID", do=TRUE){
  if(!isTRUE(do)) return(df)

  rtn = df %>%
    mutate(
      .response_num = if(is.numeric({{resp}}))  {{resp}} else .recist_to_num({{resp}}),

      .first_pd=if_else(any(.response_num==4, na.rm=TRUE),
                            min_narm({{date}}[.response_num==4]),
                            as.Date(Inf)),
           .by=any_of2(subjid)) %>%
    filter({{date}}<=.first_pd, .by=any_of2(subjid)) %>%
    select(-.first_pd, -.response_num)

  if(getOption("verbose_remove_post_pd", FALSE)){
    cli_inform("Removed {nrow(df)-nrow(rtn)} rows post-progression (on {nrow(df)} total).")
  }

  rtn
}
