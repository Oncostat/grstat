

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


#' Encore numeric RECIST response as standard acronyms
#' Non-CR Non-PD are turned to SD for simplicity
#' @noRd
.recist_from_num = function(x) {
  assert(is.numeric(x))
  x[x==99] = 5
  factor(x, levels=c(1:5), labels=c("CR", "PR", "SD", "PD", "Not evaluable"))
}
