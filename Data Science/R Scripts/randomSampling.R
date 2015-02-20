#script which randomly samples 2 or 3 items
#trying to find:
#1.product where data is insufficient to draw any conclusions
#2.product where it is impossible to see any marketing effect

#sample 4 random rows using sample() function
a1Sample <- a1clean[sample(1:nrow(a1clean), 4, replace = FALSE, prob = NULL),]

#create a subset using the item first entry in the sampled table
itemName <- toString(a1Sample$item_code[1])
item <- subset(a1clean, item_code == itemName)

itemts <- ts(item$sales_unit, start=c(2008,1), end=c(2013,6),frequency=12)
plot(itemts, main = "Time Series on a Random Item", ylab = "Unit Sales", col = "blue")
fit <- stl(itemts, s.window="period")
plot(fit, main = "Decomposed Time Series on a Random Item")


#hand picked sample
item2 <- subset(a1clean, item_code == "I-111164")
item2ts <- ts(item2$sales_unit, start=c(2008, 1), end=c(2013, 6), frequency=12) 
plot(item2ts, main = "Time Series on a Random Item", ylab = "Unit Sales", col = "violet")
fit2 <- stl(item2ts, s.window="period")
plot(fit2, main = "Decomposed Time Series on a Random Item")