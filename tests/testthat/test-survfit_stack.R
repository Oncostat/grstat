
test_that("`survfit_stack()` works", {
  local_options(grstat_lifecycle_verbosity="quiet")
  set.seed(42)
  df_surv = survival::lung %>%
    as_tibble() %>%
    mutate(
      time_os = time,
      event_os = status == 2,
      time_pfs = time / (1 + runif(n())),
      event_pfs = ifelse(runif(n()) > 0.3, event_os, 1),
      time_efs = time_pfs / (1 + runif(n())),
      event_efs = ifelse(runif(n()) > 0.3, event_pfs, 1)
    )


  #Right censoring
  expect_snapshot({
    surv_list = list(
      "Overall survival" = c("time_os", "event_os"),
      "Progression-free survival" = c("time_pfs", "event_pfs"),
      "Event-free survival" = c("time_efs", "event_efs")
    )
    s1 = survfit_stack(df_surv, surv_list=surv_list)
    s1
  })

  #Interval censoring (dummy)
  expect_snapshot({
    surv_list2 = list(
      "Overall survival"=c("time_pfs", "time_os", "event_os"),
      "Progression-free survival"=c("time_pfs", "time_os", "event_pfs")
    )
    s2 = df_surv %>%
      filter(time_pfs>3 & time_os<100) %>%
      survfit_stack(surv_list=surv_list2)
    s2
  })


  #ERRORS

  #inconsistent lengths
  sl = list(
    "Overall survival" = c("time_os", "event_os"),
    "Progression-free survival"=c("time_os", "time_pfs", "event_pfs")
  )
  survfit_stack(df_surv, surv_list=sl) %>%
    expect_error(class="survfit_stack_length_error")

  #class
  sl = list(
    "Progression-free survival"=c("meal.cal", "sex", "pat.karno")
  )
  survfit_stack(df_surv, surv_list=sl) %>%
    expect_error(class="grstat_assertion_error")

})
