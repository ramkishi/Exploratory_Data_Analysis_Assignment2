NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

		
baltimore<-subset(NEI, NEI$fips==24510)           #Subset Baltimore area

#First we subset the motor vehicles which operate on roads (hopefully this includes neighborhood roads and highways). For the purpose of this project, I assume only the following motor vehicles in this analysis:

#Mobile - On-road - Diesel Light Duty Vehicles
#Mobile - On-road - Diesel Heavy Duty Vehicles
#Mobile - On-road - Gasoline Heavy Duty Vehicles
#Mobile - On-road - Gasoline Light Duty Vehicles


library(ggplot2)
png("plot5.png", width=640, height=480)



greps2<-unique(grep("mobile", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))  
  
gasLight<-SCC[SCC$EI.Sector %in% greps2[1],]
gasHeavy<-SCC[SCC$EI.Sector %in% greps2[2],]
dieselLight<-SCC[SCC$EI.Sector %in% greps2[3],]
dieselHeavy<-SCC[SCC$EI.Sector %in% greps2[4],]

BMgasHeavy<-subset(baltimore, SCC %in% gasHeavy$SCC)   #Subset Baltimore by SCC retaining vehicle type 
BMgasLight<-subset(baltimore, SCC %in% gasLight$SCC)
BMdieselLight<-subset(baltimore, SCC %in% dieselLight$SCC)
BMdieselHeavy<-subset(baltimore, SCC %in% dieselHeavy$SCC)

BMcars1<-data.frame(BMgasHeavy, vehicle="Gas - Heavy Duty")      #Add vehicle type column to NEI 
BMcars2<-data.frame(BMgasLight, vehicle="Gas - Light Duty")
BMcars3<-data.frame(BMdieselLight, vehicle="Diesel - Light Duty")
BMcars4<-data.frame(BMdieselHeavy, vehicle="Diesel - Heavy Duty")
BMcars<-rbind(BMcars1, BMcars2, BMcars3, BMcars4)  
BMcars$fips<-gsub("24510", "Baltimore", BMcars$fips) 
g<-ggplot(data=BMcars, aes(x=year, y=Emissions, fill=vehicle)) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle("Motor Vehicle-Related Emissions in Baltimore, MD: 1999-2008")

  print(g)
dev.off()  
  

