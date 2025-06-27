

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
    attach(tm, warn.conflicts = FALSE)

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


test_that("ae_table_soc(ae_groups) works", {

  tm = grstat_example()
  attach(tm, warn.conflicts = FALSE)


  x0 = ae_table_soc(df_ae=ae, df_enrol=enrolres)
  expect_named(x0, c("soc", "all_patients_G1", "all_patients_G2",
                     "all_patients_G3", "all_patients_G4", "all_patients_G5",
                     "all_patients_NA", "all_patients_Tot"))

  #default is to assign all grades to its own group
  x1 = ae_table_soc(df_ae=ae, df_enrol=enrolres,
                    ae_groups=list("G1"=1, "G2"=2, "G3"=3, "G4"=4, "G5"=5))
  expect_identical(x0, x1)

  #3 groups
  ae_groups=list("Any grade"=1:5, "Grade 1-2"=1:2, "Grade 3-5"=3:5)
  x2 = ae_table_soc(df_ae=ae, df_enrol=enrolres, total=TRUE,
                    ae_groups=ae_groups)
  expect_named(x2, c("soc", "all_patients_any_grade", "all_patients_grade_1_2",
                     "all_patients_grade_3_5", "all_patients_NA", "all_patients_Tot"))
  expect_equal(x2$all_patients_any_grade, x2$all_patients_Tot)
  # expect_equal(x2$all_patients_any_grade,
  #              x2$all_patients_grade_1_2+x2$all_patients_grade_3_5)


  #3 groups with ARM
  ae_groups=list("Any grade"=1:5, "Grade 1-2"=1:2, "Grade 3-5"=3:5)
  x3 = ae_table_soc(df_ae=ae, df_enrol=enrolres, arm="ARM",
                    ae_groups=ae_groups)
  expect_named(x3, c("soc",
                     "control_any_grade", "control_grade_1_2",
                     "control_3_5", "control_NA",
                     "treatment_any_grade", "treatment_grade_1_2",
                     "treatment_3_5", "treatment_NA"))

  #errors
  ae_table_soc(df_ae=ae, df_enrol=enrolres,
               ae_groups="Coucou") %>%
    expect_error(class="ae_table_soc_group_bad_class")
  ae_table_soc(df_ae=ae, df_enrol=enrolres,
               ae_groups=list("Grade 1-2"=0:2, "Grade sup 3"=3:7)) %>%
    expect_error(class="ae_table_soc_group_bad_number")

})
