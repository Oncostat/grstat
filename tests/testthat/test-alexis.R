test_that("grstat example RC", {

  db = grstat_example(N=200)
  hist(db$recist$RCTLSUM_b[db$recist$RCVISIT==0])


})
