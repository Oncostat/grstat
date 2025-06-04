
test_that("rando: simple n=1000", {
  set.seed(42)

  strat = list(age=c("<=18m", ">18m"),
               gender=c("Male", "Female"),
               group=c("A", "B", "C"))
  n_strat = prod(lengths(strat))
  N_pop = 1000

  rando = randomisation_list(n=N_pop, arms=c("Control", "Treatment"),
                             strata=strat, block.sizes=c(4, 8)) %>%
    expect_classed_conditions(warning_class="grstat_dev_warn")


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

test_that("rando: simple n=10", {
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

test_that("rando: errors and warnings", {
  strat = list(age=c("<=18m", ">18m"),
               gender=c("Male", "Female"),
               group=c("A", "B", "C"))

  randomisation_list(n=201, arms=c("Control", "Treatment"),
                     strata=strat, block.sizes=c(4, 8)) %>%
    expect_warning(class="randomisation_list_n_warn")

  randomisation_list(n=300, arms=c("Control", "Treatment A", "Treatment B"),
                     strata=strat, block.sizes=c(3)) %>%
    expect_warning(class="randomisation_list_even_block_warn")

  randomisation_list(n=200, arms=c("Control", "Treatment"),
                     strata=strat, block.sizes=c(4, 8, 9)) %>%
    expect_error(class="randomisation_list_block_error")
})


