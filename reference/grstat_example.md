# Example databases

Example tables, mostly used in examples and tests.

## Usage

``` r
grstat_example(N = 200, seed = 42, ...)
```

## Arguments

- N:

  the number of patients

- seed:

  the random seed (can be `NULL`)

- ...:

  passed on to internal functions. See
  [`example_enrol()`](https://oncostat.github.io/grstat/reference/example_enrol.md),
  [`example_ae()`](https://oncostat.github.io/grstat/reference/example_ae.md),
  and
  [`example_rc()`](https://oncostat.github.io/grstat/reference/example_rc.md)
  for the argument names.

## Value

A list of datasets, like in EDCimport.
