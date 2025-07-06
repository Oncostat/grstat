

test_that("Proportions of AE grades are respected", {
  skip_on_ci() #random number generation

  get_rate = function(sae){
    rate = -1+sae
    probs = exp(rate * c(1:4))
    probs = c(probs, probs[4]/7) #grade 5 always minor
    probs / sum(probs)
  }
  p_ae  = get_rate(FALSE)
  p_sae = get_rate(TRUE)


  tm = grstat_example(5000, p_na=0, p_sae=0.5, beta_trt=0, seed=42)
  x = tm$ae %>% with(table(aegr, sae)) %>% prop.table(margin=2) %>% round(2)
  round(as.matrix(x)/cbind(p_sae, p_ae), 1)

  expect_equal(unname(as.matrix(x)[,"Yes"]), p_sae, tolerance=0.05) # 5% tolerance
  expect_equal(unname(as.matrix(x)[,"No"]),  p_ae,  tolerance=0.05)
})


test_that("RECIST data are ok", {

  db = grstat_example(N=500)
  rc = db$recist

  expect_false(any(rc$rcresp=="ERROR", na.rm=TRUE))
  expect_false(any(rc$rctlsum < 0, na.rm=TRUE))

  #baseline vide
  rc %>%
    filter(rcdt==min(rcdt), .by=subjid) %>%
    filter(!is.na(rcresp) | !is.na(rctlresp) | !is.na(rcntlresp) | !is.na(rcnew)) %>%
    nrow() %>%
    expect_equal(0)

  #pas de date négative
  rc %>%
    left_join(db$enrolres, by="subjid", suffix=c("_rc", "")) %>%
    select(subjid, date_inclusion, rcdt, everything()) %>%
    filter(rcdt<date_inclusion) %>%
    nrow() %>%
    expect_equal(0)

  #15% more CR, 15% less PD at all time in treatment arm
  data_resp = rc %>%
    summarise(
      any_cr_target=any(rctlresp=="Complete response", na.rm=TRUE),
      any_cr_global=any(rcresp=="Complete response", na.rm=TRUE),
      any_pd_target=any(rctlresp=="Progressive disease", na.rm=TRUE),
      any_pd_global=any(rcresp=="Progressive disease", na.rm=TRUE),
      .by=subjid
    ) %>%
    left_join(db$enrolres, by="subjid", suffix=c("_bak", "")) %>%
    summarise(across(starts_with("any_"), mean), .by=arm) %>%
    pivot_longer(-arm) %>%
    pivot_wider(names_from=arm) %>%
    mutate(diff=Treatment-Control) %>%
    select(name, diff) %>%
    deframe()
  expect_true(all(data_resp[c("any_cr_target", "any_cr_global")] > 0.15))
  expect_true(all(data_resp[c("any_pd_target", "any_pd_global")] < -0.15))

  #PFS is better in treatment arm: HR~0.5, 4yPFS difference > 0.2
  #TODO add death data
  data_km = rc %>%
    summarise(
      date_pd = min_narm(rcdt[rcresp=="Progressive disease"]),
      last_date = max_narm(rcdt),
      .by=subjid
    ) %>%
    left_join(db$enrolres, by="subjid", suffix=c("_rc", "")) %>%
    mutate(
      date_pfs = pmin(date_pd, last_date, na.rm=TRUE),
      time_pfs = as.numeric(date_pfs - date_inclusion)/30.4,
      event_pfs = !is.na(date_pd)
    )
  expect_true(all(data_km$time_pfs > 0))

  cox = survival::coxph(survival::Surv(time_pfs, event_pfs) ~ arm, data=data_km)
  expect_true(coef(cox) < - 0.7)

  km = survival::survfit(survival::Surv(time_pfs, event_pfs) ~ arm, data=data_km)
  surv_diff_arm_5m = summary(km, times = 4)$surv %>% diff()
  expect_true(surv_diff_arm_5m > 0.2)

})


test_that("RECIST plots", {
  skip("Skip RECIST plots, kept for dev vizualisation")

  db = grstat_example(N=500)
  rc = db$recist %>%
    left_join(x$enrolres, by="subjid", suffix=c("_bak", ""))

  # KM plot
  km = survival::survfit(survival::Surv(time_pfs, event_pfs) ~ arm, data=data_km)
  ggsurvfit::ggsurvfit(km) +
    ggsurvfit::add_censor_mark() +
    ggsurvfit::add_confidence_interval()


  # spaghetti plot from baseline
  rc %>%
    mutate(t = as.numeric(rcdt-date_inclusion)/30.5) %>%
    mutate(rctlsum_chg = (rctlsum-first(rctlsum, order_by=rcdt))/rctlsum, .by=subjid) %>%
    filter(!is.na(t)) %>%
    ggplot() +
    aes(x=t, y=rctlsum_chg, color=arm, group=subjid, rcresp=rcresp, rcvisit=rcvisit) +
    geom_point(alpha=0.2) +
    geom_line(alpha=0.2)

  # TL response repartition plot
  rc %>%
    filter(rcvisit>1) %>%
    pivot_longer(c(rctlresp)) %>%
    # pivot_longer(c(rctlresp, rcntlresp, rcnew, rcresp)) %>%
    ggplot(aes(x=value, fill=arm)) +
    geom_bar(position="dodge") +
    facet_wrap(~name, scale="free") +
    theme(axis.text.x=element_text(angle=45, hjust=1, vjust=1))

  # TL response repartition crosstable
  rc %>%
    filter(rcvisit>1) %>%
    # filter(rcvisit==max(rcvisit), .by=subjid) %>%
    mutate(rcvisit=factor(rcvisit)) %>%
    crosstable(c(ends_with("resp"), rcnew), by=arm, margin=2) %>%
    # crosstable(c(rcvisit), by=rctlresp, margin=2) %>%
    # crosstable(c(ends_with("resp"), rcnew), margin=2) %>%
    af(T, header_show_n=T) %>%
    print()
})




