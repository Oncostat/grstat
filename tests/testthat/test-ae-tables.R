

test_that("ae_tables simplest snapshot", {
  local_reproducible_output(width=125)

  expect_snapshot({

      df_ae = tibble(subjid=rep(1:2, each=5),
                     aesoc=rep("Soc1", 10),
                     aegr=c(1:4, NA, 2:5, NA))
      df_enrolres = tibble(subjid=1:2, arm="Foobar")
      ae_table_soc(df_ae=df_ae, df_enrol=df_enrolres, variant="max")
      ae_table_soc(df_ae=df_ae, df_enrol=df_enrolres, variant="sup")
      ae_table_soc(df_ae=df_ae, df_enrol=df_enrolres, variant="eq")

      ae_table_grade(df_ae=df_ae, df_enrol=df_enrolres, variant="max")
      ae_table_grade(df_ae=df_ae, df_enrol=df_enrolres, variant="sup")
      ae_table_grade(df_ae=df_ae, df_enrol=df_enrolres, variant="eq")

  })
})


test_that("ae_table_grade() default snapshot", {
  local_reproducible_output(width=125)

  expect_snapshot({
    tm = grstat_example()
    ae = tm$ae
    enrolres = tm$enrolres

    ae_table_grade(ae, df_enrol=enrolres)
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM")
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM", variant = c("eq", "max"))
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM", percent=FALSE, total=FALSE)

  })
})


test_that("ae_table_grade() with missing and grade>2", {
  local_reproducible_output(width=125)

  expect_snapshot({
    tm = grstat_example(p_na=0.10)
    ae = tm$ae
    enrolres = tm$enrolres

    ae %>%
      filter(is.na(aegr) | aegr>2) %>%
      ae_table_grade(df_enrol=enrolres, arm="ARM")

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

  expect_setequal(names(rslt), c(".id", "label", "variable", "Control", "Treatment", "Total"))
})


test_that("ae_table_grade() errors", {

  tm = grstat_example()

  tm$ae$aegr[1:10] = 1:10
  ae_table_grade(tm$ae, df_enrol=tm$enrolres) %>%
    expect_error(class="ae_table_grade_not_1to5")

  tm$ae$aegr[1] = "foobar"
  ae_table_grade(tm$ae, df_enrol=tm$enrolres) %>%
    expect_error(class="ae_table_grade_not_num")

})


test_that("ae_table_soc() default snapshot", {
  local_reproducible_output(width=125)

  expect_snapshot({
    tm = grstat_example()
    ae = tm$ae
    enrolres = tm$enrolres

    ae_table_soc(ae, df_enrol=enrolres)
    ae_table_soc(ae, df_enrol=enrolres, sort_by_count=FALSE)
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", digits=1)
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", showNA=FALSE, total=FALSE)
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", variant="sup")
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", variant="eq")

    # with term
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", term="aeterm", sort_by_count=TRUE)
    ae_table_soc(ae, df_enrol=enrolres, arm="ARM", term="aeterm", sort_by_count=FALSE)

    # with a soc only in one arm
    ctl = tm$enrolres %>% filter(arm=="Control") %>% pull(subjid)
    x=tm$ae %>%
      filter(aesoc=="Cardiac disorders" | !subjid %in% ctl) %>%
      ae_table_soc(df_enrol=tm$enrolres, arm="ARM")
  })

  ae_table_soc(df_ae=ae, df_enrol=enrolres,
               arm="ARsM", term="AETEeRM", soc="AEtSOC", grade="AEGeR", subjid="SUBaJID") %>%
    expect_error(class="grstat_name_notfound_error")

})
