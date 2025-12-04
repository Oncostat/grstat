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

  set.seed(123)
  data_na =
    data_best_resp %>%
    dplyr::mutate(
      target_sum_diff_first = runif(n(), -0.6, 0.3),
      target_sum_diff_first = replace(target_sum_diff_first, c(1, 3, 10), NA)
    )

  expect_warning(
    p <- waterfall_plot(data_na, warnings = TRUE),
    regexp = "ignore"
  )


})
