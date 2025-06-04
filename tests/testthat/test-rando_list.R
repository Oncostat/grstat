
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



# Simulation ----------------------------------------------------------------------------------

#' random population of N patients along strata
get_pop = function(strata, N){
  strata %>%
    imap(~as_tibble_col(sample(.x, size=N, replace=TRUE), column_name=.y)) %>%
    list_cbind() %>%
    tidyr::unpack(everything())
}

#' random population of N patients with only the first level of each stratum
get_pop_worst = function(strata, N){
  strata %>%
    imap(~as_tibble_col(sample(.x[1], size=N, replace=TRUE), column_name=.y)) %>%
    list_cbind() %>%
    tidyr::unpack(everything())
}

#' simulate a population of N patients, then apply the randomization list
rando_simu1 = function(rand, strata, N, scenario="default"){
  if(scenario=="default"){
    pop = get_pop(strata, N) %>% mutate(treatment=NA)
  } else {
    pop = get_pop_worst(strata, N) %>% mutate(treatment=NA)
  }
  # pop = get_pop_worst(strata, N) %>% mutate(treatment=NA)
  rand_bak = rand
  nm = names(strata) %>% set_names()
  for(i in seq(nrow(pop))){ #pour chaque patient i
    popi = pop[i,]
    x = map(nm, ~rand[[.x]]==popi[[.x]]) %>% reduce(`&`)
    row = which(x)[1] #1ère ligne qui correspond aux strates
    if(is.na(row)){
      cli_abort("The randomisation list is not long enough to include this much patients (N={N})")
    }
    pop[i, "treatment"] = rand[row, "treatment"] #on attribue le traitement
    rand = rand[-row,]                           #on retire la ligne de la liste de rando
  }
  stopifnot(nrow(rand_bak) - nrow(rand) == N) #on a retiré N patients
  pop
}


test_that("rando simu", {
  skip_on_cran()
  skip_on_ci()

  set.seed(42)
  strat = list(age=c("<=18m", ">18m"),
               gender=c("Male", "Female"),
               group=c("A", "B", "C"))
  N_sim = 100
  N_pop = 200
  block.sizes=c(4, 8)
  arms=c("Control", "Treatment")

  rando = randomisation_list(n=N_pop, arms=arms,
                             strata=strat, block.sizes=block.sizes)
  n_strat = attr(rando, "n_strat")
  max_imbalance = attr(rando, "max_imbalance")


  # r = rando_simu1(rando, strat, N_pop)
  rslt = map(1:N_sim, ~rando_simu1(rando, strat, N_pop), .progress=interactive())

  ## test the global balance
  bal = rslt %>%
    map(~ count(.x, treatment) ) %>%
    list_rbind(names_to="id") %>%
    mutate(imbalance=n-N_pop/2)
  # bal %>% filter(treatment=="Control") %>% pull(imbalance) %>% hist()
  # rslt[[75]] #max(bal$imbalance) on 75th sim
  expect_lte(max(abs(bal$imbalance)), n_strat*max_imbalance)

  ## test the stratum balance
  bal_s = rslt %>%
    map(~{
      .x %>%
        unite("stratum", c(age, gender, group)) %>%
        count(stratum, treatment)
    }) %>%
    list_rbind(names_to="id") %>%
    summarise(imbalance = n[2]-n[1],
              .by=c(id, stratum))
  # hist(bal_s$imbalance)
  expect_lte(max(abs(bal_s$imbalance)), max_imbalance)

  ## test the worst scenario (all patients in one stratm)
  rslt2 = map(1:N_sim, ~rando_simu1(rando, strat, N_pop, scenario="worst"),
              .progress=interactive())

  bal2 = rslt2 %>%
    map(~ count(.x, treatment) ) %>%
    list_rbind() %>%
    mutate(imbalance=abs(n-N_pop/2))
  expect_lte(max(bal2$imbalance), 0) #not random -> no difference


})




