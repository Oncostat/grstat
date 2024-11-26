# function that compares the summrised tables in R versus those in SAS
# output: if difference, dataframe with each row details of difference
# if no difference, dataframe displaying table R and table SAS side by side.
# author: Nusaibah
compare_grade <- function(tabR,tabSAS){
  tab=list()
  if (nrow(tabR)!=nrow(tabSAS)){#warning("Different number of grade levels")
    if (nrow(tabR)<nrow(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"])
      tab$table=c(tab$table,"R")
      tab$main=c(tab$main,"Missing grade level")

      # tab$Mineur=c(tab$Mineur,
      #              paste0("Grade ",tabSAS[!(which(tabSAS$grade%in% tabR$grade)),"grade"], " missing in R table"))

    }else if (nrow(tabR)>nrow(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"])
      tab$table=c(tab$table,"SAS")
      tab$main=c(tab$main,"Missing grade level")

      # tab$Mineur=c(tab$Mineur,
      #              paste0("Grade ",tabR[!(which(tabR$grade%in% tabSAS$grade)),"grade"], " missing in SAS table"))

    }
  }

  if (ncol(tabR)!=ncol(tabSAS)){#warning("Different number of arm")
    if (ncol(tabR)<ncol(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,tabSAS[!(which(tabSAS$grade%in% tabR$grade)),"grade"])
      tab$table=c(tab$table,"R")
      tab$main=c(tab$main,"Missing arm")
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,"Filled")



      # tab$Mineur=c(tab$Mineur,
      #              paste0("Grade ",tabSAS[!(which(tabSAS$grade%in% tabR$grade)),"grade"], " missing in R table"))

    }else if (ncol(tabR)>ncol(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,tabR[!(which(tabR$grade%in% tabSAS$grade)),"grade"])
      tab$table=c(tab$table,"SAS")
      tab$main=c(tab$main,"Missing arm")
      tab$valueR=c(tab$valueR,"Filled")
      tab$valueSAS=c(tab$valueSAS,NA)

      # tab$Mineur=c(tab$Mineur,
      #              paste0("Grade ",tabR[!(which(tabR$grade%in% tabSAS$grade)),"grade"], " missing in SAS table"))

    }}
  if (all(dim(tabR)==dim(tabSAS)# & tabR$grade==tabSAS$grade
  )){
    # warning("Check: same dimension of tables & same grade") # à fusionner avec la condition similaire mais grade different
    df=tabR%>%arrange(grade)%>%full_join(tabSAS,by="grade",suffix = c(".r",".sas"))

    indice=df%>%
      filter(grade %in% rbind(setdiff(tabR,tabSAS),setdiff(tabSAS,tabR))$grade)

    indice2=which(df[,paste0(tabR%>%select(-grade)%>%colnames(),paste=".r")]!=df[,paste0(tabSAS%>%select(-grade)%>%colnames(),paste=".sas")],
                  arr.ind=TRUE)
    indice2[,"col"]=indice2[,"col"]+1 # parce qu'on avait retiré le grade

    if (nrow(indice)!=0){
      # print(indice)
      # warning(paste0("Comparison result: Warning! Different outputs.",
      #                nrow(indice)," mismatching between the two tables. Above, the indices."))
      for (i in 1:nrow(indice)){
        if (is.na(indice[i,"N1.r"])){

          tab$level=c(tab$level,"Mineur")
          tab$grade=c(tab$grade,indice[i,"grade"])
          tab$table=c(tab$table,"R")
          tab$main=c(tab$main,"Missing grade level")
          tab$valueR=c(tab$valueR,NA)
          tab$valueSAS=c(tab$valueSAS,paste0(indice[i,"N1.sas"],"(",indice[i,"pct1.sas"],"%)"))



          # tab$Mineur=c(tab$Mineur,
          #                                       paste0("Missing grade ",indice[i,"grade"]," in table R"))
        }else if (is.na(indice[i,"N1.sas"])){
          tab$level=c(tab$level,"Mineur")
          tab$grade=c(tab$grade,indice[i,"grade"])
          tab$table=c(tab$table,"SAS")
          tab$main=c(tab$main,"Missing grade level")

          tab$valueR=c(tab$valueR,paste0(indice[i,"N1.r"],"(",indice[i,"pct1.r"],"%)"))
          tab$valueSAS=c(tab$valueSAS,NA)



          # tab$Mineur=c(tab$Mineur,
          #                                              paste0("Missing grade ",indice[i,"grade"]," in table SAS"))
        }else if(indice2[i,"col"]%%2==0){

          tab$level=c(tab$level,"MAJEUR")
          tab$grade=c(tab$grade,df[indice2[i,"row"],"grade"])
          tab$table=c(tab$table,"Both")
          tab$main=c(tab$main,"Different number")
          tab$valueR=c(tab$valueR,tabR[indice2[i,"row"],indice2[i,"col"]])
          tab$valueSAS=c(tab$valueSAS,tabSAS[indice2[i,"row"],indice2[i,"col"]])



          # tab$MAJEUR=c(tab$MAJEUR,
          #                                        paste0("Grade ",df[indice[i,"row"],"grade"],
          #                                               ". Different number:  table SAS N=",tabSAS[indice[i,"row"],indice[i,"col"]], ";  table R N=", tabR[indice[i,"row"],indice[i,"col"]]))
        }else if (indice2[i,"col"]%%2==1){


          tab$level=c(tab$level,"MAJEUR")
          tab$grade=c(tab$grade,df[indice2[i,"row"],"grade"])
          tab$table=c(tab$table,"Both")
          tab$main=c(tab$main,"Different percentage")
          tab$valueR=c(tab$valueR,tabR[indice2[i,"row"],indice2[i,"col"]])
          tab$valueSAS=c(tab$valueSAS,tabSAS[indice2[i,"row"],indice2[i,"col"]])




          # tab$MAJEUR=c(tab$MAJEUR,
          #                                              paste0("Grade ",df[indice[i,"row"],"grade"],
          #                                                     ". Different percentage: table SAS ",tabSAS[indice[i,"row"],indice[i,"col"]], "%; table R ", tabR[indice[i,"row"],indice[i,"col"]],"%."))
        }


      }
    }



    # else if(all(dim(tabR)==dim(tabSAS)) & !all(tabR$grade==tabSAS$grade)){
    #
    #
    #   warning("Check: same dimension of tables BUT missing grade(s)")
    #   df=tabR%>%arrange(grade)%>%full_join(tabSAS,by="grade",suffix = c(".r",".sas"))
    #
    #
    #   indice=df%>%
    #     filter(grade %in% c(setdiff(tabR$grade,tabSAS$grade),setdiff(tabSAS$grade,tabR$grade)))
    #
    #
    #   if (nrow(indice)!=0){
    #     print(indice)
    #     warning(paste0("Comparison result: Warning! Different outputs. ",
    #                    nrow(indice)," mismatching between the two tables. Above, the indices."))
    #     for (i in 1:nrow(indice)){
    #
    #       if (is.na(indice[i,"N1.r"])){
    #
    #         tab$level=c(tab$level,"Mineur")
    #         tab$grade=c(tab$grade,indice[i,"grade"])
    #         tab$table=c(tab$table,"R")
    #         tab$main=c(tab$main,"Missing grade levels")
    #
    #
    #         # tab$Mineur=c(tab$Mineur,
    #         #                                       paste0("Missing grade ",indice[i,"grade"]," in table R"))
    #         }else if (is.na(indice[i,"N1.sas"])){
    #         tab$level=c(tab$level,"Mineur")
    #         tab$grade=c(tab$grade,indice[i,"grade"])
    #         tab$table=c(tab$table,"SAS")
    #         tab$main=c(tab$main,"Missing grade levels")
    #
    #
    #
    #         # tab$Mineur=c(tab$Mineur,
    #         #                                              paste0("Missing grade ",indice[i,"grade"]," in table SAS"))
    #       }
    #
    #     }
    #
    #
    #   }
    #
    }else{  #   warning("Comparison result: same outputs")
tab=cbind(data.frame("R table"=""),tabR,data.frame("SAS table"=""),tabSAS)
  }
  tab=as.data.frame(tab)
  return(tab)
}

