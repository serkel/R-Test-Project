library(data.table)
library(lubridate)
library(Hmisc)


#Read in the data transactions.csv. ####
transactions <- fread("transactions.csv")
#Check the data format
str(transactions)

#Bring the date into POSIXct format. ####/
transactions[, TransDate:=dmy(TransDate, tz="UTC")]



#########################################################################################

# 2. Aggregation of variables ####

#Save the latest transaction as the object now in your R environment. ####
max.Date <- max(transactions[, TransDate])

#Create a new data.table called rfm. ####
#that includes the customer ID, as well as the measures for purchase recency, frequency and monetary value.
rfm <- transactions[,list(
  recency = as.numeric(max.Date - max(TransDate)), #recency = difference between latest transaction and "today"
  frequency = .N, #frequency = number of transactions
  monetary = sum(PurchAmount)), #monetary = amount spent per transaction
  by="Customer"
  ]
