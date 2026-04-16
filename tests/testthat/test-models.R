# On ne lance pas les fonctions on charge le package avec ctrl+shift+l
# Enlever les librarys d'ici


test_that("cox_regtable() works", {
  local_reproducible_output(width=125)

  lung = survival::lung
  fit = coxph(Surv(time, status) ~ as.factor(ph.ecog) + age, data=lung)

  ald = cox_regtable(fit)
  expect_s3_class(ald, "regtable")
  })

