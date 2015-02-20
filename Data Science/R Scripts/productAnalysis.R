#time series and decompose time series of best performing products
#and products that dont appear to have any trend.
#In addition get units total revenue.

#put department names into a data frame
deptSummary <- data.frame(unique(a1clean$department_name))
colnames(deptSummary) <- c("department_name")

#setting up column vectors to store highest revenue item data
highRevenueItem <- data.frame(high_revenue_item = numeric(length(deptSummary[,1])), stringsAsFactors = FALSE)
highRevenueItemb <- data.frame(unit_sales_total = numeric(length(deptSummary[,1])), stringsAsFactors = FALSE)
highRevenueItemc <- data.frame(item_revenue = numeric(length(deptSummary[,1])), stringsAsFactors = FALSE)



#get the max sales unit and revenue item for each department
for(i in 1:length(deptSummary$department_name)){
  currentDepartment <- toString(deptSummary[i,1])
  
  #unique items from department
  deptItems <- data.frame(unique(a1clean$item_code[a1clean$department==currentDepartment]))
  
  colnames(deptItems) <- c(currentDepartment)
  
  sums <- data.frame(unit_sales_sum = numeric(length(deptItems[,1])), stringsAsFactors = FALSE)
  revenues <- data.frame(unit_revenue = numeric(length(deptItems[,1])), stringsAsFactors = FALSE)
  
  for(j in 1:length(deptItems[,1])){
    itemName <- toString(deptItems[j,1])
    item <- subset(a1clean, item_code == itemName)
    sums[j,1] <- sum(item$sales_unit)
    revenues[j,1] <- sum(item$sales_unit)*mean(item$unit_price)
  }
  
  deptItems <- cbind(deptItems,sums,revenues)
  
  highRevenueItem[i,1] <- toString(deptItems[which.max(deptItems$unit_revenue),1])
  highRevenueItemb[i,1] <- toString(deptItems[which.max(deptItems$unit_revenue),2])
  highRevenueItemc[i,1] <- toString(deptItems[which.max(deptItems$unit_revenue),3])
}

deptSummary <- cbind(deptSummary, highRevenueItem, highRevenueItemb, highRevenueItemc)


#do time series on higest revenue item
item <- subset(a1clean, item_code == toString(deptSummary[which.max(deptSummary$item_revenue),2])) 

itemts <- ts(item$sales_unit, start=c(2008,1), end=c(2013,6),frequency=12)
plot(itemts, main = "Time Series on Highest Revenue Item", ylab = "Unit Sales", col = "blue")
fit <- stl(itemts, s.window="period")
plot(fit, main = "Decomposed Time Series on Highest Revenue Item")

#