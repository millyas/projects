# reading the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#convert year as factor
NEI$year<-factor(NEI$year,levels=c("1999","2002","2005","2008"))
#data for baltimore and losangeles
bc_onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
la_onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')
#aggregation
bc_data <- aggregate(bc_onroad[, 'Emissions'], by=list(bc_onroad$year), sum)
names(bc_data) <- c('year', 'Emissions')
#add city column
bc_data$city<-rep("bc",4)
la_data <- aggregate(la_onroad[, 'Emissions'], by=list(la_onroad$year), sum)
names(la_data) <- c('year', 'Emissions')
#add city column
la_data$city<-rep("la",4)
#merge data
final_data<-rbind(bc_data,la_data)
final_data$city<-as.factor(final_data$city)
#plotting
library(ggplot2)
png(filename="./plot6.png")
ggplot(data=final_data, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year),stat="identity") + guides(fill=F)+facet_grid(.~city,drop=F)+
        ylab(expression('PM'[2.5])) + xlab('Year')+theme(legend.position='none')+geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))+
        ggtitle("Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland")
dev.off()



