# reading the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subseting dataset based on "coal"
SCC_coal<-SCC[grepl("coal",SCC$EI.Sector,ignore.case=T),]
SCC_coal$SCC<-as.character(SCC_coal$SCC)
#merge the two 
data<-merge(NEI,SCC_coal,by="SCC")
finaldata<-aggregate(data[,4],by=list(data[,6]),FUN=sum)
#naming columns
names(finaldata)<-c("year","emissions")
#charting
library(ggplot2)
png(filename="./plot4.png",width=600,height=600)
ggplot(data=finaldata,aes(x=year,y=emissions))+geom_line(aes(group=1,col=emissions))+geom_point(aes(size=2,col=emissions))+ggtitle(expression('Total Emissions of PM'[2.5])) + 
        ylab(expression(paste('PM', ''[2.5], ' in kilo tons'))) + 
        geom_text(aes(label=round(emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
        theme(legend.position='none') + scale_colour_gradient(low='black', high='red')
dev.off()