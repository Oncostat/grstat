db = grstat_example()

data_km = db$enrolres %>%
  left_join(db$fu, by = "subjid") %>%
  mutate(time_OS = as.numeric(fu_date - date_inclusion)/365.25,
         event_OS = 1*(fu_status == "Dead"))

km = survival::survfit(survival::Surv(time_OS, event_OS) ~ arm, data = data_km)
p = ggsurvfit::ggsurvfit(km) +
  ggsurvfit::add_censor_mark() +
  ggsurvfit::add_confidence_interval() +
  ggsurvfit::add_risktable()

print(p)
