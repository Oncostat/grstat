# Tabulate Adverse Events by Grade (max, ≥x, ==x)

**\[stable\]**  
This function creates summary tables of adverse events (AEs) by grade,
for each treatment arm if provided. By default, it shows three measures:

- `"max"`: highest AE grade experienced by each patient

- `"sup"`: at least one AE of grade ≥ *x*

- `"eq"`: at least one AE of grade == *x*

Converts an object of class `ae_table_grade` to a formatted `flextable`.

## Usage

``` r
ae_table_grade(
  data_ae,
  ...,
  data_pat,
  measure = c("max", "sup", "eq"),
  arm = NULL,
  grade = "AEGR",
  subjid = "SUBJID",
  ae_label = "AE",
  percent_pattern = "{n} ({p}%)",
  percent_digits = 0,
  zero_value = "0",
  total = TRUE,
  na_strategy = list(display = "always", grouped = TRUE)
)

# S3 method for class 'ae_table_grade'
as_flextable(x, ..., padding_v = NULL)
```

## Arguments

- data_ae:

  Data frame of adverse events, with one row per AE.

- ...:

  Unused.

- data_pat:

  Data frame of enrolled patients, with one row per patient.

- measure:

  Character vector specifying which variants to compute: `"max"`,
  `"sup"`, `"eq"`.

- arm:

  Name of the arm column in `data_pat`. If `NULL`, all patients are
  pooled.

- grade:

  Name of the AE grade column in `data_ae`.

- subjid:

  Name of the subject ID column (in both data frames).

- ae_label:

  Label used in the output tables (e.g. "AE", "SAE", "Toxicity").

- percent_pattern:

  Pattern used to format counts and percentages. Use `{n}` and `{p}` as
  placeholders.

- percent_digits:

  Number of digits to show for percentages.

- zero_value:

  String to use when count is zero.

- total:

  Logical. If `TRUE`, adds a "Total" column across arms (only if
  multiple arms exist).

- na_strategy:

  A named list controlling how missing AEs or absent patients are
  displayed in the output tables. Must contain `display` (one of
  `"if_any"` or `"always"`) and `grouped` (logical).

- x:

  An object of class `ae_table_grade`.

- padding_v:

  Vertical padding for cells.

## Value

A data frame of class `ae_table_grade`, ready for use with
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html).

A `flextable` object ready to print or export.

## Examples

``` r
db = grstat_example(N=200, p_na=0.1)
ae_table_grade(db$ae, data_pat=db$enrolres,
               total=FALSE, percent_digits=1) %>%
  as_flextable()


.cl-d0fe0e64{table-layout:auto;}.cl-d0f6fcaa{font-family:'DejaVu Sans';font-size:8pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d0f6fcb4{font-family:'DejaVu Sans';font-size:8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d0f9bdd2{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d0f9bde6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d0f9ed70{background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d0f9ed7a{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d0f9ed84{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d0f9ed85{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 1pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d0f9ed8e{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d0f9ed8f{background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d0f9ed98{background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}


Measure
```
