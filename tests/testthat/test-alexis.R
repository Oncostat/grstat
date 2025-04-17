test_that("grstat example RC", {


  db = grstat_example(N=200)
  rc <- db$recist
  #Test pour RCRESP
  expect_false(any(rc$rcresp=="ERROR", na.rm=TRUE))

  #Test pas de taille de tumeur inferieur a 0
  expect_false(any(rc$rctlsum < 0, na.rm=TRUE))
  expect_false(any(rc$rctlmin < 0, na.rm=TRUE))

  #Test pour verifier que la taille minimale de la tumeur au temps t est bien inferieur ou egale a la taille de la tumeur au temps t
  expect_false(any(rc$rctlmin > rc$rctlsum, na.rm=TRUE))


})
