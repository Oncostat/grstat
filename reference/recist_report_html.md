# Create a RECIST check report (HTML or Excel)

**\[experimental\]**  
Generate a report as an HTML or Excel file base on RECIST checks made by
[`check_recist()`](https://oncostat.github.io/grstat/reference/check_recist.md).

## Usage

``` r
recist_report_html(
  recist_check,
  output_file = "recist_check_{project}_{date_extraction}.html",
  output_dir = "output/check",
  title = "RECIST Check - {project} - {date_extraction}",
  open = FALSE
)

recist_report_xlsx(
  recist_check,
  output_file = "recist_check_{project}_{date_extraction}.xlsx",
  output_dir = "output/check",
  open = FALSE
)
```

## Arguments

- recist_check:

  the result of
  [`check_recist()`](https://oncostat.github.io/grstat/reference/check_recist.md)

- output_file:

  the report file name.

- output_dir:

  the directory of output.

- title:

  the HTML report title.

- open:

  whether to open the report afterward.

## Value

`output_file` invisibly. Called for side effects.

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
