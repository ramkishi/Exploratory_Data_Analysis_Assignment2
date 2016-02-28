NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
		
baltimore<-subset(NEI, NEI$fips==24510)           #Subsettting Baltimore region
totalBaltimore<-tapply(baltimore$Emissions, baltimore$year, sum)   #Summing emissions per year
png(filename='plot2.png')
barplot(totalBaltimore, main=expression("Total Emissions in Baltimore, MD by Year"), xlab="Year", ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()