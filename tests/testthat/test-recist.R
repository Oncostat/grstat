


test_that("Recist OK", {

  rc = atz$rc



  options(edc_warn_max_subjid=10)

  check_recist(rc)
  check_bare_recist(rc)


})
