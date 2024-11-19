

# Inclusions ----------------------------------------------------------------------------------

descr$inclusions = mtcars2 %>%
  crosstable(c(ends_with("t"), starts_with("c")), by=vs,
             funs=c(mean, quantile), funs_arg=list(probs=c(.25,.75)))


# Demographic information ---------------------------------------------------------------------
# age, sex, stage, ...

descr$demographics = mtcars2 %>%
  crosstable(c(disp, cyl), by=c(am, vs),
             margin=c("row", "col"), total = "both")
