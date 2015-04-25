# reading the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subseting to get Baltimore city emissions data
bc_data<-subset(NEI,fips=="24510")
emissions <- aggregate(bc_data[, "Emissions"], by=list(bc_data$year), FUN=sum)
names(emissions)<-c("year","Total emisson")
#creating a barplot
png(filename="./plot2.png")
barplot(emissions[,2],names.arg=emissions[,1],main=c("Total emisson of PM2.5 in Baltimore city"),xlab="Year",ylab="PM2.5 in tons",col="light blue")
dev.off()