




# 1/ Check age validity -----------------------------------------------------------------------

find_keyword("age")

# enrolreq %>%
#   filter(age<0 | age>122) %>%
#   edc_data_warn("Age is invalid", issue_n=1)

iris %>%
  mutate(subjid=row_number()) %>%
  filter(Sepal.Length>7.5) %>%
  edc_data_warn("I don't know about flowers but isn't 7.5 a lot?", issue_n=1)

