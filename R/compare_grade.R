# function that compares the summrised tables in R versus those in SAS
# output: if difference, dataframe with each row details of difference
# if no difference, dataframe displaying table R and table SAS side by side.
# author: Nusaibah


compare_grade <- function(tabR,tabSAS){
  tab=list()

  if (nrow(tabR)!=nrow(tabSAS)){ #warning("Different number of grade levels")

    if (nrow(tabR)<nrow(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"])
      tab$table=c(tab$table,"R")
      tab$main=c(tab$main,"Missing grade level")

    }else if (nrow(tabR)>nrow(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"])
      tab$table=c(tab$table,"SAS")
      tab$main=c(tab$main,"Missing grade level")

    }
  }

  if (ncol(tabR)!=ncol(tabSAS)){  #warning("Different number of arm")

    if (ncol(tabR)<ncol(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabSAS)[which(!(colnames(tabSAS)%in% colnames(tabR)))],"[:digit:]")),collapse = " & "))
      tab$table=c(tab$table,"R")
      tab$main=c(tab$main,"Missing arm")
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,"Filled")


    }else if (ncol(tabR)>ncol(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabR)[which(!(colnames(tabR)%in% colnames(tabSAS)))],"[:digit:]")),collapse = " & "))
      tab$table=c(tab$table,"SAS")
      tab$main=c(tab$main,"Missing arm")
      tab$valueR=c(tab$valueR,"Filled")
      tab$valueSAS=c(tab$valueSAS,NA)

    }}

  if (all(dim(tabR)==dim(tabSAS))){
    # warning("Check: same dimension of tables")

    df=tabR%>%arrange(grade)%>%full_join(tabSAS,by="grade",suffix = c(".r",".sas"))

    indice=which(df[,paste0(tabR%>%select(-grade)%>%colnames(),paste=".r")]!=df[,paste0(tabSAS%>%select(-grade)%>%colnames(),paste=".sas")],
                 arr.ind=TRUE)  # difference numérique number or percentage
    indice[,"col"]=indice[,"col"]+1 # parce qu'on avait retiré le grade

    indice=rbind(indice,
                 which(is.na(df),arr.ind = T)%>%as.data.frame())
    # difference NA quand 2 grades ne se correspondent pas dans les 2 tables. je garde NA
    if (nrow(indice)!=0){
      for (i in 1: nrow(indice)){

        if (is.na(df[indice[i,"row"],indice[i,"col"]]) & grepl(".r",colnames(df)[indice[i,"col"]])){
          tab$level=c(tab$level,"Mineur")
          tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
          tab$table=c(tab$table,"R")
          tab$main=c(tab$main,"Missing grade level")
          tab$valueR=c(tab$valueR,NA)
          tab$valueSAS=c(tab$valueSAS,
                         paste0(df[indice[i,"row"],indice[i,"col"]+2],
                                "(",df[indice[i,"row"],indice[i,"col"]+3],"%)"))
          if (ncol(tabR)>3 & ncol(tabSAS)>3){
            tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))
          }

        }else if (is.na(df[indice[i,"row"],indice[i,"col"]]) & grepl(".sas",colnames(df)[indice[i,"col"]])){
          tab$level=c(tab$level,"Mineur")
          tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
          tab$table=c(tab$table,"SAS")
          tab$main=c(tab$main,"Missing grade level")

          tab$valueR=c(tab$valueR, paste0(df[indice[i,"row"],indice[i,"col"]-2],
                                          "(",df[indice[i,"row"],indice[i,"col"]-1],"%)"))
          tab$valueSAS=c(tab$valueSAS,NA)

          if (ncol(tabR)>3 & ncol(tabSAS)>3){
            tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))
          }
        }else if(indice[i,"col"]%%2==0){

          tab$level=c(tab$level,"MAJEUR")
          tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
          tab$table=c(tab$table,"Both")
          tab$main=c(tab$main,"Different number")
          tab$valueR=c(tab$valueR,tabR[indice[i,"row"],indice[i,"col"]]%>%pull)
          tab$valueSAS=c(tab$valueSAS,tabSAS[indice[i,"row"],indice[i,"col"]]%>%pull)
          if (ncol(tabR)>3 & ncol(tabSAS)>3){
            tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))
          }
        }else if (indice[i,"col"]%%2==1){


          tab$level=c(tab$level,"MAJEUR")
          tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
          tab$table=c(tab$table,"Both")
          tab$main=c(tab$main,"Different percentage")
          tab$valueR=c(tab$valueR,tabR[indice[i,"row"],indice[i,"col"]]%>%pull)
          tab$valueSAS=c(tab$valueSAS,tabSAS[indice[i,"row"],indice[i,"col"]]%>%pull)
          if (ncol(tabR)>3 & ncol(tabSAS)>3){
            tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))
          }
        }


      }
      tab=as.data.frame(tab)%>%distinct(level,grade,table,main,.keep_all = TRUE)
    }else{     warning("Comparison result: same outputs")
      tab=cbind(data.frame("R table"=""),tabR,data.frame("SAS table"=""),tabSAS)
    }
  }

  return(as.data.frame(tab))
}

