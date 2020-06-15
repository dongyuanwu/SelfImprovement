##########################################################

# Question 1

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

##########################################################

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# calculate the total emissions
library(plyr)
total.emi <- ddply(NEI, .(year), summarise, totalemi=sum(Emissions))

# create a png file
png(filename="plot1.png", width=480, height=480, units="px")

# draw a plot
with(total.emi, 
     plot(totalemi, type="b", xlab="Year", xaxt="n",
          ylab=expression(Total~PM[2.5]~Emissions~(tons)), 
          main=expression(Total~PM[2.5]~Emissions~`in`~the~United~States)))
axis(1, at=c(1:4), labels=c("1999", "2002", "2005", "2008"))

# close the png file
dev.off()


##########################################################

# Total emissions from PM2.5 have decreased in the United States from 1999 to 2008.

##########################################################