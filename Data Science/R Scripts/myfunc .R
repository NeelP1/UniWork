myfunc <- function(tbl, dataframe){
  sums <- data.frame(itemSum = numeric(length(tbl[,1])), stringsAsFactors = FALSE)
  
  for(i in 1:length(sums$itemSum)){
    sums$itemSum[i] <- sum(dataframe$sales_unit[dataframe$item_code==tbl[i,1]])
  }
  
  totalUnitSale <- sum(sums$itemSum)
  
  percentages <- data.frame(percentage = numeric(length(tbl[,1])), stringsAsFactors = FALSE)
  
  for(i in 1:length(percentages$percentage)){
    percentages$percentage[i] <- (sums$itemSum[i]/totalUnitSale)*100
  }
  
  newTable <- cbind(tbl,sums,percentages)
  
  #if an item has > 1% of sales for that department then add
  #to a list
  
  return (newTable)
}