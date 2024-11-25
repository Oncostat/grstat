# function that compares the summurised tables in R versus those in SAS
# output: if difference, dataframe with each row details of difference
# if no difference, dataframe displaying table R and table SAS side by side.
# author: Nusaibah

compare_soc <- function(tabR,tabSAS){
  colnames(tabR)=gsub("all_patients_G","grade",colnames(tabR))
  tab=list()
  if (nrow(tabR)!=nrow(tabSAS)){#warning("Different number of SOC")
    if (nrow(tabR)<nrow(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,tabSAS[which(!(tabSAS$soc%in% tabR$soc)),"soc"])
      tab$table=c(tab$table,"R")
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
        tab$term=c(tab$term,tabSAS[which(!(tabSAS$term_%in% tabR$term_)),"term_"])
        tab$main=c(tab$main,"Missing PT item")
      }else{

        tab$main=c(tab$main,"Missing SOC item")
      }
    }else if (nrow(tabR)>nrow(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,tabR[which(!(tabR$soc%in% tabSAS$soc)),"soc"])
      tab$table=c(tab$table,"SAS")
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
        tab$term=c(tab$term,tabR[which(!(tabR$term_%in% tabSAS$term_)),"term_"])
        tab$main=c(tab$main,"Missing PT item")
      }else{

        tab$main=c(tab$main,"Missing SOC item")
      }
    }
  }

  if (ncol(tabR)!=ncol(tabSAS)){#warning("Different number of column (arm or grade)")
    if (ncol(tabR)<ncol(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,colnames(tabSAS)[-(which(colnames(tabSAS) %in% colnames(tabR)))])
      tab$table=c(tab$table,"R")
      tab$main=c(tab$main,"Missing grade")
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,"Filled")

    }else if (ncol(tabR)>ncol(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,colnames(tabR)[-(which(colnames(tabR) %in% colnames(tabSAS)))])
      tab$table=c(tab$table,"SAS")
      tab$main=c(tab$main,"Missing grade")
      tab$valueR=c(tab$valueR,"Filled")
      tab$valueSAS=c(tab$valueSAS,NA)

    }}
  if (all(dim(tabR)==dim(tabSAS)) | all(is.na(tabR[-(which(colnames(tabR) %in% colnames(tabSAS)))])) ){# warning("Check: same dimension of tables & same grade")
    tabR=tabR[(which(colnames(tabR) %in% colnames(tabSAS)))]


    if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
      df=tabR%>%arrange(soc,term_)%>%
        pivot_longer(-c("soc","term_"),names_to = "grade",values_to = "count")%>%
        mutate(table="R")%>%
        full_join(tabSAS%>%
                    pivot_longer(-c("soc","term_"),names_to = "grade",values_to = "count")%>%
                    mutate(table="SAS"),
                  by=c("soc","term_","grade"),
                  suffix = c(".r",".sas"))
      indice=df[which(df$count.r!=df$count.sas | (is.na(df$count.r) & !is.na(df$count.sas)) |
                        (!is.na(df$count.r) & is.na(df$count.sas))
                      ,arr.ind = T),]

    }else{df=tabR%>%arrange(soc)%>%full_join(tabSAS,by="soc",suffix = c(".r",".sas"))


    df=tabR%>%arrange(soc)%>%
      pivot_longer(-c("soc"),names_to = "grade",values_to = "count")%>%
      mutate(table="R")%>%
      full_join(tabSAS%>%
                  pivot_longer(-c("soc"),names_to = "grade",values_to = "count")%>%
                  mutate(table="SAS"),
                by=c("soc","grade"),
                suffix = c(".r",".sas"))
    indice=df[which(df$count.r!=df$count.sas | (is.na(df$count.r) & !is.na(df$count.sas)) |
                      (!is.na(df$count.r) & is.na(df$count.sas))
                    ,arr.ind = T),]
    }
    if (nrow(indice)!=0){
      # print(indice)
      # warning(paste0("Comparison result: Warning! Different outputs.",
      #                nrow(indice)," mismatching between the two tables. Above, the indices."))
      for (i in 1:nrow(indice)){
        tab =indice%>%
          mutate(level="MAJEUR",
                 table="Both",
                 main="Different value")%>%
          dplyr::rename(valueR="count.r",
                        valueSAS="count.sas")%>%
          select(-c("table.r","table.sas"))

      }
    }


  }else{  #   warning("Comparison result: same outputs")
    tab=cbind(data.frame("R table"=""),tabR,data.frame("SAS table"=""),tabSAS)
  }
  tab=as.data.frame(tab)
  return(tab)
}


