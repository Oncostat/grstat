#fonction formatting R and SAS outputs to same table format
outputs_ae_table_grade <- function(R_output, 
                                    SAS_output, 
                                    round = 0 #rounding of recalculated percentages in group_grades_zeroNA()
                                    ){
  
  #formatting grade from character to numeric
  R_output <- R_output %>% 
    mutate(grade = ifelse(variable == "No declared AE", 0, as.numeric(str_extract(variable, "\\d"))))
  SAS_output <- SAS_output %>% 
    mutate(grade = as.numeric(str_extract(max_aegr1, "\\d")))
  
  #separating each column N(pct) into 2 columns N and pct
  R_separated <- R_output %>% select(grade) %>% 
    bind_cols(
      separate_n_pct(R_output %>% select(-c(.id, label, variable, grade)))
    )
  SAS_separated <- SAS_output %>% select(grade) %>% 
    bind_cols(
      separate_n_pct(SAS_output %>% select(-c(max_aegr1, grade)))
    )
  
  #missing figure with macro SAS <=> 0 with R package
  SAS_separated <- SAS_separated %>% 
    replace(is.na(.), 0)
  
  #grouping figures of missing grades and grades 0 for R function
  R_separated <- group_grades_zeroNA(R_separated, round = round)
  
  return(list(R = R_separated, SAS = SAS_separated)) 
}
