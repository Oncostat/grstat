
compair_grade <- function(tabR,tabSAS){
  
  if (nrow(tabR)!=nrow(tabSAS)){stop("Different number of grade levels")
  }
  
  if (ncol(tabR)!=ncol(tabSAS)){stop("Different number of arm")}
  if (all(dim(tabR)==dim(tabSAS))){
    print("Check: same dimension of tables")
    df=tabR%>%arrange(grade)%>%full_join(tabSAS,by="grade",suffix = c(".r",".sas"))
    indice=which(df[,paste0(tabR%>%select(-grade)%>%colnames(),paste=".r")]!=df[,paste0(tabSAS%>%select(-grade)%>%colnames(),paste=".sas")],
                 arr.ind=TRUE)
    indice[,"col"]=indice[,"col"]+1 # parce qu'on avait retiré le grade
  }
  if (nrow(indice)!=0){
    print(indice)
    warning(paste0("Comparison result: Warning! Different outputs.\n",
                   nrow(indice)," mismatching between the two tables. Above, the indices."))
    
  }else{
    warning("Comparison result: same outputs")
  }
  
}
