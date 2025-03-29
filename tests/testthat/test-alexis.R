test_that("grstat example RC", {


  db = grstat_example(N=2000)
  rc <- db$recist
  plotly::ggplotly(waterfall_plot(rc))



})
