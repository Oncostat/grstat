
test_that("rando: randomisation_list() works", {
  local_options(grstat_lifecycle_verbosity="quiet")
  set.seed(42)

  strat = list(age=c("<=18m", ">18m"),
               gender=c("Male", "Female"),
               group=c("A", "B", "C"))
  arms = c("Control", "Treatment")
  n_arms = length(arms)
  n_strata = prod(lengths(strat))
  N = 300
  block_sizes=c(4, 8)

  rando = randomisation_list(n=N, arms=arms,
                             strata=strat, block.sizes=block_sizes) %>%
    unite("stratum", all_of(names(strat)), remove=FALSE) %>%
    mutate(
      block.id = as.numeric(as.character(stratum.block.id)),
      block.id2 = paste(stratum, block.id)
    ) %>%
    arrange(across(names(strat)))


  expect_s3_class(rando, c("rando_list", "data.frame"))
  expect_setequal(rando$block.size, block_sizes)
  expect_setequal(rando$treatment, arms)
  expect_in(names(strat), names(rando))
  expect_true(!anyDuplicated(rando$id))

  #traitements équilibrés
  tbl = table(rando$treatment) %>% prop.table() %>% as.numeric()
  expect_equal(tbl, c(0.5, 0.5))

  #nombre de slots/strate supérieur au nombre de patients
  cnt = rando %>%
    count(across(all_of(names(strat))), treatment)
  expect_equal(nrow(cnt), n_strata*n_arms)
  expect_true(all(between(cnt$n, N/2, (N + max(block_sizes) - 1)/2)))
})


test_that("rando: errors and warnings", {
  local_options(grstat_lifecycle_verbosity="quiet")
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


test_that("rando: snapshots", {
  local_options(grstat_lifecycle_verbosity="quiet")

  expect_snapshot({

    strat = list(age=c("<=18m", ">18m"),
                 gender=c("Male", "Female"),
                 group=c("A", "B", "C"))

    randomisation_list(n=200, arms=c("Control", "Treatment"),
                       strata=strat, block.sizes=c(4, 8))

    randomisation_list(n=10, arms=c("A", "B"),
                       strata=NULL, block.sizes=c(4, 8))
  })
})


