# reading the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#creating a new data frame holding the aggregate values
emissions <- aggregate(NEI[, "Emissions"], by=list(NEI$year), FUN=sum)
#changing the names for readability
names(emissions)<-c("year","Total emisson")
#the values are large so converting into larger units
emissions[,2]<-round(emissions[,2]/1000,2)
#creating the plot
png(filename="./plot1.png",width=500,height=500)
barplot(emissions[,2],names.arg=emissions[,1],main=c("Total emisson of PM2.5"),xlab="Year",ylab="PM2.5 in kilo tons",col="light blue")
dev.off()