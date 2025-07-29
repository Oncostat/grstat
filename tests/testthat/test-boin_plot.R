test_that("boin_plot works", {

  boin = BOIN::get.boundary(target=0.3, ncohort=15, cohortsize=1)
  set.seed(123)
  data_patients = tibble(
    subjid = 1:17,
    dose = c("DL0", "DL0", "DL-1", "DL-1", "DL-1", "DL0", "DL0", "DL0",
             "DL1", "DL1", "DL1", "DL1", "DL1", "DL1", "DL1", "DL1", "DL1"),
    dlt = c(FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
            FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, NA, NA),
    date_dlt_start = as.Date("2025-01-01") +(1:17)*30 + rnorm(17, 0, 10),
    date_dlt_end = date_dlt_start+30
  )

  #default
  p1 = boin_plot(boin,
            doses=c("DL-1", "DL0", "DL1", "DL2"))
  vdiffr::expect_doppelganger("boin-default", p1)

  #with patient labels
  p2 = boin_plot(boin, data_patients=data_patients,
            doses=c("DL-1", "DL0", "DL1", "DL2"))
  vdiffr::expect_doppelganger("boin-patients", p2)
  #with gantt diagram
  p3 = boin_plot(boin, data_patients=data_patients, gantt_include=TRUE,
                doses=c("DL-1", "DL0", "DL1", "DL2"))
  vdiffr::expect_doppelganger("boin-gantt", p3)

  #with post production
  p3[[1]] = p3[[1]] + scale_color_manual(values=c("red", "green", "blue", "yellow"))
  p3[[2]] = p3[[2]] + scale_color_manual(values=c("red", "green", "blue"))
  vdiffr::expect_doppelganger("boin-gantt-modif", p3)

  #with gantt labels
  gantt_labels=c("Plot cutoff date"=as.Date("2026-06-01"),
                 "Dose reevaluation"=as.Date("2025-04-11"),
                 "Dose reevaluation"=as.Date("2025-07-03"),
                 "Dose reevaluation"=as.Date("2025-09-17"))
  p4 = boin_plot(data_boin=boin, data_patients=data_patients,
            doses = c("DL-1", "DL0", "DL1", "DL2"),
            gantt_include=TRUE,
            gantt_labels=gantt_labels)
  vdiffr::expect_doppelganger("boin-gantt-labels", p4)


  #errors
  boin_plot(boin, data_patients=data_patients %>% select(1), gantt_include=FALSE,
            doses=c("DL-1", "DL0", "DL1", "DL2")) %>%
    expect_error(class="grstat_name_notfound_error", regexp="dose.*dlt")
  boin_plot(boin, data_patients=data_patients %>% select(1), gantt_include=TRUE,
            doses=c("DL-1", "DL0", "DL1", "DL2")) %>%
    expect_error(class="grstat_name_notfound_error", regexp="date_dlt_end")

  boin_plot(boin, data_patients=data_patients %>% mutate(dose="DL7"), gantt_include=TRUE,
            doses=c("DL-1", "DL0", "DL1", "DL2")) %>%
    expect_error(class="boin_plot_invalid_dose")
})
