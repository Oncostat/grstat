


test_that("calc_best_response", {
  local_options(grstat_lifecycle_verbosity="quiet")
  expect_snapshot({
    db = grstat_example(N=500)
    data_br = calc_best_response(db$recist)
    as.data.frame(data_br)
  })
})


test_that("waterfall_plot", {
  local_options(grstat_lifecycle_verbosity="quiet")

  db = grstat_example(N=50)
  data_best_resp = calc_best_response(db$recist)

  #simple example
  p1 = waterfall_plot(data_best_resp)
  vdiffr::expect_doppelganger("waterfall-plot-default", p1)

  #facet by arm
  p2 = data_best_resp %>%
    left_join(db$enrolres, by="subjid") %>%
    waterfall_plot(arm="ARM")
  vdiffr::expect_doppelganger("waterfall-plot-arms", p2)


  #add symbols
  #use the NA level to not show the case
  set.seed(0)
  data_symbols = db$recist %>%
    summarise(new_lesion=ifelse(any(rcnew=="Yes", na.rm=TRUE), "New lesion", NA),
              random=cut(runif(1), breaks=c(0,0.05,0.1,1), labels=c("A", "B", NA)),
              .by=subjid)

  p3 = data_best_resp %>%
    left_join(data_symbols, by="subjid") %>%
    waterfall_plot(shape="new_lesion")
  vdiffr::expect_doppelganger("waterfall-plot-shape1", p3)

  p4 = data_best_resp %>%
    left_join(data_symbols, by="subjid") %>%
    waterfall_plot(shape="random") +
    labs(shape="Event")
  vdiffr::expect_doppelganger("waterfall-plot-shape2", p4)
})


test_that("validation best response", {
  local_reproducible_output(width=125)

    cats = c("CR","PR","SD","PD")
    cats2 = c("CR","PR","SD","PD","NE")

  #NA pour le post-PD
  grid = tidyr::expand_grid(v1 = cats,
                            v2 = c(cats, NA),
                            v3 = c(cats, NA),
                            v4 = c(cats, NA)) %>%
    unite("seq", v1:v4, sep="-", remove = FALSE) %>%
    filter(!str_detect(seq, "NA-.*PD")) %>%  #les NA sont les visites manquantes **après** PD
    filter(!(!str_detect(seq, "PD") & str_detect(seq, "NA"))) %>%  #pas de PD = pas de NA
    filter(!str_detect(seq, "PD(?!(-NA)*$)")) %>%  #pas autre chose que NA après PD
    filter(!str_detect(seq, "CR(?!(-(CR|PD|NA|NE))*$)")) %>%  #pas autre chose que CR/PD/NE après PD
    as_tibble() %>%
    mutate(subjid=row_number(), .before=1)

  grid_NE = tidyr::expand_grid(v1 = cats2,
                            v2 = c(cats2, NA),
                            v3 = c(cats2, NA),
                            v4 = c(cats2, NA)) %>%
    unite("seq", v1:v4, sep="-", remove = FALSE) %>%
    filter(!str_detect(seq, "NA-.*PD")) %>%  #les NA sont les visites manquantes **après** PD
    filter(!(!str_detect(seq, "PD") & str_detect(seq, "NA"))) %>%  #pas de PD = pas de NA
    filter(!str_detect(seq, "PD(?!(-NA)*$)")) %>%  #pas autre chose que NA après PD
    filter(!str_detect(seq, "CR(?!(-(CR|PD|NA|NE))*$)")) %>%  #pas autre chose que CR/PD/NE après PD
    as_tibble() %>%
    filter(v1 =="NE" | v2 =="NE" | v3 =="NE" |v4 =="NE") %>%
    mutate(subjid=row_number(), .before=1)

  base_recist =  grid %>%
    transmute(subjid=row_number(), RCRESP = stringr::str_split(paste0("NA-", seq), "-")) %>%
    unnest(RCRESP) %>%
    mutate(RCRESP=na_if(RCRESP, "NA"),
           RCTLSUM = 1) %>% #sum for watefall, osef
    mutate(
      k=row_number(),
      RCDT = lubridate::today() + k*27,
      RCDT2 = lubridate::today() + k*29,
      RCDT3 = lubridate::today() + k*12,
      .by = subjid
    )

  base_recist_NE =  grid_NE %>%
    transmute(subjid=row_number(), RCRESP = stringr::str_split(paste0("NA-", seq), "-")) %>%
    unnest(RCRESP) %>%
    mutate(RCRESP=na_if(RCRESP, "NA"),
           RCTLSUM = 1) %>% #sum for watefall, osef
    mutate(
      k=row_number(),
      RCDT = lubridate::today() + k*27,
      RCDT2 = lubridate::today() + k*29,
      RCDT3 = lubridate::today() + k*12,
      .by = subjid
    )

  expect_snapshot({

    cols = c(rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT", subjid="SUBJID")
    cols2 = c(rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT2", subjid="SUBJID")
    cols3 = c(rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT3", subjid="SUBJID")

    best_response = calc_best_response(base_recist)
    best_response_conf_inf_28 = calc_best_response(base_recist, cols = cols, confirmed = TRUE)
    best_response_conf_sup_28 = calc_best_response(base_recist, cols = cols2, confirmed = TRUE)
    best_response_conf_inf_12 = calc_best_response(base_recist, cols = cols3, confirmed = TRUE)
    verif = grid %>%
      select(subjid, seq) %>%
      left_join(best_response %>% rename(best_response_unconfirmed = best_response) %>% select(subjid, best_response_unconfirmed), by = join_by(subjid)) %>%
      left_join(best_response_conf_inf_12 %>% rename(best_response_conf_inf_12 = best_response) %>% select(subjid, best_response_conf_inf_12), by = join_by(subjid)) %>%
      left_join(best_response_conf_inf_28 %>% rename(best_response_conf_inf_28 = best_response) %>% select(subjid, best_response_conf_inf_28), by = join_by(subjid)) %>%
      left_join(best_response_conf_sup_28 %>% rename(best_response_conf_sup_28 = best_response) %>% select(subjid, best_response_conf_sup_28), by = join_by(subjid))

    verif

    best_response_NE = calc_best_response(base_recist_NE)
    best_response_conf_inf_28_NE = calc_best_response(base_recist_NE, cols = cols, confirmed = TRUE)
    best_response_conf_sup_28_NE = calc_best_response(base_recist_NE, cols = cols2, confirmed = TRUE)
    best_response_conf_inf_12_NE = calc_best_response(base_recist_NE, cols = cols3, confirmed = TRUE)
    verif_NE = grid_NE %>%
      select(subjid, seq) %>%
      left_join(best_response_NE %>% rename(best_response_unconfirmed = best_response) %>% select(subjid, best_response_unconfirmed), by = join_by(subjid)) %>%
      left_join(best_response_conf_inf_12_NE %>% rename(best_response_conf_inf_12 = best_response) %>% select(subjid, best_response_conf_inf_12), by = join_by(subjid)) %>%
      left_join(best_response_conf_inf_28_NE %>% rename(best_response_conf_inf_28 = best_response) %>% select(subjid, best_response_conf_inf_28), by = join_by(subjid)) %>%
      left_join(best_response_conf_sup_28_NE %>% rename(best_response_conf_sup_28 = best_response) %>% select(subjid, best_response_conf_sup_28), by = join_by(subjid))

    verif_NE
  })
})

