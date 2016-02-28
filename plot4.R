
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

coallabels<-unique(grep("coal", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))  
     

subdata<-subset(SCC, EI.Sector %in% coallabels)    #Subsetting SCC by coal labels
coal<-subset(NEI, SCC %in% subdata$SCC)        #Subsetting NEI by subdata overlaps
library(ggplot2)
png("plot4.png", width=640, height=480)

g<-ggplot(data=coal, aes(x=year, y=Emissions, fill = type)) + 
ylab(expression('Total PM'[2.5]*" Emissions"))+
  geom_bar(stat="identity", position=position_dodge()) + 
  ggtitle("U.S. Coal Combustion-Related Emissions: 1999-2008")
print(g)
dev.off()

