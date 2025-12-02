# Graphic representation of AEs

**\[experimental\]**  
Produce a graphic representation of AE, counting AE as bars for each
patient, colored by grade. Can be faceted by treatment arm.

## Usage

``` r
ae_plot_grade_sum(
  df_ae,
  ...,
  df_enrol,
  low = "#ffc425",
  high = "#d11141",
  weights = NULL,
  arm = NULL,
  grade = "AEGR",
  subjid = "SUBJID"
)
```

## Arguments

- df_ae:

  adverse event dataset, one row per AE, containing subjid, soc, and
  grade.

- ...:

  unused

- df_enrol:

  enrollment dataset, one row per patient, containing subjid (and arm if
  needed). All patients should be in this dataset.

- low:

  the color of Grade 1 AE

- high:

  the color of Grade 5 AE

- weights:

  (optional) a length 5 numeric vector, giving the weights of each grade

- arm:

  name of the treatment column in `df_enrol`. Case-insensitive. Can be
  set to `NULL`.

- grade:

  name of the AE grade column in `df_ae`. Case-insensitive.

- subjid:

  name of the patient ID in both `df_ae` and `df_enrol`.
  Case-insensitive.

## Value

a ggplot

## See also

[`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md),
[`ae_table_soc()`](https://oncostat.github.io/grstat/reference/ae_table_soc.md),
[`ae_plot_grade()`](https://oncostat.github.io/grstat/reference/ae_plot_grade.md),
`ae_plot_grade_sum()`,
[`butterfly_plot()`](https://oncostat.github.io/grstat/reference/butterfly_plot.md)

## Examples

``` r
tm = grstat_example()
attach(tm, warn.conflicts=FALSE)
ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres)

ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM")

ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM", weights=c(1,1,3,6,10))
```
