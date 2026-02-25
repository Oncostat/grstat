


test_that("calc_best_response", {
  local_options(grstat_lifecycle_verbosity="quiet")
  expect_snapshot({
    db = grstat_example(N=500)
    data_br = calc_best_response(db$recist)
    as.data.frame(data_br)
  })
})



