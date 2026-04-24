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

  Label used in the output tables (e.g. "AE", "Toxicity").

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


.cl-58880610{table-layout:auto;}.cl-587e692a{font-family:'DejaVu Sans';font-size:8pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-587e6952{font-family:'DejaVu Sans';font-size:8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-5883426a{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-5883427e{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-58836dda{background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-58836dee{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-58836df8{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-58836df9{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 1pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-58836e02{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-58836e03{background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-58836e0c{background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}


Measure
```

Level

All patients  
(N=200)

Patients by maximum AE grade

Grade 1

41 (20.5%)

Grade 2

64 (32.0%)

Grade 3

50 (25.0%)

Grade 4

31 (15.5%)

Grade 5

3 (1.5%)

Patients with at least one AE at or above each grade

Grade ≥ 1

189 (94.5%)

Grade ≥ 2

148 (74.0%)

Grade ≥ 3

84 (42.0%)

Grade ≥ 4

34 (17.0%)

Grade = 5

3 (1.5%)

Patients with at least one AE at each grade

Grade 1

156 (78.0%)

Grade 2

103 (51.5%)

Grade 3

56 (28.0%)

Grade 4

33 (16.5%)

Grade 5

3 (1.5%)

AE grade completeness

No AE reported

8 (4.0%)

All grades missing

3 (1.5%)

Some grades missing

59 (29.5%)

db =
[grstat_example](https://oncostat.github.io/grstat/reference/grstat_example.md)(N=20,
p_na=0) ae_table_grade(db\$ae, data_pat=db\$enrolres, arm="ARM",
measure=[c](https://rdrr.io/r/base/c.html)("max", "sup"), total=TRUE,
zero_value="-",
na_strategy=[list](https://rdrr.io/r/base/list.html)(display="always",
grouped=TRUE))
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)()

[TABLE]
