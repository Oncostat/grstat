# Randomization lists

Create stratified permuted-block randomization lists for EDC/CTMS
softwares. For each stratum, this function pre-generates a sequence of
randomization *slots* using
[`blockrand::blockrand()`](https://rdrr.io/pkg/blockrand/man/blockrand.html),
and then binds all strata into a single table. Random block sizes can be
used to reduce predictability.

## Usage

``` r
randomisation_list(n, arms, strata = NULL, block_sizes = c(2, 4), ...)
```

## Arguments

- n:

  Planned total sample size of the trial (used as the minimum number of
  slots generated *per stratum* to cover worst-case enrollment).

- arms:

  Treatment arms. For an unbalanced design, repeat one arm label (e.g.
  `arms=c("A", "B", "B")`).

- strata:

  A list of stratification factors (character vectors). Each combination
  defines one stratum. If `NULL` or empty, a single stratum is used.

- block_sizes:

  Random block sizes. Must be multiples of `length(arms)`.

- ...:

  Passed to
  [blockrand::blockrand](https://rdrr.io/pkg/blockrand/man/blockrand.html).

## Value

A tibble

## Details

The output table represents *randomization slots*, not enrolled
patients. During the trial, patients are enrolled one by one, assigned
to a stratum based on their characteristics, and consume the next
available slot within that stratum. Slots from other strata remain
unused.

For operational safety, at least `n` slots are generated for each
stratum. Because permuted-block randomization uses complete blocks, the
number of slots per stratum may slightly exceed `n` (up to
`n + max(block_sizes) - 1`).

With equal allocation and block sizes that are multiples of
`length(arms)`, each *complete block* is balanced across arms. However,
the trial may stop after exactly `n` inclusions, which can occur in the
middle of a block. In the worst-case theoretical scenario, the maximum
imbalance at trial stop **within a stratum** is bounded by
`max(block_sizes)/length(arms)` slots. This is a conservative bound and
is typically much smaller in practice.

## Examples

``` r
# randomisation list for 200 patients randomized in 2 treatment
# arms stratified on 3 groups, with blocks of size 4 or 8

strat = list(age=c("<=18m", ">18m"),
             gender=c("Male", "Female"),
             group=c("A", "B", "C"))
rando = randomisation_list(n=200, arms=c("Control", "Treatment"),
                           strata=strat, block_sizes=c(4, 8))
#> Warning: Function `randomisation_list()` (`?grstat::randomisation_list()`) is not yet
#> validated and may produce incorrect results.
#> ! Always double-check the results using your own code.
#> ℹ Please send your feedback to the grstat team.
#> This warning is displayed once every 8 hours.
rando
#> Randomisation list for 200 patients randomized in arms "Control" and
#> "Treatment" across 12 strata with blocks of length 4 and 8.
#> # A tibble: 2,412 × 8
#>    id      age   gender group stratum.block.id block.size treatment treatment_id
#>    <chr>   <chr> <chr>  <chr> <fct>                 <dbl> <fct>     <chr>       
#>  1 inf18m… inf1… Male   A     1                         8 Control   Control-0001
#>  2 inf18m… inf1… Male   A     1                         8 Treatment Treatment-0…
#>  3 inf18m… inf1… Male   A     1                         8 Control   Control-0003
#>  4 inf18m… inf1… Male   A     1                         8 Treatment Treatment-0…
#>  5 inf18m… inf1… Male   A     1                         8 Treatment Treatment-0…
#>  6 inf18m… inf1… Male   A     1                         8 Control   Control-0006
#>  7 inf18m… inf1… Male   A     1                         8 Control   Control-0007
#>  8 inf18m… inf1… Male   A     1                         8 Treatment Treatment-0…
#>  9 inf18m… inf1… Male   A     2                         8 Control   Control-0009
#> 10 inf18m… inf1… Male   A     2                         8 Treatment Treatment-0…
#> # ℹ 2,402 more rows

# Export for TrialMaster
if(FALSE){
  rando %>%
    dplyr::select(names(strat), treatment_id) %>%
    write.table("randomization_list.txt", sep="\t", row.names=FALSE)
}
```
