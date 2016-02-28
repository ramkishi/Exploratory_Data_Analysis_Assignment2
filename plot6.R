NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
		
baltimore<-subset(NEI, NEI$fips==24510)           #Subsetting Baltimore region
LA<-subset(NEI, NEI$fips=="06037") 
library(ggplot2)
png("plot6.png", width=640, height=480)
greps2<-unique(grep("mobile", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))
gasLight<-SCC[SCC$EI.Sector %in% greps2[1],]
gasHeavy<-SCC[SCC$EI.Sector %in% greps2[2],]
dieselLight<-SCC[SCC$EI.Sector %in% greps2[3],]
dieselHeavy<-SCC[SCC$EI.Sector %in% greps2[4],]

BMgasHeavy<-subset(baltimore, SCC %in% gasHeavy$SCC)   #Subsetting Baltimore by SCC retaining vehicle type 
BMgasLight<-subset(baltimore, SCC %in% gasLight$SCC)
BMdieselLight<-subset(baltimore, SCC %in% dieselLight$SCC)
BMdieselHeavy<-subset(baltimore, SCC %in% dieselHeavy$SCC)

BMcars1<-data.frame(BMgasHeavy, vehicle="Gas - Heavy Duty")      #Adding vehicle type column to NEI 
BMcars2<-data.frame(BMgasLight, vehicle="Gas - Light Duty")
BMcars3<-data.frame(BMdieselLight, vehicle="Diesel - Light Duty")
BMcars4<-data.frame(BMdieselHeavy, vehicle="Diesel - Heavy Duty")
BMcars<-rbind(BMcars1, BMcars2, BMcars3, BMcars4) 

LAgasHeavy<-subset(LA, SCC %in% gasHeavy$SCC)   #Subsettting Baltimore by SCC retaining vehicle type 
LAgasLight<-subset(LA, SCC %in% gasLight$SCC)
LAdieselLight<-subset(LA, SCC %in% dieselLight$SCC)
LAdieselHeavy<-subset(LA, SCC %in% dieselHeavy$SCC)

LAcars1<-data.frame(LAgasHeavy, vehicle="Gas - Heavy Duty")      #Adding vehicle type column to NEI 
LAcars2<-data.frame(LAgasLight, vehicle="Gas - Light Duty")
LAcars3<-data.frame(LAdieselLight, vehicle="Diesel - Light Duty")
LAcars4<-data.frame(LAdieselHeavy, vehicle="Diesel - Heavy Duty")
carsALL<-rbind(BMcars, LAcars1, LAcars2, LAcars3, LAcars4) 
carsALL$fips<-gsub("24510", "Baltimore", carsALL$fips)     #Replacing fips with city names
carsALL$fips<-gsub("06037", "Los Angeles", carsALL$fips)

ggplot(data=carsALL, aes(x=year, y=Emissions, fill=vehicle)) + facet_grid(.~fips) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle(expression(atop("Two City Motor-Vehicle Emission Comparison", 
                      atop(italic("Baltimore, MD and Los Angeles, CA: 1999-2008")))))
                      
dev.off()
  

