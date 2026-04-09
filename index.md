# grstat [![](reference/figures/logo.png)](https://Oncostat.github.io/grstat/)

[grstat](https://oncostat.github.io/grstat/) is a package designed to
help standardize the descriptive clinical research analyses at GR.

## Installation

This package is not designed to be on CRAN, so you should install it
from GitHub:

``` r
# Install development version on Github
pak::pak("Oncostat/grstat@v0.1.0.9028")
```

Note that, for reproducibility purpose, an even better solution would be
to use [`renv`](https://rstudio.github.io/renv/articles/renv.html).

## Features

See the full documentation on <https://oncostat.github.io/grstat/>.

### Stable

- [`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md),
  [`ae_table_soc()`](https://oncostat.github.io/grstat/reference/ae_table_soc.md)
- [`ae_plot_grade()`](https://oncostat.github.io/grstat/reference/ae_plot_grade.md),
  [`butterfly_plot()`](https://oncostat.github.io/grstat/reference/butterfly_plot.md)

### Utils

- [`gr_new_project()`](https://oncostat.github.io/grstat/reference/gr_new_project.md)
- [`gr_officer_template()`](https://oncostat.github.io/grstat/reference/gr_officer_template.md)

### Dev

- [`randomisation_list()`](https://oncostat.github.io/grstat/reference/randomisation_list.md)
- [`check_recist()`](https://oncostat.github.io/grstat/reference/check_recist.md)
- [`calc_best_response()`](https://oncostat.github.io/grstat/reference/calc_best_response.md)
- [`boin_plot()`](https://oncostat.github.io/grstat/reference/boin_plot.md)
- [`survfit_stack()`](https://oncostat.github.io/grstat/reference/survfit_stack.md)
- [`waterfall_plot()`](https://oncostat.github.io/grstat/reference/waterfall_plot.md)
