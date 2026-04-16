


test_that("calc_best_response", {
  local_options(grstat_lifecycle_verbosity="quiet")
  expect_snapshot({
    db = grstat_example(N=500)
    data_br = calc_best_response(db$recist)
    as.data.frame(data_br)
  })
})


test_that("validation best response", {
  local_reproducible_output(width=125)

  cats = c("CR","PR","SD","PD","NE")

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

  test = c(212,"CR-CR-NA-NA","CR","CR",NA,NA)
  grid = rbind(grid, test) %>%
    mutate(subjid = as.numeric(subjid))

  base_recist =  grid %>%
    transmute(subjid=row_number(), RCRESP = stringr::str_split(paste0("NA-", seq), "-")) %>%
    unnest(RCRESP) %>%
    mutate(RCRESP=na_if(RCRESP, "NA"),
           RCTLSUM = 1) %>% #sum for watefall, osef
    mutate(
      k=row_number(),
      RCDT = lubridate::today() + k,
      RCDT1 = lubridate::today() + k*12,
      RCDT2 = lubridate::today() + k*27,
      RCDT3 = lubridate::today() + k*29,
      .by = subjid
    )

  cols1 = c(rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT1", subjid="SUBJID")
  cols2 = c(rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT2", subjid="SUBJID")
  cols3 = c(rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT3", subjid="SUBJID")

  best_response = calc_best_response(base_recist) %>%
    select(subjid, best_response_unconfirmed = best_response)
  best_response_conf_inf_12 = calc_best_response(base_recist, cols = cols1, confirmed = TRUE) %>%
    select(subjid, best_response_conf_inf_12 = best_response)
  best_response_conf_inf_28 = calc_best_response(base_recist, cols = cols2, confirmed = TRUE) %>%
    select(subjid, best_response_conf_inf_28 = best_response)
  best_response_conf_sup_28 = calc_best_response(base_recist, cols = cols3, confirmed = TRUE) %>%
    select(subjid, best_response_conf_sup_28 = best_response)

  verif = grid %>%
    select(subjid, seq) %>%
    left_join(best_response, by = "subjid") %>%
    left_join(best_response_conf_inf_12 , by = "subjid") %>%
    left_join(best_response_conf_inf_28 , by = "subjid")  %>%
    left_join(best_response_conf_sup_28 , by = "subjid")

  expect_snapshot({
    as.data.frame(verif)
  })
})

test_that("Non excluion patient", {
  local_reproducible_output(width=125)

   non_excl_unconf = tibble(
    SUBJID = 145,
    RCDT = c(lubridate::today(), lubridate::today()+28),
    RCTLSUM = c(100, NA),
    RCRESP = c(NA, "CR"),
  ) %>%
    calc_best_response(rc_date="RCDT", rc_sum="RCTLSUM", rc_resp="RCRESP")

   non_excl_conf = tibble(
     SUBJID = 145,
     RCDT = c(lubridate::today(), lubridate::today()+28),
     RCTLSUM = c(100, NA),
     RCRESP = c(NA, "CR"),
   ) %>%
     calc_best_response(rc_date="RCDT", rc_sum="RCTLSUM", rc_resp="RCRESP", confirmed = TRUE)

  expect_snapshot({
    as.data.frame(non_excl_unconf)
    as.data.frame(non_excl_conf)
  })
})
