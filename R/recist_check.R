
grstat_env = rlang::new_environment()
grstat_env$rc_list = list()


#' @importFrom cli cli_inform
#' @importFrom dplyr across any_of arrange case_when count distinct filter group_by mutate n_distinct recode select semi_join summarise ungroup
#' @importFrom rlang env
#' @importFrom stats na.omit rnorm
#' @importFrom stringr str_detect
#' @importFrom tidyr fill pivot_longer replace_na
#' @importFrom tibble as_tibble
#' @importFrom tidyselect all_of everything where
check_recist = function(rc, mapping=gr_recist_mapping()){



  check_bare_recist(rc)

  db_recist = .get_recist_data(rc, mapping)
  check_response(db_recist)


  browser()
  rtn = grstat_env$rc_list %>%
    bind_rows() %>%
    arrange(desc(n_subjid))
  invisible(rtn)
}

.get_recist_data = function(rc, mapping){

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
    .add_to_recist_issues("Problème dans global_resp_check_num")
  rtn %>%
    filter(global_resp_check_num==-999) %>%
    .add_to_recist_issues("Problème dans global_resp_2")

  rtn
}



gr_recist_mapping = function(){
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
check_bare_recist = function(rc, mapping=gr_recist_mapping()){

  rc = rc %>%
    as_tibble() %>%
    select(!!!mapping)

  #recalcul/vérification des TL sum Baseline et Nadir
  # browser()
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

  #en cas de correction de la valeur baseline, le calcul automatique peut être faux par endroits
  rc %>%
    arrange(subjid) %>%
    filter(length(unique(na.omit(target_sum_bl)))>1, .by=subjid) %>%
    .add_to_recist_issues("RCTLBL has multiple values", level="WARNING")

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

  #Là aucun doute, sauf à la limite en Xray
  rc %>%
    arrange(subjid) %>%
    filter(str_detect(target_resp, "Complete") & target_sum>10) %>%
    .add_to_recist_issues("RCTLRESP=CR avec des lésions >10", level="ERROR")

  #one date = one sum
  rc %>%
    filter(n_distinct(target_sum, na.rm=TRUE)>1,
           .by=c(subjid, rc_date)) %>%
    .add_to_recist_issues("Plusieurs valeurs par date ?", level="ERROR")

  #new lesion == progression non?
  rc %>%
    filter(new_lesions == "1-Yes" & global_resp!="4-Progressive disease") %>%
    .add_to_recist_issues("Nouvelles lésions mais pas de progression", level="ERROR")

  #structure du CRF, à transformer?
  rc %>%
    filter(is.na(target_order)+is.na(new_lesions_order)+is.na(nontarget_order) < 2) %>%
    .add_to_recist_issues("CRF structure issue: missing orders", level="ERROR")
  rc %>%
    filter(is.na(target_site)+is.na(nontarget_site)+is.na(new_lesions_site) < 2) %>%
    .add_to_recist_issues("CRF structure issue: missing sites", level="ERROR")

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

.add_to_recist_issues = function(data, message, level="ERROR"){
  code = .make_clean_name(message)
  data = if(nrow(data)>0) data else NULL
  issue = tibble(
    message,
    n_subjid=length(unique(data$subjid)),
    level,
    data=list(data)
  )

  grstat_env$rc_list[[code]] = issue
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
