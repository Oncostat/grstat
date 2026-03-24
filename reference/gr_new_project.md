# Create a clinical research project

Create a clinical research project with a standardized structure:

    ├── main.R
    ├── NEWS.md
    ├── README.md
    └── my_proj.Rproj
    ├── R
    │   ├── init.R
    │   ├── read.R
    │   ├── check.R
    │   ├── description.R
    │   ├── population.R
    │   ├── graph.R
    │   └── report.R
    │   ├── 09_inclusion.R
    │   ├── 10_baseline.R
    │   ├── 11_treatments.R
    │   ├── 12_tolerance.R
    │   ├── 13_efficacy.R
    │   ├── 14_other_analyses.R
    │   ├── 15_ancillary_analyses.R

## Usage

``` r
gr_new_project(
  path,
  ...,
  trial_name = NULL,
  headers = NULL,
  open = TRUE,
  verbose = TRUE
)
```

## Arguments

- path:

  Destination directory for the project root. Will be created if needed.

- ...:

  Dots are ignored. Reserved for future extensions.

- trial_name:

  The abbreviated name of the trial.

- headers:

  Optional key–value headers to inject at the top of created files

- open:

  If `TRUE`, opens the new project in RStudio.

- verbose:

  If `TRUE`, print diagnostics.

## Value

Invisibly, the normalized path to the created project.

## Structure

At the root of the project:

- `README.md`: short project description

- `NEWS.md`: version log

- `main.R`: central script that orchestrates the workflow

- `<project>.Rproj`: RStudio project

In the R folder:

- `init.R`: packages loading and global options

- `read.R`: data import and global variables

- `population.R`: protocol populations

- Files ranging from `09_xxx` to `15_xxx` hold your analyses

- `check.R`: data checks (e.g., `edc_data_warn()`)

- `report.R`: report generation (e.g., `{{officer}}`)

## Examples

``` r
if (FALSE) { # \dontrun{
  headers = c("Statistician"="Dan",
              "Creation date"="2025-01-01")
  gr_new_project(headers=headers, trial_name="MYSTUDY")
} # }
```
