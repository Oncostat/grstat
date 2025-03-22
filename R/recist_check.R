
grstat_env = rlang::new_environment()
grstat_env$rc_list = list()



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
  db_recist = .get_recist_data(rc)
  rc_short = .summarise_recist(rc)

  checks = c(
    check_missing(rc),
    check_target_lesions(rc),
    check_constancy(rc),
    check_baseline_lesions(rc),
    check_derived_columns(rc), #TODO conditional checks
    check_target_response(rc, rc_short),
    check_global_response(rc_short)
  )

  rtn = checks %>%
    list_rbind() %>%
    arrange(desc(n_subjid))

  rtn
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

#TODO changer nom: on calcule les variables dérivées (sum, nadir...)
check_bare_recist = function(rc){

  rtn = list()

  #recalcul/vérification des TL sum Baseline et Nadir
  rc %>%
    arrange(subjid) %>%
    filter(any(target_sum_bl != unify(target_sum[crf_n==1])), .by=subjid) %>%
    select(subjid, rc_date, crf_n, target_sum, target_sum_bl, everything()) %>%
    .add_to_recist_issues("RCTLBL is incorrect", level="WARNING")

  rc %>%
    arrange(subjid, crf_n, grp_n) %>%
    mutate(sum_nadir = cummin(target_sum),
           .by = subjid, .after=target_sum) %>%
    filter(any(target_sum_min != sum_nadir), .by=subjid) %>%
    select(subjid, crf_n, grp_n, rc_date, crf_n, target_sum, target_sum_min, sum_nadir, everything()) %>%
    .add_to_recist_issues("RCTLMIN is incorrect", level="WARNING")
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
    select(subjid, crf_n, rc_date, target_sum_min) %>%
    recist_issue("Dataset's minimum target lesion length sum (nadir) has multiple values",
                 level="WARNING")

  #en cas de correction de la valeur baseline, le calcul automatique peut être faux par endroits
  rc %>%
  rtn$target_sum_bl_real_dupl = rc %>%
    arrange(subjid, rc_date) %>%
    filter(rc_date==min(rc_date, na.rm=TRUE),
           .by=subjid) %>%
    filter(length(unique(na.omit(target_sum)))>1, .by=subjid) %>%
    select(subjid, crf_n, rc_date, target_sum) %>%
    recist_issue("Real baseline target lesion length sum has multiple values",
                 level="WARNING")

  #check for wrong values
  rtn$target_sum_wrong = rc %>%
    arrange(subjid) %>%
    filter(length(unique(na.omit(target_sum_bl)))>1, .by=subjid) %>%
    .add_to_recist_issues("RCTLBL has multiple values", level="WARNING")
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

  #taille minimale pour être mesurable: 10mm si CTscan ou clinique (caliper), 20mm si Xray
  #TODO calcul différent selon la technique?
  rc %>%
    filter(crf_n==1 & target_sum<10) %>%
    .add_to_recist_issues("Non measurable (<10mm) target lesions at baseline", level="ERROR")

  #cf hypothèses RECIST: est-ce que <10 ça peut être CR?
  rc %>%
    arrange(subjid) %>%
    filter(str_detect(target_resp, "Complete") & target_sum>0) %>%
    select(subjid, target_resp, target_sum) %>%
    distinct() %>%
    .add_to_recist_issues("RCTLRESP=CR avec des lésions restantes", level="ERROR")
    mutate(target_sum_bl_real = target_sum[rc_date==min(rc_date, na.rm=TRUE)][1],
           .by=subjid) %>%
    filter((target_sum_bl != target_sum_bl_real)) %>%
    distinct(subjid, rc_date, target_sum_bl, target_sum_bl_real) %>%
    nest(rc_dates=rc_date) %>%
    recist_issue("Baseline target lesion length sum is incorrect",
                 level="WARNING")

  rtn$target_sum_min_wrong = rc %>%
    arrange(subjid, crf_n, grp_n) %>%
    mutate(sum_nadir = cummin(target_sum),
           .by = subjid, .after=target_sum) %>%
    filter(any(target_sum_min != sum_nadir), .by=subjid) %>%
    select(subjid, crf_n, grp_n, rc_date, crf_n, target_sum, target_sum_min,
           sum_nadir, everything()) %>%
    recist_issue("Minimum target lesion length sum (nadir) is incorrect",
                 level="WARNING")

  #Là aucun doute, sauf à la limite en Xray
  rc %>%
    arrange(subjid) %>%
    filter(str_detect(target_resp, "Complete") & target_sum>10) %>%
    .add_to_recist_issues("RCTLRESP=CR avec des lésions >10", level="ERROR")

  #one date = one sum
  rc %>%
  rtn$target_sum_date_dup = rc %>%
    filter(n_distinct(target_sum, na.rm=TRUE)>1,
           .by=c(subjid, rc_date)) %>%
    .add_to_recist_issues("Plusieurs valeurs par date ?", level="ERROR")
    recist_issue("Several target_sum values per date", level="ERROR")

  rtn
}


  #new lesion == progression non?
  rc %>%
    filter(new_lesions == "1-Yes" & global_resp!="4-Progressive disease") %>%
    .add_to_recist_issues("Nouvelles lésions mais pas de progression", level="ERROR")
