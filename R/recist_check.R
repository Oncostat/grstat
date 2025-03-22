



#' Check RECIST data
#'
#' Check RECIST datasets
#'
#' @param rc the recist dataset
#' @param mapping the result of [gr_recist_mapping()]
#'
#' @returns a tibble of nested checks
#' @export
#'
#' @importFrom cli cli_inform
#' @importFrom dplyr across any_of arrange case_when count distinct filter group_by mutate n_distinct recode select semi_join summarise ungroup
#' @importFrom rlang env
#' @importFrom stats na.omit rnorm
#' @importFrom stringr str_detect
#' @importFrom tidyr fill pivot_longer replace_na
#' @importFrom tibble as_tibble
#' @importFrom tidyselect all_of everything where
#' @seealso [RECIST guidelines](https://ctep.cancer.gov/protocoldevelopment/docs/recist_guideline.pdf)
#'
check_recist = function(rc, mapping=gr_recist_mapping()){

  rc = .apply_recist_mapping(rc, mapping)
  rc_short = .summarise_recist(rc)

  checks = c(
    check_missing(rc),
    check_target_lesions(rc),
    check_constancy(rc),
    check_baseline_lesions(rc),
    check_derived_columns(rc), #TODO conditional checks
    check_target_response(rc, rc_short),
    check_nontarget_response(rc),
    check_global_response(rc_short)
  )

  rtn = checks %>%
    list_rbind(names_to="code") %>%
    mutate(level = factor(level, levels=c("ERROR", "WARNING", "CHECK"))) %>%
    arrange(level, desc(n_subjid)) %>%
    add_class("check_recist")

  rtn
}


#' Default mapping for RECIST dataset
#'
#' Generates the default mapping for the RECIST dataset. Values from `subjid`
#' to `global_resp` are mandatory. Other values will only trigger specified
#' checks if set. For `target_is_node`, if not set, it will be guessed from
#' the presence of "node" in `target_site`.
#'
#' @returns a named character vector
#' @export
#'
#' @examples
#' gr_recist_mapping()
gr_recist_mapping = function(){
  c(
    subjid="SUBJID", rc_date="RCDT",
    target_site="RCTLSITE", target_diam="RCTLDIAM", target_resp="RCTLRESP",
    nontarget_yn="RCNTLYN", nontarget_resp="RCNTLRES",
    new_lesions="RCNEW", global_resp="RCRESP",

    target_is_node="RCTLNODE", target_method="RCTLMOD",
    target_sum="RCTLSUM", target_sum_bl="RCTLBL", target_sum_min="RCTLMIN"
  )
}

# Checks --------------------------------------------------------------------------------------


#' * Consistant missing values on `target_diam` & `target_site`
#' @noRd
#' @importFrom tidyr nest
check_missing = function(rc){
  rtn = lst()

  #missing values target_diam & target_site
  rtn$target_missing_values = rc %>%
    filter(is.na(target_diam) != is.na(target_site)) %>%
    recist_issue("Target lesion diameter and site should not be missing",
                 level="ERROR")

  #missing values on responses: all or nothing
  resp_cols = c("new_lesions", "target_resp", "nontarget_resp", "global_resp")
  rtn$resp_missing_values = rc %>%
    filter(!(nontarget_yn=="No" & is.na(nontarget_resp))) %>%
    select(subjid, rc_date, nontarget_yn, all_of(resp_cols)) %>%
    filter(rowSums(across(all_of(resp_cols), is.na)) < 4) %>%
    filter(rowSums(across(all_of(resp_cols), is.na)) > 0) %>%
    distinct() %>%
    recist_issue("Response should not be missing.", level="WARNING")

  rtn
}


