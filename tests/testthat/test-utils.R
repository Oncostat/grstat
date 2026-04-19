test_that("check_dots_empty2() works", {
    
  # check_dots_empty2() compared to rlang::check_dots_empty()
  f = function(x, ...) {
    check_dots_empty2()
    x + 1
  }
  error1 = f(1, 2, a=iris, b=mtcars, 55, y=1:10) %>% try(silent = TRUE)
  error1 = as.character(error1) %>% str_split_1("\n")
  f = function(x, ...) {
    check_dots_empty()
    x + 1
  }
  error2 = f(1, 2, a=iris, b=mtcars, 55, y=1:10) %>% try(silent = TRUE)
  error2 = as.character(error2) %>% str_split_1("\n")

  expect_equal(error1[-2], error2[-c(2,9)])

  # check_dots_empty2() with except
  f = function(x, ...) {
    check_dots_empty2(except=c("a", "y"))
    x + 1
  }
  error3 = f(1, 2, a=iris, b=mtcars, 55, y=1:10) %>% try(silent = TRUE)
  error3 = as.character(error3) %>% str_split_1("\n")
  expect_equal(error1[-c(5,8)], error3)

  # check_dots_empty2() ok
  f = function(x, ...) {
    check_dots_empty2(except=c("a", "y"))
    x + 1
  }
  f(1) %>% expect_silent()
})


