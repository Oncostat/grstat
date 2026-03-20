# Adds dummy sections to the report

Adds sections 1 to 8 to the report so that the first title points to the
standard report section 9 "Inclusion".

## Usage

``` r
body_add_gr_sections_1_8(doc, sections = 1:8)
```

## Arguments

- doc:

  an officer `rdocx` object

- sections:

  Sections to add

## Value

an officer `rdocx` object

## Examples

``` r
officer::read_docx() %>%
  body_add_gr_sections_1_8() %>%
  crosstable::write_and_open()
```
