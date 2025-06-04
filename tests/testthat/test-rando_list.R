
test_that("rando simple n=1000", {
  set.seed(42)

  strat = list(age=c("<=18m", ">18m"),
               gender=c("Male", "Female"),
               group=c("A", "B", "C"))
  n_strat = prod(lengths(strat))
  N_pop = 1000

  rando = randomisation_list(n=N_pop, arms=c("Control", "Treatment"),
                             strata=strat, block.sizes=c(4, 8))


  #all strata should be able to contain the whole study
  too_short = rando %>%
    count(age, gender, group) %>%
    filter(n<N_pop)
  expect_true(nrow(too_short)==0)

  #all strata should have the same control/treatment
  distinct_n_per_strata = rando %>%
    count(age, gender, group, treatment) %>%
    distinct(age, gender, group, treatment, n)
  expect_true(nrow(distinct_n_per_strata)==2*n_strat)
  # rando %>% filter(age==">18m", gender=="Male", group=="A") %>% tail()

})

test_that("rando simple", {
  set.seed(42)

  strat = list(age=c("<=18m", ">18m"),
               gender=c("Male", "Female"),
               group=c("A", "B", "C"))
  n_strat = prod(lengths(strat))
  N_pop = 10

  rando = randomisation_list(n=N_pop, arms=c("Control", "Treatment"),
                             strata=strat, block.sizes=c(4, 8))


  #all strata should be able to contain the whole study
  too_short = rando %>%
    count(age, gender, group) %>%
    filter(n<N_pop)
  expect_true(nrow(too_short)==0)

  #all strata should have the same control/treatment
  distinct_n_per_strata = rando %>%
    count(age, gender, group, treatment) %>%
    distinct(age, gender, group, treatment, n)
  expect_true(nrow(distinct_n_per_strata)==2*n_strat)
  # rando %>% filter(age==">18m", gender=="Male", group=="A") %>% tail()

})


