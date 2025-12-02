# Generate an Adverse Event table

Internal function that simulates adverse events data with a toxicity
effect that depends on the treatment arm `enrolres$arm`. The effect is
not simulated according to `enrolres$arm3`.

## Usage

``` r
example_ae(
  enrolres,
  seed,
  p_na = 0,
  p_sae = 0.1,
  p_sae_trt = p_sae,
  n_max = 15,
  n_max_trt = n_max,
  w_soc = 1,
  w_soc_trt = 1,
  beta0 = -1,
  beta_trt = 0.4,
  beta_sae = 1,
  ...
)
```

## Arguments

- enrolres:

  the enrolment result table, from
  [`example_enrol()`](https://oncostat.github.io/grstat/reference/example_enrol.md).

- seed:

  Integer. Random seed for reproducibility (can be `NULL`).

- p_na:

  proportion of missing values (can be a list with a value for each
  column)

- p_sae, p_sae_trt:

  proportion of serious AE in control/exp arms

- n_max, n_max_trt:

  maximum number of AE per patient in control/exp arms (binomial with
  probability 20%)

- w_soc, w_soc_trt:

  log-weights for SOC that should be over-representated in control/exp
  arms.

- beta0, beta_trt, beta_sae:

  the intercept, treatement coef and SAE coef to be used in the
  exponential decay model that generates the AE grade.

## Value

A tibble with `N` rows and the following columns:

- `subjid`: the patient identifier. Each patient has a number of AE
  simulated with a binomial distribution with size `n_max` or
  `n_max_trt` and probability 20%.

- `aesoc`: the CTCAE System Organ Class. Lazily simulated with an
  uniform probability.

- `aeterm`: the CTCAE High Level Group Term. Lazily simulated with an
  uniform probability. Four examples of HLGT per SOC are provided.

- `aegr`: the CTCAE grade, ranging from 1 to 5. The probability is
  simulated using an exponential decay rate for grades 1 to 4
  (`probs = exp(rate * c(1:4))`), with probability for grade 5 being the
  one for grade 4 divided by 7. The probability vector is then
  normalized to sum to 1. The rate is calculated as
  `rate = beta0 + beta_trt*(arm!="Control") + beta_sae*(sae=="Yes")`.

- `aerel`: the causality of the AE. Lazily simulated with an uniform
  probability.

- `sae`: Indicator of Serious AE. Simulated using `p_sae` and
  `p_sae_trt`.
