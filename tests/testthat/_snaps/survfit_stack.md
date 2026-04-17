# `survfit_stack()` works

    Code
      surv_list = list(`Overall survival` = c("time_os", "event_os"),
      `Progression-free survival` = c("time_pfs", "event_pfs"),
      `Event-free survival` = c("time_efs", "event_efs"))
      s1 = survfit_stack(df_surv, surv_list = surv_list)
      s1
    Output
      Call: survfit(formula = survival::Surv(stacked_time, stacked_event) ~ 
          stacked_survtype, data = data_stack)
      
                                                   n events median 0.95LCL 0.95UCL
      stacked_survtype=Overall survival          228    165    310     285     363
      stacked_survtype=Progression-free survival 228    185    191     164     239
      stacked_survtype=Event-free survival       228    199    126     110     142

---

    Code
      surv_list2 = list(`Overall survival` = c("time_pfs", "time_os", "event_os"),
      `Progression-free survival` = c("time_pfs", "time_os", "event_pfs"))
      s2 = df_surv %>% filter(time_pfs > 3 & time_os < 100) %>% survfit_stack(
        surv_list = surv_list2)
      s2
    Output
      Call: survfit(formula = survival::Surv(stacked_time, stacked_time2, 
          stacked_event) ~ stacked_survtype, data = data_stack)
      
                                                 records n.max n.start events median
      stacked_survtype=Overall survival               31    14       7     30     12
      stacked_survtype=Progression-free survival      31    14       7     30     12
                                                 0.95LCL 0.95UCL
      stacked_survtype=Overall survival               11      30
      stacked_survtype=Progression-free survival      11      30

