# reading the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subseting to get Baltimore city emissions data
bc_data<-subset(NEI,fips=="24510")
#converting years from int to factors
bc_data$year <- factor(bc_data$year, levels=c('1999', '2002', '2005', '2008'))
#plottiing
library(ggplot2)
png(filename="./plot3.png",width=800,height=600)
ggplot(data=bc_data,aes(x=year,y=log(Emissions)))+facet_grid(.~type)+geom_boxplot(aes(fill=type))+ ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year')+ggtitle("Emissions per Type in Baltimore City, Maryland")+guides(fiil=F)
dev.off()