#' Target Lesions
#' * Up to a maximum of five lesions total (and a maximum of two lesions per organ)
#' * Should not be bone lesions
#' @noRd
#' @importFrom tidyr nest
check_target_lesions = function(rc){
  rtn = list()

  #Target Lesion should be <5
  rtn$target_lesions_sup5 = rc %>%
    filter(!is.na(target_site) & !is.na(target_diam)) %>%
    count(subjid, rc_date) %>%
    filter(n>5) %>%
    nest(dates=rc_date) %>%
    recist_issue("Target lesion: More than 5 sites", level="ERROR")

  #Target Lesion should be <2 per site
  rtn$target_sites_sup2 = rc %>%
    filter(!is.na(target_site)) %>%
    count(subjid, rc_date, target_site) %>%
    filter(n>2) %>%
    nest(dates=rc_date) %>%
    recist_issue("Target lesion: More than 2 lesions per site", level="ERROR")

  #Should not be bone lesions
  rtn$target_bone_lesion = rc %>%
    filter(str_detect(tolower(target_site), "bone")) %>%
    filter(!str_detect(tolower(target_site), "marrow")) %>%
    select(subjid, rc_date, target_site) %>%
    recist_issue("Target lesions should not be bone lesions", level="CHECK")

  rtn
}


#' Target Lesion site and evaluation method should have one value per patient
#' Responses should have one value per date
#' @keywords internal
check_constancy = function(rc){
  rtn = list()

  #Target Lesion sites should be constant
  rtn$target_constant_sites = rc %>%
    arrange(subjid, rc_date) %>%
    summarise(
      n_sites = length(na.omit(target_site)),
      target_sites = toString(unique(sort(target_site))),
      .by=c(subjid, rc_date)
    ) %>%
    filter(n_distinct(n_sites)>1, .by=subjid) %>%
    nest(dates=rc_date) %>%
    recist_issue("Target lesion: Inconsistent sites per subjid", level="ERROR")

  #Non-Target Lesion YN should be constant
  rc %>%
    distinct(subjid, rc_date, nontarget_yn) %>%
    filter(n_distinct(nontarget_yn, na.rm=TRUE)>1, .by=c(subjid)) %>%
    nest(rc_dates=rc_date) %>%
    recist_issue("Non-Target lesion: Inconsistent Yes/No per subjid", level="ERROR")

  #Response should be constant per date
  rc %>%
    distinct(subjid, rc_date, target_resp) %>%
    filter(n()>1, .by=c(subjid, rc_date)) %>%
    recist_issue("Target lesion: Inconsistent response per date", level="ERROR")
  rc %>%
    distinct(subjid, rc_date, nontarget_resp) %>%
    filter(n()>1, .by=c(subjid, rc_date)) %>%
    recist_issue("Non-Target lesion: Inconsistent response per date", level="ERROR")
  rc %>%
    distinct(subjid, rc_date, global_resp) %>%
    filter(n()>1, .by=c(subjid, rc_date)) %>%
    recist_issue("Global response: Inconsistent response per date", level="ERROR")

  #Target Lesion evaluation method should be constant (if provided)
  if(has_name(rc, "target_method")){
    rtn$target_method_no_dup = rc %>%
      filter(!is.na(target_method)) %>%
      select(subjid, rc_date, target_site, target_method) %>%
      filter(n_distinct(target_method)>1, .by=c(subjid, target_site)) %>%
      nest(dates=rc_date) %>%
      recist_issue("Target lesion: More than 1 method", level="ERROR")
  } else {
    rtn$target_method_no_dup = recist_issue_ne("Target lesion: More than 1 method",
                                               level="ERROR")
  }

  rtn
}


#' Baseline target lesions should be at least 10mm or 15mm (lymph node)
#' @noRd
check_baseline_lesions = function(rc){
  rtn = list()

  x = rc %>%
    filter(!is.na(target_diam) | !is.na(target_site)) %>%
    filter(rc_date==min(rc_date, na.rm=TRUE),
           .by=subjid) %>%
    arrange(subjid) %>%
    select(subjid, rc_date, target_site, target_is_node, target_diam) %>%
    mutate(non_measurable_node = target_is_node & target_diam < 15,
           non_measurable_lesion = !target_is_node & target_diam < 10) %>%
    distinct()

  rtn$target_non_measurable_node = x %>%
    filter(non_measurable_node) %>%
    recist_issue("Target lesion: Non measurable (<15mm) lymph node at baseline", level="ERROR")
  rtn$target_non_measurable_lesion = x %>%
    filter(non_measurable_lesion) %>%
    recist_issue("Target lesion: Non measurable (<10mm) lesion at baseline", level="ERROR")

  #baseline response should be missing
  rtn$baseline_resp_nonmissing = rc %>%
    arrange(subjid) %>%
    filter(rc_date==min_narm(rc_date), .by=subjid) %>%
    select(subjid, baseline_rc_date=rc_date, target_resp, nontarget_resp, global_resp) %>%
    pivot_longer(-c(subjid, baseline_rc_date),
                 names_to="response_column", values_to="response_value") %>%
    distinct() %>%
    filter(!is.na(response_value)) %>%
    recist_issue("Baseline response should be missing", level="ERROR")


  rtn
}


