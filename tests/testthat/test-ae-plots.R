
test_that("ae_plot_grade() works", {
  tm = grstat_example()
  attach(tm, warn.conflicts=FALSE)

  p = ae_plot_grade(df_ae=ae, df_enrol=enrolres)
  vdiffr::expect_doppelganger("ae-plot-grade-1", p)
  p = ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", variant=c("sup", "max"))
  vdiffr::expect_doppelganger("ae-plot-grade-2", p)
  p = ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", type="absolute")
  vdiffr::expect_doppelganger("ae-plot-grade-3", p)
  p = ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", position="fill")
  vdiffr::expect_doppelganger("ae-plot-grade-4", p)
  p = ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", position="stack", type="absolute")
  vdiffr::expect_doppelganger("ae-plot-grade-5", p)

})


test_that("ae_plot_grade_sum() works", {
  tm = grstat_example()
  attach(tm, warn.conflicts=FALSE)

  p = ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres)
  vdiffr::expect_doppelganger("ae-plot-grade-sum-1", p)
  p = ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM")
  vdiffr::expect_doppelganger("ae-plot-grade-sum-2", p)
  p = ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM", weights=c(1,1,3,6,10))
  vdiffr::expect_doppelganger("ae-plot-grade-sum-3", p)



})


test_that("butterfly_plot() works", {
  tm = grstat_example()
  attach(tm, warn.conflicts=FALSE)
  ae2 = ae %>%
    mutate(serious = sae=="Yes",
           bad_serious = sae=="foobar")

  p = butterfly_plot(ae2, df_enrol=enrolres)
  vdiffr::expect_doppelganger("butterfly-plot-1", p)
  p = butterfly_plot(ae2, df_enrol=enrolres, severe="serious", sort_by="severe")
  vdiffr::expect_doppelganger("butterfly-plot-2", p)
  p = butterfly_plot(ae2, df_enrol=enrolres, range_min=1)
  vdiffr::expect_doppelganger("butterfly-plot-3", p)
})

test_that("butterfly_plot() errors", {
  tm = grstat_example()
  attach(tm, warn.conflicts=FALSE)
  ae2 = ae %>%
    mutate(serious = sae=="Yes",
           bad_serious = sae=="foobar")

  # Warnings ------------------------------------------------------

  # there is no SAE (probably an error)
  ae2 %>%
    butterfly_plot(df_enrol=enrolres, severe="bad_serious") %>%
    expect_warning(class="edc_butterfly_serious_false_warning")

  # Errors   ------------------------------------------------------

  # `severe` is not logical
  ae %>%
    butterfly_plot(df_enrol=enrolres, severe="sae") %>%
    expect_error(class="edc_butterfly_serious_lgl_error")

  # not exactly 2 arms
  ae %>%
    butterfly_plot(df_enrol=enrolres, arm="crfname") %>%
    expect_error(class="edc_butterfly_two_arms_error")

  # arm is NULL
  ae %>%
    butterfly_plot(df_enrol=enrolres, subjid=NULL, soc=NULL) %>%
    expect_error(class="grstat_var_null")
  ae %>%
    butterfly_plot(df_enrol=enrolres, arm=NULL) %>%
    expect_error(class="grstat_var_null")

})
