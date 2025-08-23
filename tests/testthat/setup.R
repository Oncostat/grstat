options(
  pillar.width=Inf,
  pillar.print_max=Inf,
  pillar.max_footer_lines=Inf,
  pillar.max_extra_cols=Inf
)

db_test = grstat_example(N=200)
db_test_na = grstat_example(N=200, p_na=0.1)
