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