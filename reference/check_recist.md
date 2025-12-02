# Check a RECIST dataset

**\[experimental\]**  
Perform multiple checks on a RECIST dataset. The checks can be exported
as an HTML or Excel report using
[`recist_report_html()`](https://oncostat.github.io/grstat/reference/recist_report_html.md)
or
[`recist_report_xlsx()`](https://oncostat.github.io/grstat/reference/recist_report_html.md).

## Usage

``` r
check_recist(
  rc,
  mapping = gr_recist_mapping(),
  exclude_post_pd = TRUE,
  supp_cols_df = NULL
)
```

## Arguments

- rc:

  The recist dataset to check

- mapping:

  The character vector defining the variable mapping. Refer to
  [`gr_recist_mapping()`](https://oncostat.github.io/grstat/reference/gr_recist_mapping.md)
  for default values and adjust as needed.

- exclude_post_pd:

  Logical; if `TRUE` (default), assessments after the first PD are
  excluded.

- supp_cols_df:

  A dataframe containing additional information on patients, e.g.
  `SITEC` the center caption. Must contain a `SUBJID` column.

## Value

a tibble of nested checks, of class `check_recist`

## See also

[RECIST
guidelines](https://ctep.cancer.gov/protocoldevelopment/docs/recist_guideline.pdf)

## Examples

``` r
# we unfortunately cannot provide a flawed simulated recist dataset, at least not yet
if (FALSE) { # \dontrun{
db = read_database()
mapping = gr_recist_mapping()
supp_cols_df = enrolres %>% select(SUBJID, SITEC, STNO)
recist_check = check_recist(db$rc, mapping=mapping, supp_cols_df=supp_cols_df)
recist_check
recist_report_html(recist_check)
recist_report_xlsx(recist_check)
} # }
```
