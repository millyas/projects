# reading the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#convert year as factor
NEI$year<-factor(NEI$year,levels=c("1999","2002","2005","2008"))
#getting required data
data<-subset(NEI,fips=="24510" & type=="ON-ROAD")
data<-aggregate(data[,"Emissions"],by=list(data$year),FUN=sum)
names(data)<-c("year","Emissions")
#plotting
png(filename="./plot5.png")
library(ggplot2)
ggplot(data=data, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year),stat="identity") + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))
dev.off()