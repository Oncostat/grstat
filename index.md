# grstat

[grstat](https://oncostat.github.io/grstat/) is a package designed to
help standardize the descriptive clinical research analyses at GR.

## Installation

This package is not designed to be on CRAN, so you should install it
from GitHub:

``` r

# Install the latest version from Github
pak::pak("Oncostat/grstat")
```

We strongly recommend using
[`renv`](https://rstudio.github.io/renv/articles/renv.html) to ensure
reproducibility.

## Documentation

### Features and lifecycle

A full list of features is available in the
[**Reference**](https://oncostat.github.io/grstat/reference) page.

The package follows a strict validation workflow:

- ![Stable lifecycle badge](reference/figures/lifecycle-stable.svg)  
  Stable functions have been validated by the team.  
  You can use them with confidence, although reviewing the results is
  always good practice.  
  Backward compatibility will be as ensured as possible.

- ![Experimental lifecycle
  badge](reference/figures/lifecycle-experimental.svg)  
  Experimental functions have not been validated yet.  
  You should always check them with your own code and data, in every
  context.  
  Please report your findings to the team. Every validation contributes
  to the package maturation process.  
  Backward compatibility is not warranted.

[Automatic
tests](https://github.com/Oncostat/grstat/tree/main/tests/testthat) are
used to ensure that no bug or regression are added when updating or
correcting the package.

### Vignettes

You can find vignettes in the
[**Articles**](https://oncostat.github.io/grstat/articles) page.

Some are tutorials on how to use the packages functions, and some are
broader guidelines on how to use external tools.

### Prototypes

Additionally, experimental prototypes can be found in the
[Issues](https://github.com/Oncostat/grstat/issues?q=label%3Aprototype).

These are pieces of code that can be useful to many, but the validation
cycle is not even started yet.

For example, at the moment, there are:

- [RECIST Alluvial plot
  (#126)](https://github.com/Oncostat/grstat/issues/126)

- [Cox Multistate: reporting et visualisation
  (#114)](https://github.com/Oncostat/grstat/issues/114)

- [Analyse en sous-groupes
  (#106)](https://github.com/Oncostat/grstat/issues/106)

- [Helper pour calculer les RMST
  (#97)](https://github.com/Oncostat/grstat/issues/97)
