

test_that("Proportions of AE grades are respected", {
  skip_on_ci() #random number generation

  get_rate = function(sae){
    rate = -1+sae
    probs = exp(rate * c(1:4))
    probs = c(probs, probs[4]/7) #grade 5 always minor
    probs / sum(probs)
  }
  p_ae  = get_rate(FALSE)
  p_sae = get_rate(TRUE)


  tm = grstat_example(5000, p_na=0, p_sae=0.5, beta_trt=0, seed=42)
  x = tm$ae %>% with(table(aegr, sae)) %>% prop.table(margin=2) %>% round(2)
  round(as.matrix(x)/cbind(p_sae, p_ae), 1)

  expect_equal(unname(as.matrix(x)[,"Yes"]), p_sae, tolerance=0.05) # 5% tolerance
  expect_equal(unname(as.matrix(x)[,"No"]),  p_ae,  tolerance=0.05)
})
