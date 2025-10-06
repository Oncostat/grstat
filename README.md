
<!-- README.md is generated from README.Rmd. Please edit that file -->

# grstat <a href='https://Oncostat.github.io/grstat/'><img src='man/figures/logo.png' align="right" height="175" /></a>

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN status](https://www.r-pkg.org/badges/version/grstat)](https://CRAN.R-project.org/package=grstat)
[![Last Commit](https://img.shields.io/github/last-commit/Oncostat/grstat)](https://github.com/Oncostat/grstat)
[![R-CMD-check](https://github.com/Oncostat/grstat/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Oncostat/grstat/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`{grstat}` is a package designed to help standardize the descriptive clinical research analyses at GR.

## Installation

The package is not on CRAN, so you should install from GitHub:

``` r
# Install development version on Github
pak::pak("Oncostat/grstat@v0.1.0.9018")
```

Note that, for reproducibility purpose, an even better solution would be
to use [`renv`](https://rstudio.github.io/renv/articles/renv.html).

## Features

See the full documentation on https://oncostat.github.io/grstat/.

### Stable

- `ae_table_grade()`, `ae_table_soc()`
- `ae_plot_grade()`, `butterfly_plot()`

### Dev

- `gr_new_project()`
- `waterfall_plot()`