#' Checks on values calculated in the EDC software
#' Check target sum at any time, at baseline, and at Nadir
#' In TrialMaster, if `target_sum` is modified, `target_sum_bl` & `target_sum_min`
#' are not updated automatically.
#' This also makes duplicates possible.
#' @keywords internal
check_derived_columns = function(rc){

  rtn = list()

  #check for duplicates
  rtn$target_sum_bl_dupl = rc %>%
    arrange(subjid, rc_date) %>%
    filter(!is.na(target_sum_bl)) %>%
    distinct(subjid, rc_date, target_sum_bl) %>%
    filter(n_distinct(target_sum_bl)>1, .by=subjid) %>%
    nest(rc_dates=rc_date) %>%
    recist_issue("Dataset's baseline target lesion length sum has multiple values",
                 level="WARNING")


  rtn$target_sum_min_dupl = rc %>%
    arrange(subjid, rc_date) %>%
    filter(length(unique(na.omit(target_sum_min)))>1, .by=subjid) %>%
    select(subjid, rc_date, target_sum_min) %>%
    recist_issue("Dataset's minimum target lesion length sum (nadir) has multiple values",
                 level="WARNING")

  rtn$target_sum_bl_real_dupl = rc %>%
    arrange(subjid, rc_date) %>%
    filter(rc_date==min(rc_date, na.rm=TRUE),
           .by=subjid) %>%
    filter(length(unique(na.omit(target_sum)))>1, .by=subjid) %>%
    select(subjid, rc_date, target_sum) %>%
    recist_issue("Real baseline target lesion length sum has multiple values",
                 level="WARNING")

  #check for wrong values
  rtn$target_sum_wrong = rc %>%
    arrange(subjid) %>%
    mutate(
      target_sum = target_sum[1],
      target_sum_real = sum(target_diam, na.rm=TRUE),
      .by=c(subjid, rc_date)
    ) %>%
    filter((target_sum != target_sum_real)) %>%
    distinct(subjid, rc_date, target_sum, target_sum_real) %>%
    nest(rc_dates=rc_date) %>%
    recist_issue("Target lesion length sum is incorrect",
                 level="WARNING")

  rtn$target_sum_bl_wrong = rc %>%
    arrange(subjid) %>%
    mutate(target_sum_bl_real = target_sum[rc_date==min(rc_date, na.rm=TRUE)][1],
           .by=subjid) %>%
    filter((target_sum_bl != target_sum_bl_real)) %>%
    distinct(subjid, rc_date, target_sum_bl, target_sum_bl_real) %>%
    nest(rc_dates=rc_date) %>%
    recist_issue("Baseline target lesion length sum is incorrect",
                 level="WARNING")

  rtn$target_sum_min_wrong = rc %>%
    arrange(subjid, rc_date) %>%
    mutate(sum_nadir = cummin(target_sum),
           .by = subjid, .after=target_sum) %>%
    filter(any(target_sum_min != sum_nadir), .by=subjid) %>%
    select(subjid, rc_date, target_sum, target_sum_min,
           sum_nadir, everything()) %>%
    recist_issue("Minimum target lesion length sum (nadir) is incorrect",
                 level="WARNING")


  #one date = one sum
  rtn$target_sum_date_dup = rc %>%
    filter(n_distinct(target_sum, na.rm=TRUE)>1,
           .by=c(subjid, rc_date)) %>%
    recist_issue("Several target_sum values per date", level="ERROR")

  rtn
}


