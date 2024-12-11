

#' @importFrom cli cli_inform
#' @importFrom dplyr across any_of arrange case_when count distinct filter group_by mutate n_distinct recode select semi_join summarise ungroup
#' @importFrom rlang env
#' @importFrom stats na.omit rnorm
#' @importFrom stringr str_detect
#' @importFrom tidyr fill pivot_longer replace_na
#' @importFrom tibble as_tibble
#' @importFrom tidyselect all_of everything where
check_recist = function(rc, mapping=edc_recist_mapping()){

  #TODO : plutôt que grstat_data_warn, output une tibble avec une ligne par issue


  check_bare_recist(rc)

  db_recist = .get_db_recist(rc, mapping)


  db_recist %>%
    # filter(!post_pd) %>% #on verra après pour les post PD
    filter(global_resp_check_num != global_resp_num) %>%
    distinct(subjid, rc_date, crf_n, target_resp, nontarget_present, nontarget_resp, new_lesions,
             global_resp, global_resp_check)
  # %>%
  # grstat_data_warn("Global response RCRESP incohérente avec RCTLRESP et RCNTLRES")


  # db_recist %>%
  #   filter(subjid==6) %>%
  #   select(subjid, crf_n, grp_n, target_resp, post_pd) %>% vv
  db_recist %>%
    filter(subjid==6) %>%
    distinct(subjid, crf_n, target_resp, post_pd, target_sum)

  pb = db_recist %>%
    filter(!post_pd) %>% #on verra après pour les post PD
    distinct(subjid, rc_date, crf_n, target_resp, target_resp2) %>%
    # select(-c(RCNTLYN:global_resp), -CRFSTAT)  %>%
    # arrange(target_resp)%>%
    filter(target_resp != target_resp2)

  # pb %>%
  #   grstat_data_warn("Différences de Target Lesions response", issue_n=NULL)

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

  "WIP"
}

.get_db_recist = function(rc, mapping){

  rtn = rc %>%
    as_tibble() %>%
    select(!!!mapping) %>%
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
    grstat_data_warn("Problème dans global_resp_check_num")
  rtn %>%
    filter(global_resp_check_num==-999) %>%
    grstat_data_warn("Problème dans global_resp_2")

  rtn
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

edc_recist_mapping = function(){
  list(
    subjid="SUBJID", crf_n="CRFINSNO", grp_n="GRPINSNO", rc_date="RCDT",

    target_order="RCTLORD", target_site="RCTLSITE", target_method="RCTLMOD", target_diam="RCTLDIAM",
    target_sum="RCTLSUM", target_sum_bl="RCTLBL", target_sum_min="RCTLMIN", target_resp="RCTLRESP",

    nontarget_yn="RCNTLYN", nontarget_resp="RCNTLRES", nontarget_site="RCNTLSIT",
    nontarget_present="RCNTLPRE", nontarget_order="RCNTLORD",

    new_lesions="RCNEW", new_lesions_order="RCNEWORD", new_lesions_site="RCNEWSIT",

    global_resp="RCRESP"
  )
}

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



check_bare_recist = function(rc, mapping=edc_recist_mapping()){

  rc = rc %>%
    as_tibble() %>%
    select(!!!mapping)

  #recalcul/vérification des TL sum Baseline et Nadir
  # browser()
  rc %>%
    arrange(subjid) %>%
    filter(any(target_sum_bl != unify(target_sum[crf_n==1])), .by=subjid) %>%
    select(subjid, rc_date, crf_n, target_sum, target_sum_bl, everything()) %>%
    grstat_data_warn("RCTLBL différent de valeur baseline", max_subjid=10)
  rc %>%
    arrange(subjid, crf_n, grp_n) %>%
    mutate(sum_nadir = cummin(target_sum),
           .by = subjid, .after=target_sum) %>%
    filter(any(target_sum_min != sum_nadir), .by=subjid) %>%
    select(subjid, crf_n, grp_n, rc_date, crf_n, target_sum, target_sum_min, sum_nadir, everything()) %>%
    grstat_data_warn("RCTLMIN différent de valeur minimale")

  #en cas de correction de la valeur baseline, le calcul automatique peut être faux par endroits
  rc %>%
    arrange(subjid) %>%
    filter(length(unique(na.omit(target_sum_bl)))>1, .by=subjid) %>%
    grstat_data_warn("RCTLBL a des valeurs multiples")

  #taille minimale pour être mesurable: 10mm si CTscan ou clinique (caliper), 20mm si Xray
  #TODO calcul différent selon la technique?
  rc %>%
    filter(crf_n==1 & target_sum<10) %>%
    grstat_data_warn("Non measurable (<10mm) target lesions at baseline")

  #cf hypothèses RECIST: est-ce que <10 ça peut être CR?
  rc %>%
    arrange(subjid) %>%
    filter(str_detect(target_resp, "Complete") & target_sum>0) %>%
    select(subjid, target_resp, target_sum) %>%
    distinct() %>%
    grstat_data_warn("RCTLRESP=CR avec des lésions restantes")
  #Là aucun doute, sauf à la limite en Xray
  rc %>%
    arrange(subjid) %>%
    filter(str_detect(target_resp, "Complete") & target_sum>10) %>%
    grstat_data_warn("RCTLRESP=CR avec des lésions >10")

  #one date = one sum
  rc %>%
    filter(n_distinct(target_sum, na.rm=TRUE)>1,
           .by=c(subjid, rc_date)) %>%
    grstat_data_warn("Plusieurs valeurs par date ?")

  #new lesion == progression non?
  rc %>%
    filter(new_lesions == "1-Yes" & global_resp!="4-Progressive disease") %>%
    grstat_data_warn("Nouvelles lésions mais pas de progression")

  #structure du CRF, à transformer?
  rc %>%
    filter(is.na(target_order)+is.na(new_lesions_order)+is.na(nontarget_order) < 2) %>%
    grstat_data_warn("Problème de structure du CRF")
  rc %>%
    filter(is.na(target_site)+is.na(nontarget_site)+is.na(new_lesions_site) < 2) %>%
    grstat_data_warn("Problème de structure du CRF")

  #Hypothèses très importante, sinon `crf_n==1` ne marche pas
  rc %>%
    arrange(subjid) %>%
    filter(crf_n==1) %>%
    select(subjid, target_resp, nontarget_resp, global_resp) %>%
    pivot_longer(-subjid) %>%
    filter(!is.na(value)) %>%
    grstat_data_warn("ERREUR Réponse non manquante à baseline")
  rc %>%
    arrange(subjid) %>%
    filter((crf_n==1) != (rc_date==min(rc_date)), .by=subjid) %>%
    grstat_data_warn("ERREUR Visite antérieure à baseline")
}


unify = function (x) {
  rtn = x[1]
  lu = length(unique(na.omit(x)))
  if (lu > 1) {
    cli_warn(c("Unifying multiple values in {.val {caller_arg(x)}}, returning the first one ({.val {rtn})}",
               i = "Unique values: {.val {unique(na.omit(x))}}"))
  }
  rtn_label = get_label(x)
  if (!is.null(rtn_label))
    attr(rtn, "label") = rtn_label
  rtn
}