#' Check impossible cases for Target Lesions response
#' @keywords internal
check_target_response = function(rc, rc_short){
  rtn = list()

  #structure du CRF, à transformer?
  rc %>%
    filter(is.na(target_order)+is.na(new_lesions_order)+is.na(nontarget_order) < 2) %>%
    .add_to_recist_issues("CRF structure issue: missing orders", level="ERROR")
  rc %>%
    filter(is.na(target_site)+is.na(nontarget_site)+is.na(new_lesions_site) < 2) %>%
    .add_to_recist_issues("CRF structure issue: missing sites", level="ERROR")
  #Complete Response
  #CR = Disappearance of all target lesions. Lymph nodes must be <10 mm.
  rtn$target_cr_remaining = rc %>%
    arrange(subjid) %>%
    filter(recist_encode(target_resp) == 1) %>%
    mutate(remaining_node = target_is_node & target_diam>=10,
           remaining_lesion = !target_is_node & target_diam>0) %>%
    filter(remaining_node | remaining_lesion) %>%
    distinct(subjid, crf_n, rc_date, target_resp, target_site, target_diam) %>%
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


  rtn
}

  #Hypothèses très importante, sinon `crf_n==1` ne marche pas
  rc %>%
    arrange(subjid) %>%
    filter(crf_n==1) %>%
    select(subjid, target_resp, nontarget_resp, global_resp) %>%
    pivot_longer(-subjid) %>%
    filter(!is.na(value)) %>%
    .add_to_recist_issues("Baseline response is not missing", level="ERROR")
  rc %>%
    arrange(subjid) %>%
    filter((crf_n==1) != (rc_date==min(rc_date)), .by=subjid) %>%
    .add_to_recist_issues("Visit before baseline", level="ERROR")
}


