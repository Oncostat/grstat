# On ne lance pas les fonctions on charge le package avec ctrl+shift+l
# Enlever les librarys d'ici

test_that("shit works", {
  # expect_equal(2 * 2, 4)
  library(flextable)
  library(tidyverse)

  df_surv <- MASS::VA %>% mutate(tmtarm = ifelse(treat == 1, "ARM A", "ARM B")) %>%
    crosstable::apply_labels(tmtarm='Treatment Arm', age = 'Age (in years)', cell = 'Cell type')

  res_cox <- survival::coxph(Surv(stime, status) ~ tmtarm + age + cell, data = df_surv)

  df_cox <- xx(res_cox)

  as_flextable(df_cox)

})

test_that("report")
