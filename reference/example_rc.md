# Simulate a RECIST dataset

Internal function that simulates a synthetic RECIST dataset following
the conventions of clinical oncology trials. In the simulation, Target
Lesions response depends on the treatment arm `enrolres$arm` (not
`enrolres$arm3`).

## Usage

``` r
example_rc(
  enrolres,
  seed,
  rc_num_timepoints = 5,
  rc_p_new_lesions = 0.09,
  rc_p_na = 0.005,
  rc_p_nt_lesions_yn = 0.5,
  rc_p_nt_lesions_resp = list(CR = 0.73, SD = 0.25, PD = 0.01, NE = 0.01),
  rc_sd_tlsum_noise = 0.5,
  rc_coef_treatement = 3,
  ...
)
```

## Arguments

- enrolres:

  the enrolment result table, from
  [`example_enrol()`](https://oncostat.github.io/grstat/reference/example_enrol.md).

- seed:

  Integer. Random seed for reproducibility (can be `NULL`).

- rc_num_timepoints:

  Integer. Number of timepoints for each patient, including baseline.

- rc_p_new_lesions:

  Integer. Probability of a new lesion

- rc_p_na:

  Integer. Probability of a missing value in reponses of Target Lesions,
  Non-Target Lesions, and New Lesions independently. They add up for the
  global response.

- rc_p_nt_lesions_yn:

  Integer. Probability of having Non-Target Lesions

- rc_p_nt_lesions_resp:

  Integer list. Probability of each Non-Target Lesions response, if
  present

- rc_sd_tlsum_noise:

  Integer. Standard deviation for the evolution of the Target Lesion sum
  of width

- rc_coef_treatement:

  Integer. Differentiates the difference in effect between the control
  and treatment arm (2 arms only). For example, `rc_coef_treatement` = 2
  mean that the growth rate of the tumor is divide per 2 and the
  elimination rate is multiplied per 2. Also, the probability of a new
  lesion is multiplied by 2.

## Value

A tibble with `N` rows and the following columns:

- `subjid`: The patient identifier

- `rcvisit`: The visit number

- `rcdt`: The visit date

- `rctlsum`: The Target Lesion length sum at each time point. The
  evolution of the value is calculated based on the percentage variation
  in tumor size from the previous time point. This variation is
  simulated using a uniform distribution between -30 and 30, with added
  noise (the noise follows a normal distribution with a mean of 0 and a
  standard deviation of `rc_sd_tlsum_noise`).

- `rctlresp`: The response associated with Target Lesions

- `rcntlresp`: The response associated with Non-Target Lesions

- `rcnew`: The appearance of a new lesion

- `rcresp`: The global RECIST response
