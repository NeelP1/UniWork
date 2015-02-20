#create subset of data according to promotion type

a1CatProm <- subset(a1clean, promotion_type == "Catalogue Promotion")

a1InstoreProm <- subset(a1clean, promotion_type == "In-Store Promotion")

a1NoProm <- subset(a1clean, promotion_type == "no_promotion")


#put department names into a data frame
deptSummary <- data.frame(unique(a1clean$department_name))
colnames(deptSummary) <- c("department_name")


#add columns to deptSummary: avetotsalesCatalogue | avetotsalesInstore | avetotsalesNoProm
averageTotalUnitsC <- data.frame(ave_total_units_cat = numeric(length(deptSummary[,1])), stringsAsFactors = FALSE)

averageTotalUnitsI <- data.frame(ave_total_units_instore = numeric(length(deptSummary[,1])), stringsAsFactors = FALSE)

averageTotalUnitsN <- data.frame(ave_total_units_noprom = numeric(length(deptSummary[,1])), stringsAsFactors = FALSE)


#for catalogue promotions
for(i in 1:length(deptSummary$department_name)){
  currentDepartment <- toString(deptSummary[i,1])
  
  #unique items from department
  deptItems <- data.frame(unique(a1CatProm$item_code[a1CatProm$department==currentDepartment]))
  
  colnames(deptItems) <- c(currentDepartment)
  
  catalogueSum <- data.frame(catalogue_sum = numeric(length(deptItems[,1])), stringsAsFactors = FALSE)
  
  for(j in 1:length(deptItems[,1])){
    itemName <- toString(deptItems[j,1])
    item <- subset(a1CatProm, item_code == itemName)
    catalogueSum[j,1] <- sum(item$sales_unit)
  }
  
  deptItems <- cbind(deptItems,catalogueSum)
  
  averageTotalUnitsC[i,1] <- round(mean(deptItems[,2]), digits = 3)
}

deptSummary <- cbind(deptSummary,averageTotalUnitsC)


#for instore promotions
for(i in 1:length(deptSummary$department_name)){
  currentDepartment <- toString(deptSummary[i,1])
  
  #unique items from department
  deptItemsb <- data.frame(unique(a1InstoreProm$item_code[a1InstoreProm$department==currentDepartment]))
  
  colnames(deptItemsb) <- c(currentDepartment)
  
  instoreSum <- data.frame(instore_sum = numeric(length(deptItemsb[,1])), stringsAsFactors = FALSE)

  for(j in 1:length(deptItemsb[,1])){
    itemName <- toString(deptItemsb[j,1])
    item <- subset(a1InstoreProm, item_code == itemName)
    instoreSum[j,1] <- sum(item$sales_unit)
  }
  
  deptItemsb <- cbind(deptItemsb,instoreSum)
  
  averageTotalUnitsI[i,1] <- round(mean(deptItemsb[,2]), digits = 3)
}

deptSummary <- cbind(deptSummary,averageTotalUnitsI)


#for no promotions
for(i in 1:length(deptSummary$department_name)){
  currentDepartment <- toString(deptSummary[i,1])
  
  #unique items from department
  deptItemsc <- data.frame(unique(a1NoProm$item_code[a1NoProm$department==currentDepartment]))
  
  colnames(deptItemsc) <- c(currentDepartment)
  
  nopromotionSum <- data.frame(noprom_sum = numeric(length(deptItemsc[,1])), stringsAsFactors = FALSE)
  
  for(j in 1:length(deptItemsc[,1])){
    itemName <- toString(deptItemsc[j,1])
    item <- subset(a1NoProm, item_code == itemName)
    nopromotionSum[j,1] <- sum(item$sales_unit)
  }
  
  deptItemsc <- cbind(deptItemsc,nopromotionSum)
  
  averageTotalUnitsN[i,1] <- round(mean(deptItemsc[,2]), digits = 3)
  
}

deptSummary <- cbind(deptSummary,averageTotalUnitsN)

#draw the graphs
#barplot(table(deptSummary[,2],deptSummary[,1]))


colours <- c("aliceblue","cadetblue","chartreuse3", "chartreuse4","chocolate","coral4","darkgoldenrod","deepskyblue","darkolivegreen3")

deptNames <- as.vector(deptSummary[,1])

#catalogue promotions
pie(deptSummary[,2], main = "Average sum of unit sales (Catalogue Promotion)",
    labels=deptSummary[,2], cex=0.7, col=colours)

legend("topright", deptNames, fill=colours, cex=0.8)

#instore promotions
pie(deptSummary[,3], main = "Average sum of unit sales (In-store Promotion)",
    labels=deptSummary[,3], cex=0.7, col=colours)

legend("topright", deptNames, fill=colours, cex=0.8)

#no promotion
pie(deptSummary[,4], main = "Average sum of unit sales (No Promotion)",
    labels=deptSummary[,4], cex=0.7, col=colours)

legend("topright", deptNames, fill=colours, cex=0.8)


write.csv(deptSummary, file = "MyData.csv")

write.xlsx(x = deptSummary, file = "dept_summary.xlsx", sheetName = "summary", row.names = FALSE)