#' Check impossible cases for Non-Target Lesions response
#' @keywords internal
check_nontarget_response = function(rc){
  rtn = list()

  rtn$nonmissing_ntl = rc %>%
    filter(nontarget_yn == "No" & !is.na(nontarget_resp)) %>%
    distinct(subjid, rc_date, nontarget_yn, nontarget_resp) %>%
    arrange(nontarget_yn) %>%
    recist_issue("Patients with no Non-Target Lesions should not have a
                 NTL response.", level="ERROR")

  rtn
}


#' Check impossible cases for Target Lesions response
#' @keywords internal
check_target_response = function(rc, rc_short){
  rtn = list()

  #Complete Response
  #CR = Disappearance of all target lesions. Lymph nodes must be <10 mm.
  rtn$target_cr_remaining = rc %>%
    arrange(subjid) %>%
    filter(recist_encode(target_resp) == 1) %>%
    mutate(remaining_node = target_is_node & target_diam>=10,
           remaining_lesion = !target_is_node & target_diam>0) %>%
    filter(remaining_node | remaining_lesion) %>%
    distinct(subjid, rc_date, target_resp, target_site, target_diam) %>%
    recist_issue("Complete Responses should not have any lesion left and should
                 not have lymph nodes larger than 10 mm.", level="ERROR")

  #Partial Response
  rtn$target_pr_wrong = rc_short %>%
    mutate(diff_rel_bl = (target_sum-sum_bl)/sum_bl) %>%
    filter(target_resp_num==2) %>%
    filter(diff_rel_bl > -0.3) %>%
    select(subjid, rc_date, target_resp, target_sum_baseline=sum_bl, target_sum,
           diff_rel_bl) %>%
    recist_issue("Partial response should have an at least 30% decrease in TL
                 tumor length sum",
                 level="ERROR")

  #Partial Response
  rtn$target_pd_wrong = rc_short %>%
    mutate(diff_abs_nad = target_sum-sum_nadir,
           diff_rel_nad = diff_abs_nad/sum_nadir) %>%
    filter(target_resp_num!=4 & !post_pd) %>%
    filter(diff_rel_nad >= 1.2 & diff_abs_nad >= 5) %>%
    select(subjid, rc_date, target_resp, target_sum_nadir=sum_nadir, target_sum,
           diff_rel_nad, diff_abs_nad) %>%
    recist_issue("Target lesions that are at least 20% and 5mm larger than the
    nadir should
                 be classified as Progressive Disease.",
                 level="ERROR")

  rtn
}


#' Check impossible cases for Target Lesions response
#' @keywords internal
check_global_response = function(rc_short){
  rtn = list()

  rtn$global_response = rc_short %>%
    mutate(
      # no non-target lesion = CR
      nontarget_resp_num = ifelse(!nontarget_yn, 1, nontarget_resp_num),
      global_resp_check = case_when(
        target_resp_num == 4 | nontarget_resp_num == 4 |  new_lesion ~ 4,
        target_resp_num == 1 & nontarget_resp_num == 1 ~ 1,
        target_resp_num <= 2 ~ 2,
        target_resp_num <= 3 ~ 3,
        target_resp_num == 99 ~ 99,
        .default = -99
      )
    ) %>%
    filter(global_resp_num != global_resp_check) %>%
    arrange(desc(global_resp_check)) %>%
    transmute(subjid, rc_date,
              target_resp,
              nontarget_yn=fct_yesno(nontarget_yn),
              nontarget_resp,
              new_lesion=fct_yesno(new_lesion),
              global_resp,
              global_resp_check=recist_decode(global_resp_check)) %>%
    recist_issue("Global Response should be consistant with TL response,
                 NTL response, and presence of new lesions", level="CHECK")

  rtn$nlt_progression = rc_short %>%
    filter(nontarget_resp_num == 4) %>%
    filter(target_resp_num != 4 | !new_lesion) %>%
    transmute(subjid, rc_date,
              target_resp,
              nontarget_yn=fct_yesno(nontarget_yn),
              nontarget_resp, new_lesion) %>%
    recist_issue("Progressions due only to Non-Target Lesions are seldom and
               should be checked", level="CHECK")


  rtn
}



# Data ----------------------------------------------------------------------------------------



.summarise_recist = function(rc){

  # col_bak = c("target_sum_bak"="target_sum",
  #             "target_sum_bl_bak"="target_sum_bl",
  #             "target_sum_min_bak"="target_sum_min")
  # col_bak = NULL

  rc_short = rc %>%
    # rename(any_of(col_bak)) %>%
    # mutate(across(any_of(col_bak), ~.x[1]),
    #        .by=c(subjid, rc_date)) %>% #in case of duplicates
    summarise(
      target_resp = target_resp[1],
      nontarget_resp = nontarget_resp[1],
      global_resp = global_resp[1],
      new_lesion = any(new_lesions=="Yes"),
      nontarget_yn = any(nontarget_yn=="Yes"),
      target_sum = sum(target_diam, na.rm=TRUE),
      .by=c(subjid, rc_date)
      # .by=c(subjid, rc_date, any_of(names(col_bak)))
    ) %>%
    mutate(
      across(ends_with("_resp"), recist_encode, .names="{.col}_num"),
      baseline = rc_date == min_narm(rc_date),
      post_pd = rc_date > min_narm(rc_date[global_resp_num==4]),
      sum_bl = target_sum[baseline],
      sum_nadir = cummin(replace_na(target_sum, Inf)),
      .by=c(subjid)
    )
}


.apply_recist_mapping = function(data, mapping){

  mandatory = c("subjid", "rc_date",
                "target_site", "target_diam", "target_resp",
                "nontarget_yn", "nontarget_resp",
                "new_lesions", "global_resp")

  rtn = data %>%
    as_tibble() %>%
    select(any_of(mapping)) %>%
    select(all_of(mandatory), everything()) %>%
    arrange(subjid, rc_date) %>%
    mutate(new_lesions = fct_yesno(new_lesions),
           nontarget_yn = fct_yesno(nontarget_yn))

  if(!has_name(rtn, "target_is_node")){
    rtn$target_is_node = str_detect(tolower(rtn$target_site), "node")
  }

  rtn
}

# Issues --------------------------------------------------------------------------------------


recist_issue = function(data, message, level="ERROR"){
  data = if(nrow(data)>0) data else NULL
  message = str_replace_all(message, "\\n *", " ")
  tibble(
    message,
    n_subjid=length(unique(data$subjid)),
    level,
    data=list(data)
  )
}

#Not Evaluable
recist_issue_ne = function(message, level="ERROR"){
  tibble(
    message,
    n_subjid=NA,
    level,
    data=NA
  )
}



# RECIST numeric encoding ---------------------------------------------------------------------

recist_encode = function(x){
  x2 = tolower(x)
  rtn = case_when(
    is.na(x) ~ NA,
    str_detect(x2, "complete") ~ 1,
    str_detect(x2, "partial") ~ 2,
    str_detect(x2, "stable") ~ 3,
    str_detect(x2, "non.*cr.*pd") ~ 3,
    str_detect(x2, "progr") ~ 4,
    str_detect(x2, "not") ~ 99,
    .default=-Inf
  )
  if(any(is.infinite(rtn))){
    cli_warn("Error in recist encoding: {.val {unique(x[is.infinite(rtn)])}}")
  }
  assert(is.numeric(rtn))
  rtn
}

recist_decode = function(x) {
  assert(is.numeric(x))
  x[x==99] = 5
  factor(x, levels=c(1:5), labels=c("CR", "PR", "SD", "PD", "Not evaluable"))
}

# Print ---------------------------------------------------------------------------------------

print.check_recist = function(x, n=Inf, ...){
  cat_rule("RECIST check", col="violet")
  x_tbl = remove_class(x, "check_recist") %>%
    format(n=n) %>%
    tail(-1) #remove "A tibble: n × p"
  cat(x_tbl, sep="\n")
}

