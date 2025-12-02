# Create a clinical research project

Create a clinical research project with a standardized structure:

    ├── main.R
    ├── NEWS.md
    ├── R
    │   ├── init.R
    │   ├── read.R
    │   ├── check.R
    │   ├── description.R
    │   ├── graph.R
    │   └── report.R
    ├── README.md
    └── my_proj.Rproj

## Usage

``` r
gr_new_project(path, open = TRUE, verbose = TRUE)
```

## Arguments

- path:

  A path. If it does not exist, it is created.

- open:

  If `TRUE`, opens the new project in RStudio.

- verbose:

  If `TRUE`, shows diagnostics.

## Value

The path to the project, invisibly.

## Structure

At the root of the project:

- `README.md` contains a short description of the project

- `NEWS.md` contains the descriptions of the versions of the project

- `main.R` is the central script that sequentially calls all the others

In the R folder:

- `init.R` loads all used packages and set options

- `read.R` reads the data and sets global variables

- `check.R` checks the data, e.g. using `edc_data_warn()`

- `description.R` describe the data, e.g. using
  [`crosstable::crosstable()`](https://danchaltiel.github.io/crosstable/reference/crosstable.html)

- `graph.R` create plots, and saves them on the disk or in the `plots`
  global list

- `report.R` creat the report, e.g. using the `officer` package

## Examples

``` r
if (FALSE) { # \dontrun{
  gr_new_project("projects/my_project_folder")
} # }
```
