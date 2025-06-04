#' Randomization lists
#'
#' Create randomization lists for EDC softwares using `blockrand::blockrand()` for multiple strata at once.
#' Can use random block size.
#'
#' @param n total number of patients
#' @param arms treatment arms
#' @param strata a list of stratification factors (characters)
#' @param block.sizes block sizes (should be a multiple of the number of arms)
#' @param ... past to [blockrand::blockrand]
#'
#' @return une tibble
#' @export
#' @importFrom tidyr separate unite
#'
#' @section Details:
#'
#' Maximum imbalance per strata is calculated as `max(block.sizes)/length(arms)`. \cr
#' Global maximum imbalance is calculated as `max_imbalance*n_strata`.
#'
#'
#' @examples
#' # randomisation list for 200 patients randomized in 2 treatment
#' # arms stratified on 3 groups, with blocks of size 4 or 8
#'
#' strat = list(age=c("<=18m", ">18m"),
#'              gender=c("Male", "Female"),
#'              group=c("A", "B", "C"))
#' rando = randomisation_list(n=200, arms=c("Control", "Treatment"),
#'                            strata=strat, block.sizes=c(4, 8))
#' rando
randomisation_list = function(n, arms, strata, block.sizes=c(2,4), ...){
  check_installed("blockrand", "for `randomisation_list()` to work.")
  n_strata = prod(lengths(strata))
  max_imbalance = max(block.sizes)/length(arms)

  expand.grid(strata) %>%
    unite("strata", everything(), sep="__") %>%
    pull(strata) %>%
    map(~{
      blockrand::blockrand(n = n,
                           levels = arms,
                           stratum = .x,
                           id.prefix = paste(.x, " - "),
                           block.sizes = block.sizes/length(arms),
                           ...)
    }) %>%
    list_rbind() %>%
    separate(stratum, into=names(strata), sep="__") %>%
    mutate(id = as.character(id)) %>%
    as_tibble() %>%
    structure(
      n=n, arms=arms, strata=strata, block.sizes=block.sizes,
      n_strata=n_strata, max_imbalance=max_imbalance
    ) %>%
    add_class("rando_list")
}

#' @export
print.rando_list = function(x, ...){
  a = attributes(x)
  cli_inform("Randomisation list for {.val {a$n}} patients randomized in arms {.val {a$arms}} across {.val {a$n_strata}} strata with blocks of length {.val {a$block.sizes}}.")
  cli_inform("The maximum imbalance per strata is {.val {a$max_imbalance}}, so the theoretical global maximum imbalance is {.val {a$n_strata*a$max_imbalance}} patients.")
  print(as_tibble(x))
}
