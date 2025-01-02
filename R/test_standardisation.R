library(survival)
library(MASS)
library(flextable)
library(dplyr)

df_surv <- VA
df_surv <- df_surv %>% mutate(tmtarm = ifelse(treat == 1, "ARM A", "ARM B"))

# Fit a stratified model 
res_cox <- coxph(Surv(stime, status) ~ tmtarm + age + cell, data = df_surv)
tmtvar <- 'tmtarm'
oth_vars <- c('age', 'cell')

df_cox <- broom.helpers::tidy_plus_plus(res_cox, exponentiate = T, conf.int = T) %>% 
  select(c('var_label', 'label', 'n_obs', 'n_event', 'estimate', 'statistic', 'p.value', 'conf.low', 'conf.high')) %>% 
  mutate(HR = ifelse(is.na(conf.low), '', glue::glue("{round(estimate, 2)} [{round(conf.low, 2)} ; {round(conf.high, 2)}]"))) %>% 
  select(-c('estimate', 'conf.low', 'conf.high'))

as_flextable(df_cox)
#exponentiate the coefficient ? exponentiate = 1
#conf.int ? default to FALSE
#conf.level : default to 0.95
par = list()

report_coxph = function(fit, label){
  a = broom::tidy(fit, exponentiate=TRUE, conf.int=TRUE) %>% 
    filter(term=="armTTT") %>% 
    mutate(across(-term, ~round(.x, 2)))
  # a$estimate
  # fit$xlevels
  glue("The Hazard Ratio of treatment for {label} was {a$estimate} [95%CI {a$conf.low}; {a$conf.high}] (adjusted p-value: {a$p.value})")
}