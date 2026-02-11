#' Randomization lists
#'
#' Create stratified permuted-block randomization lists for EDC/CTMS softwares.
#' For each stratum, this function pre-generates a sequence of randomization *slots*
#' using [blockrand::blockrand()], and then binds all strata into a single table.
#' Random block sizes can be used to reduce predictability.
#'
#' @param n Planned total sample size of the trial (used as the minimum number of slots
#'   generated *per stratum* to cover worst-case enrollment).
#' @param arms Treatment arms.
#' @param strata A list of stratification factors (character vectors). Each combination
#'   defines one stratum. If `NULL` or empty, a single stratum is used.
#' @param block.sizes Random block sizes. Must be multiples of `length(arms)`.
#' @param ... Passed to [blockrand::blockrand].
#'
#' @return A tibble
#' @export
#' @importFrom tidyr separate unite
#' @importFrom stringr str_pad
#'
#' @section Details:
#' The output table represents *randomization slots*, not enrolled patients.
#' During the trial, patients are enrolled one by one, assigned to a stratum based on
#' their characteristics, and consume the next available slot within that stratum.
#' Slots from other strata remain unused.
#'
#' For operational safety, at least `n` slots are generated for each stratum. Because
#' permuted-block randomization uses complete blocks, the number of slots per stratum
#' may slightly exceed `n` (up to `n + max(block.sizes) - 1`).
#'
#' With equal allocation and block sizes that are multiples of `length(arms)`, each
#' *complete block* is balanced across arms. However, the trial may stop after exactly
#' `n` inclusions, which can occur in the middle of a block. In the worst-case theoretical
#' scenario, the maximum imbalance at trial stop **within a stratum** is bounded by
#' `max(block.sizes)/length(arms)` slots. This is a conservative bound and is typically
#' much smaller in practice.
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
#'
#' # Export for TrialMaster
#' rando %>%
#'   dplyr::select(names(strat), treatment_id) %>%
#'   write.table("randomization_list.txt", sep="\t", row.names=FALSE)
randomisation_list = function(n, arms, strata=NULL, block.sizes=c(2,4), ...){
  check_installed("blockrand", "for `randomisation_list()` to work.")
  grstat_dev_warn()
  .check_n(n, arms)
  .check_arms(block.sizes, arms)
  .check_blocks(block.sizes)
  n_strata = prod(lengths(strata))
  if(length(strata)==0){
    strata=list(strata="no_strata")
  }

  strata %>%
    map(~normalize_string(.x, lower=FALSE)) %>%
    expand.grid() %>%
    unite("strata", everything(), sep="__") %>%
    pull(strata) %>%
    map(~{
      blockrand::blockrand(n = n,
                           levels = arms,
                           stratum = .x,
                           id.prefix = paste0(.x, " - "),
                           block.sizes = block.sizes/length(arms),
                           ...)
    }) %>%
    list_rbind() %>%
    separate(stratum, into=names(strata), sep="__") %>%
    rename(stratum.block.id=block.id) %>%
    mutate(id = as.character(id),
           i = str_pad(row_number(), max(nchar(row_number())), pad="0"),
           treatment_id = paste(treatment, i, sep="-")) %>%
    as_tibble() %>%
    select(-i) %>%
    structure(
      n=n, arms=arms, strata=strata, block.sizes=block.sizes, n_strata=n_strata
    ) %>%
    add_class("rando_list")
}

#' @export
print.rando_list = function(x, ...){
  a = attributes(x)
  cli_inform("Randomisation list for {.val {a$n}} patients randomized in arms {.val {a$arms}} across {.val {a$n_strata}} strata with blocks of length {.val {a$block.sizes}}.")
  print(as_tibble(x))
}

# Checks --------------------------------------------------------------------------------------

.check_n = function(n, arms){
  if(n%%length(arms)!=0){
    cli_warn(c(
      "Number of patients {.arg n}={.val {n}} is not divisible by the number of treatment arms.",
      i="There are {.val {length(arms)}} treatment arms: {.val {arms}}"
    ),
    class="randomisation_list_n_warn")
  }
}
.check_blocks = function(block.sizes){
  odds = block.sizes[block.sizes%%2!=0]
  if(length(odds)>0){
    cli_warn(c(
      "Block sizes should be even for treatments to be balanced. {.arg block.sizes}={.val {odds}} is even."
    ),
    class="randomisation_list_even_block_warn")
  }
}
.check_arms = function(block.sizes, arms){
  wrong = block.sizes%%length(arms)!=0
  if(any(wrong)){
    cli_abort(c(
      "Some {.arg block.sizes} are not divisible by the number of treatment arms",
      i="There are {.val {length(arms)}} treatment arms: {.val {arms}}",
      i="{.arg block.sizes} {.val {block.sizes[wrong]}} {cli::qty(sum(wrong))} {?is/are} not
         divisible by {.val {length(arms)}}"
    ),
    class="randomisation_list_block_error")
  }
}
