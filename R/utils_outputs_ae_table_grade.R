#fonction separating each column N(pct) into 2 columns N and pct
separate_n_pct <- function(data){
  
  #separation of 1 character column into 2 character columns
  data <- colnames(data) %>% 
    imap(
      ~data %>% select(all_of(.x)) %>% 
        separate(.x, into = c(paste0("N", .y), paste0("pct", .y)), sep = "\\(")
    ) %>% 
    bind_cols()
  
  #extraction of figures into numeric columns
  data <- data %>% 
    mutate(
      across(everything(), ~as.numeric(str_extract(.x, "\\d+\\.?\\d*")))
    )
  
  return(data)
  
}



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
