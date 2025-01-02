
test_that("ae_table_grade() works", {
  local_reproducible_output(width=125)

  expect_snapshot({
    tm = grstat_example()
    attach(tm)

    ae_table_grade(ae, df_enrol=enrolres)
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM")
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM", variant = c("eq", "max"))
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM", percent=FALSE, total=FALSE)

  })
})


test_that("ae_table_grade() with different colnames", {
  tm = grstat_example()
  df_enrol = tm$enrolres %>%
    rename(ENROLLID2=subjid, TRT=arm)
  df_ae = tm$ae %>%
    rename(ENROLLID2=subjid, grade=aegr)

  rslt = ae_table_grade(df_ae=df_ae, df_enrol=df_enrol, subjid="ENROLLID2", grade="grade", arm="TRT") %>%
    expect_silent()

  expect_setequal(names(rslt), c(".id", "label", "variable", "Ctl", "Trt", "Total"))
})


test_that("ae_table_soc() works", {
  local_reproducible_output(width=125)

  expect_snapshot({
    tm = grstat_example()
    attach(tm)

    ae_table_soc(ae, df_enrol=enrolres)
    ae_table_soc(ae, df_enrol=enrolres, sort_by_count=FALSE)
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", digits=1)
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", showNA=FALSE, total=FALSE)
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", variant="sup")
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", variant="eq")

  })

  ae_table_soc(df_ae=ae, df_enrol=enrolres,
               arm="ARsM", term="AETEeRM", soc="AEtSOC", grade="AEGeR", subjid="SUBaJID") %>%
    expect_error(class="grstat_name_notfound_error")

})
