NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

totalNEI<-tapply(NEI$Emissions, INDEX=NEI$year, sum)
png(filename='plot1.png')
barplot(totalNEI, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()