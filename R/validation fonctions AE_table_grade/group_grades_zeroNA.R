#fonction grouping figures of missing grades and grades 0 for R function ae_table_grade
group_grades_zeroNA <- function(data, round = 0){
  
  #suming N of missing grades and grades 0
  data <- data %>%
    mutate(grade = replace_na(grade, 0)) %>% 
    group_by(grade) %>% 
    mutate(across(starts_with("N"), ~sum(., na.rm = T))) %>% 
    distinct(grade, .keep_all = T) %>% 
    ungroup()
  
  #recalculating pct
  ngroups <- (ncol(data) - 1) / 2
  for(i in 1:ngroups){
    npatients <- sum(data[, paste0("N", i)])
    data[data$grade == 0, paste0("pct", i)] <- round(data[data$grade == 0, paste0("N", i)] * 100 / npatients, round)
  }
  
  data <- data %>% arrange(grade)
  
  return(data)
  
}
