
test_that("ae_plot_grade() works", {
  ae = db_test$ae
  enrolres = db_test$enrolres
  rlang::local_options(ae_table_grade_na_strategy = list(display="if_any", grouped=FALSE))

  p = ae_plot_grade(data_ae=ae, data_pat=enrolres)
  vdiffr::expect_doppelganger("ae-plot-grade-1arm", p)
  p = ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", measure=c("sup", "max"))
  vdiffr::expect_doppelganger("ae-plot-grade-2arms", p)
  p = ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", type="absolute")
  vdiffr::expect_doppelganger("ae-plot-grade-2arms-absolute", p)
  p = ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", position="fill")
  vdiffr::expect_doppelganger("ae-plot-grade-2arms-fill", p)
  p = ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", position="stack", type="absolute")
  vdiffr::expect_doppelganger("ae-plot-grade-2arms-stack", p)

})

test_that("ae_plot_grade() with old argument names", {
  a = ae_plot_grade(db_test$ae, data_pat=db_test$enrolres, measure ="sup")
  b = ae_plot_grade(df_ae=db_test$ae, df_enrol=db_test$enrolres, variant="sup")
  a@plot_env = b@plot_env = environment()
  expect_equal(a, b, ignore_function_env = TRUE, ignore_attr = TRUE)
})

test_that("ae_plot_grade_sum() works", {
  ae = db_test$ae
  enrolres = db_test$enrolres

  p = ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres)
  vdiffr::expect_doppelganger("ae-plot-grade-sum-1arm", p)
  p = ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM")
  vdiffr::expect_doppelganger("ae-plot-grade-sum-2arms", p)
  p = ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM", weights=c(1,1,3,6,10))
  vdiffr::expect_doppelganger("ae-plot-grade-sum-2arms-weighted", p)

})


test_that("butterfly_plot() works", {
  ae = db_test$ae
  enrolres = db_test$enrolres
  ae2 = ae %>%
    mutate(serious = sae=="Yes")

  p = butterfly_plot(ae2, df_enrol=enrolres)
  vdiffr::expect_doppelganger("butterfly-plot-default", p)
  p = butterfly_plot(ae2, df_enrol=enrolres, severe="serious", sort_by="severe")
  vdiffr::expect_doppelganger("butterfly-plot-severe", p)
  p = butterfly_plot(ae2, df_enrol=enrolres, range_min=1)
  vdiffr::expect_doppelganger("butterfly-plot-range", p)

})

test_that("butterfly_plot() errors", {
  ae = db_test$ae
  enrolres = db_test$enrolres
  ae2 = ae %>%
    mutate(bad_serious = sae=="foobar")

  # Warnings ------------------------------------------------------

  # there is no SAE (probably an error)
  ae2 %>%
    butterfly_plot(df_enrol=enrolres, severe="bad_serious") %>%
    expect_warning(class="grstat_butterfly_serious_false_warning")

  # Errors   ------------------------------------------------------

  # `severe` is not logical
  ae %>%
    butterfly_plot(df_enrol=enrolres, severe="sae") %>%
    expect_error(class="grstat_butterfly_serious_lgl_error")

  # not exactly 2 arms
  ae %>%
    butterfly_plot(df_enrol=enrolres, arm="crfname") %>%
    expect_error(class="grstat_butterfly_two_arms_error")

  # NULL arguments
  ae %>%
    butterfly_plot(df_enrol=NULL, sort_by=NULL, subjid=NULL, soc=NULL) %>%
    expect_error(class="grstat_var_null")
  ae %>%
    butterfly_plot(df_enrol=enrolres, arm=NULL) %>%
    expect_error(class="grstat_butterfly_two_arms_error")

  # Missing values
  enrol_na = enrolres
  enrol_na$arm[1] = NA

  ae %>%
    butterfly_plot(df_enrol=enrol_na, arm="arm") %>%
    expect_error(class="grstat_butterfly_arm_na_error")

})
