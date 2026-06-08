

test_that("ae_tables simplest snapshot", {
  local_reproducible_output(width=125)
  rlang::local_options(ae_table_grade_na_strategy = list(display="if_any", grouped=FALSE))

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
  rlang::local_options(ae_table_grade_na_strategy = list(display="if_any", grouped=FALSE))

  expect_snapshot({
    ae = db_test$ae
    enrolres = db_test$enrolres

    ae_table_grade(ae, df_enrol=enrolres)
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM")
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM", variant = c("eq", "max"))
    ae_table_grade(ae, df_enrol=enrolres, arm="ARM", percent_pattern="{n}", total=FALSE)

  })
})


test_that("ae_table_grade() with missing and grade>2", {
  local_reproducible_output(width=125)
  rlang::local_options(ae_table_grade_na_strategy = list(display="if_any", grouped=FALSE))

  expect_snapshot({
    ae = db_test_na$ae
    enrolres = db_test_na$enrolres

    ae %>%
      filter(is.na(aegr) | aegr>2) %>%
      ae_table_grade(df_enrol=enrolres, arm="ARM")

  })
})


test_that("ae_table_grade() with old argument names", {

  a = ae_table_grade(db_test$ae, data_pat=db_test$enrolres, measure ="sup", percent_pattern = "{n} ({p}%)", percent_digits=2)
  b = ae_table_grade(df_ae=db_test$ae, df_enrol=db_test$enrolres, variant="sup", percent=TRUE, digits=2)

  expect_identical(a, b)
})


test_that("ae_table_grade() with different colnames", {
  df_enrol = db_test$enrolres %>%
    rename(ENROLLID2=subjid, TRT=arm)
  df_ae = db_test$ae %>%
    rename(ENROLLID2=subjid, grade=aegr)

  rslt = ae_table_grade(df_ae=df_ae, df_enrol=df_enrol, subjid="ENROLLID2", grade="grade", arm="TRT") %>%
    expect_silent()

  expect_setequal(names(rslt), c(".id", "measure", "level", "Control", "Treatment", "Total"))
})


test_that("ae_table_grade() errors", {

  db_test$ae$aegr[1:10] = 1:10
  ae_table_grade(db_test$ae, df_enrol=db_test$enrolres) %>%
    expect_error(class="ae_table_grade_not_1to5")

  db_test$ae$aegr[1] = "foobar"
  ae_table_grade(db_test$ae, df_enrol=db_test$enrolres) %>%
    expect_error(class="ae_table_grade_not_num")

})

test_that("ae_table_grade() measure add up", {
  #variant `sup` is the cumulative sum of variant `max`
  f = function(measure){
    ae_table_grade(db_test$ae, df_enrol=db_test$enrolres, arm="ARM", total=TRUE,
                   measure=measure, digits=2,  percent_pattern="{n}") %>%
      select(-measure) %>%
      filter(str_detect(level , "Grade")) %>%
      arrange(desc(row_number())) %>%
      pivot_longer(Control:Total) %>%
      arrange(name) %>%
      mutate(grade=stringr::str_extract(level, "\\d"))
  }
  a = f("sup")
  b = f("max")

  rslt = b %>%
    mutate(grade, max_sum=cumsum(value), .by=name, .keep="none") %>%
    dplyr::full_join(a, by=c("grade", "name")) %>%
    filter(value!=max_sum)
  expect_true(nrow(rslt)==0)
})



test_that("ae_table_soc() default snapshot", {
  local_reproducible_output(width=125)

  expect_snapshot({
    ae = db_test$ae
    enrolres = db_test$enrolres

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
    ctl = enrolres %>% filter(arm=="Control") %>% pull(subjid)
    ae %>%
      filter(aesoc=="Cardiac disorders" | !subjid %in% ctl) %>%
      ae_table_soc(df_enrol=enrolres, arm="ARM")
  })

  #error
  ae_table_soc(df_ae=ae, df_enrol=enrolres,
               arm="ARsM", term="AETEeRM", soc="AEtSOC", grade="AEGeR", subjid="SUBaJID") %>%
    expect_error(class="grstat_name_notfound_error")
})


test_that("ae_table_soc(ae_groups) works", {

  tm = grstat_example(p_na=0.10)
  attach(tm, warn.conflicts = FALSE)


  x0 = ae_table_soc(df_ae=ae, df_enrol=enrolres)
  expect_named(x0, c("group1", "all_patients__g1", "all_patients__g2", "all_patients__g3",
                     "all_patients__g4", "all_patients__g5", "all_patients__na",
                     "all_patients__tot"))
  x0 %>% as_flextable()

  #default is to assign all grades to its own group
  x1 = ae_table_soc(df_ae=ae, df_enrol=enrolres,
                    ae_groups=list("G1"=1, "G2"=2, "G3"=3, "G4"=4, "G5"=5, "NA"=NA))
  expect_identical(x0, x1)
  x1 %>%
    mutate(across(starts_with("all_patients"),
                  ~as.numeric(str_remove(.x, " \\(.*"))),
           tot=rowSums(across(starts_with("all_patients__g")))) %>%
    filter(tot+all_patients__na!=all_patients__tot) %>%
    expect_shape(nrow=0)


  #3 groups
  ae_groups=list("Any grade"=c(1:5,NA), "Grade 1-2"=1:2, "Grade 3-5"=3:5)
  x2 = ae_table_soc(df_ae=ae, df_enrol=enrolres,
                    ae_groups=ae_groups)
  expect_named(x2, c("group1", "all_patients__any_grade", "all_patients__grade_1_2",
                     "all_patients__grade_3_5", "all_patients__tot"))
  expect_equal(x2$all_patients__any_grade, x2$all_patients__tot, ignore_attr=TRUE)
  # expect_equal(x2$all_patients_any_grade,
  #              x2$all_patients_grade_1_2+x2$all_patients_grade_3_5)


  #3 groups with ARM
  ae_groups=list("Any grade"=1:5, "Grade 1-2"=1:2, "Grade 3-5"=3:5)
  x3 = ae_table_soc(df_ae=ae, df_enrol=enrolres, arm="ARM", total=FALSE,
                    ae_groups=ae_groups)
  expect_named(x3, c("group1",
                     "control__any_grade", "control__grade_1_2", "control__grade_3_5",
                     "treatment__any_grade", "treatment__grade_1_2", "treatment__grade_3_5"))


  #errors
  ae_table_soc(df_ae=ae, df_enrol=enrolres,
               ae_groups="Coucou") %>%
    expect_error(class="ae_table_soc_group_bad_class")
  ae_table_soc(df_ae=ae, df_enrol=enrolres,
               ae_groups=list("Grade 1-2"=0:2, "Grade sup 3"=3:7)) %>%
    expect_error(class="ae_table_soc_group_bad_number")

})