check_response = function(db_recist){


  db_recist %>%
    # filter(!post_pd) %>% #on verra après pour les post PD
    filter(global_resp_check_num != global_resp_num) %>%
    distinct(subjid, rc_date, crf_n, target_resp,
             nontarget_present, nontarget_resp, new_lesions,
             global_resp, global_resp_check)
  # %>%
  # .add_to_recist_issues("Global response RCRESP incohérente avec RCTLRESP et RCNTLRES")


  # db_recist %>%
  #   filter(subjid==6) %>%
  #   select(subjid, crf_n, grp_n, target_resp, post_pd) %>% vv
  # db_recist %>%
  #   filter(subjid==6) %>%
  #   distinct(subjid, crf_n, target_resp, post_pd, target_sum)

  pb = db_recist %>%
    filter(!post_pd) %>% #on verra après pour les post PD
    distinct(subjid, rc_date, crf_n, target_resp, target_resp2) %>%
    # select(-c(RCNTLYN:global_resp), -CRFSTAT)  %>%
    # arrange(target_resp)%>%
    filter(target_resp != target_resp2)

  pb %>%
    .add_to_recist_issues("Différences de Target Lesions response", level="ERROR")

  cli_inform("There are {nrow(pb)} Target Lesions differences, in {n_distinct(pb$subjid)} patients.")

  # rc_short ----
  #une ligne par patient+date+lésion
  db_recist %>%
    summarise(
      .by = c(subjid, crf_n, rc_date)
    )

  # rc_short ----
  #une ligne par patient+date+lésion
  rc_short =
    db_recist %>%
    filter(!is.na(target_site) | !is.na(nontarget_site) | !is.na(new_lesions_site)) %>%
    group_by(subjid, crf_n, grp_n, rc_date) %>%
    fill(everything(), .direction="updown") %>%
    ungroup() %>%
    distinct() %>%
    mutate(target_node = str_detect(target_site, "Lymph node"), .after=target_site) %>%
    mutate(nontarget_node = str_detect(nontarget_site, "Lymph node"), .after=nontarget_site) %>%
    arrange(subjid)

  rc_short %>%
    semi_join(pb, by=c("subjid", "rc_date", "crf_n")) %>%
    select(subjid, crf_n, grp_n, rc_date, post_pd, target_resp, target_resp_dan=target_resp2, target_site,
           target_node, target_diam, target_sum, starts_with("target_"))

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

.get_recist_data = function(rc){

  rtn = rc %>%
    mutate(target_site = str_remove(target_site, "\\(.*\\)")) %>% #TODO: remove in final version
    arrange(subjid, crf_n, grp_n, rc_date) %>%
    mutate(target_resp_num = recist_encode(target_resp), .after=target_resp) %>%
    mutate(nontarget_resp_num = recist_encode(nontarget_resp), .after=nontarget_resp) %>%
    mutate(global_resp_num = recist_encode(global_resp), .after=global_resp) %>%
    mutate(sum_bl = unify(target_sum[crf_n==1]),
           sum_nadir = cummin(replace_na(target_sum, Inf)),
           .by = subjid, .after=target_sum) %>%
    # mutate(post_pd = cumsum(replace_na(target_resp, factor("5-Not evaluable"))=="4-Progressive disease"),
    # .by = subjid, .after=target_resp) %>%
    mutate(post_pd = crf_n>min_narm(crf_n[target_resp_num==4]),
           .by = subjid, .after=target_resp) %>%
    mutate(
      nodes_sup_10 = case_when(#TODO?
        str_detect(target_site, "Lymph node") & target_diam>=10 ~ TRUE,
        # str_detect(nontarget_site, "Lymph node") & nontarget_present=="1-Yes" ~ TRUE,
        str_detect(nontarget_site, "Lymph node") & nontarget_present=="1-Yes" ~ TRUE,
        .default=FALSE
      ),

      diff_abs_bl = target_sum-sum_bl,
      diff_rel_bl = diff_abs_bl/sum_bl,
      diff_abs_nad = target_sum-sum_nadir,
      diff_rel_nad = diff_abs_bl/sum_nadir,

      target_resp22 = case_when(
        crf_n==1 ~ NA, #baseline
        diff_rel_nad >= 1.2 & diff_abs_nad >= 5 ~ 4, #progression

        # target_sum<10 ~ 1, #FIXME à vérifier avec Raph! Dépend ptet de la méthode de mesure
        # target_sum>5 & target_sum>sum_nadir*1.2 ~ 4,
        target_sum/sum_bl == 0 ~ 1,
        target_sum/sum_bl < 0.7 ~ 2,
        target_sum/sum_bl > 1.2 ~ 4,
        target_sum/sum_bl < 2 ~ 3,
        .default=-99
      ),
      target_resp2 = recist_target_response(crf_n, diff_rel_bl, diff_rel_nad, diff_abs_nad),
      non_target_resp2 = 1,
      new_lesions = new_lesions == "1-Yes",

      global_resp2 = case_when(
        target_resp2 == 1 & non_target_resp2 == 1 & !new_lesions ~ 1,
        target_resp2 <= 2 & non_target_resp2 <= 3 & !new_lesions ~ 2,
        target_resp2 <= 3 & non_target_resp2 <= 3 & !new_lesions ~ 3,
        target_resp2 == 4 | non_target_resp2 == 4 |  new_lesions ~ 4,
        .default=-99
      ),

      nontarget_resp_num = ifelse(fct_yesno(nontarget_yn)=="No", 1, nontarget_resp_num),
      global_resp_check_num = case_when(
        target_resp_num == 1 & nontarget_resp_num == 1 & !new_lesions ~ 1,
        target_resp_num <= 2 & nontarget_resp_num <= 3 & !new_lesions ~ 2,
        target_resp_num <= 3 & nontarget_resp_num <= 3 & !new_lesions ~ 3,
        target_resp_num == 4 | nontarget_resp_num == 4 |  new_lesions ~ 4,
        .default=-99
      ),

      # target_resp_dan = case_when(
      #   # crf_n==1 ~ "Baseline",
      #   new_lesions == "1-Yes" ~ "4-PD",
      #   .default=target_resp_dan
      # ),

      target_resp2 = recist_decode(target_resp2),
      target_resp = recist_decode(target_resp_num),
      global_resp_check = recist_decode(global_resp_check_num),

    ) %>%
    select(subjid, crf_n, grp_n, rc_date, post_pd, target_resp, target_resp2, target_site,
           # target_node,
           target_diam, target_sum, starts_with("target_"), everything())

  rtn %>%
    filter(global_resp2==-999) %>%
    .add_to_recist_issues("Problème dans global_resp_check_num")
  rtn %>%
    filter(global_resp_check_num==-999) %>%
    .add_to_recist_issues("Problème dans global_resp_2")

  rtn
}



#' TODO document
#' @export
gr_recist_mapping = function(){
  c(
    subjid="SUBJID", crf_n="CRFINSNO", grp_n="GRPINSNO", rc_date="RCDT",

    target_order="RCTLORD", target_site="RCTLSITE", target_is_node="RCTLNODE",
    target_method="RCTLMOD", target_diam="RCTLDIAM", target_sum="RCTLSUM",
    target_sum_bl="RCTLBL", target_sum_min="RCTLMIN", target_resp="RCTLRESP",

    nontarget_yn="RCNTLYN", nontarget_resp="RCNTLRES", nontarget_site="RCNTLSIT",
    nontarget_present="RCNTLPRE", nontarget_order="RCNTLORD",

    new_lesions="RCNEW", new_lesions_order="RCNEWORD", new_lesions_site="RCNEWSIT",

    global_resp="RCRESP"
  )
}

.apply_recist_mapping = function(data, mapping){

  mandatory = c("subjid", "rc_date",
                "target_site", "target_diam", "target_resp",
                "nontarget_yn", "nontarget_resp", #"nontarget_present",
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

.add_to_recist_issues = function(data, message, level="ERROR"){
  code = .make_clean_name(message)
  grstat_env$rc_list[[code]] = recist_issue(data, message, level)
  invisible(issue)
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

recist_target_response = function(crf_n, diff_rel_bl, diff_rel_nad, diff_abs_nad) {
  # browser()
  rtn = case_when(
    crf_n==1 ~ NA, #baseline
    diff_rel_nad >= 0.2 & diff_abs_nad >= 5 ~ 4, #PD

    diff_rel_bl == -1 ~ 1, #CR
    diff_rel_bl <= -0.3 ~ 2, #PR
    .default=3 #SD
  )

  rtn
}

# Utils ---------------------------------------------------------------------------------------

  rtn
}

.make_clean_name = function (string, from="") {
  old_names <- string
  new_names <- old_names %>% gsub("'", "", .) %>% gsub("\"", "", .) %>% gsub("%", "percent", .) %>%
    gsub("^[ ]+", "", .) %>% make.names(.) %>% gsub("[.]+", "_", .) %>% gsub("[_]+", "_", .) %>%
    tolower(.) %>% gsub("_$", "", .) %>% iconv(from = from, to = "ASCII//TRANSLIT") %>%
    str_remove_all("[\r\n]")
  dupe_count <- vapply(seq_along(new_names), function(i) {sum(new_names[i] == new_names[1:i])},
                       integer(1))
  new_names[dupe_count > 1] <- paste(new_names[dupe_count > 1], dupe_count[dupe_count > 1], sep = "_")
  new_names
}
