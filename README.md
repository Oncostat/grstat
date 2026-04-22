
# grstat <a href='https://Oncostat.github.io/grstat/'><img src='man/figures/logo.png' align="right" height="175" /></a>

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Last Commit](https://img.shields.io/github/last-commit/Oncostat/grstat)](https://github.com/Oncostat/grstat)
[![R-CMD-check](https://github.com/Oncostat/grstat/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Oncostat/grstat/actions/workflows/R-CMD-check.yaml)
[![Current Version](https://img.shields.io/github/r-package/v/Oncostat/grstat/main?color=purple\&label=Version)](https://github.com/Oncostat/grstat/tree/main)

<!-- badges: end -->

`{grstat}` is a package designed to help standardize the descriptive clinical research analyses at GR.

## Installation

This package is not designed to be on CRAN, so you should install it from GitHub:

``` r
# Install development version on Github
pak::pak("Oncostat/grstat@v0.1.0.9031")
```

Note that, for reproducibility purpose, an even better solution would be
to use [`renv`](https://rstudio.github.io/renv/articles/renv.html).

## Features

See the full documentation on https://oncostat.github.io/grstat/.

### Stable

- `ae_table_grade()`, `ae_table_soc()`
- `ae_plot_grade()`, `butterfly_plot()`

### Utils

- `gr_new_project()`
- `gr_officer_template()`

### Dev

- `randomisation_list()`
- `check_recist()`
- `calc_best_response()`
- `boin_plot()`
- `survfit_stack()`
- `waterfall_plot()`
