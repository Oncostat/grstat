

test_that("Proportions of AE grades are respected", {
  p_ae  = c(0.4,0.3,0.2,0.1,0.01)
  p_sae = c(0.15,0.15,0.3,0.3,0.1)
  tm = grstat_example(1000, ae_p_na=0, ae_p_sae=0.5, seed=42)
  x = tm$ae %>% with(table(aegr, sae)) %>% prop.table(margin=2) %>% round(2)
  as.matrix(x)
  expect_equal(unname(as.matrix(x)[,"Yes"]), p_sae, tolerance=0.05) # 5% tolerance
  expect_equal(unname(as.matrix(x)[,"No"]),   p_ae, tolerance=0.05)
})
