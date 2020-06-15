##########################################################

# Question 2

# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

##########################################################

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get a subset for the Baltimore City, Maryland (fips == "24510")
NEI.sub <- subset(NEI, fips == "24510")

# calculate the total emissions
library(plyr)
total.emi <- ddply(NEI.sub, .(year), summarise, totalemi=sum(Emissions))

# create a png file
png(filename="plot2.png", width=480, height=480, units="px")

# draw a plot
with(total.emi, 
     plot(totalemi, type="b", xlab="Year", xaxt="n",
          ylab=expression(Total~PM[2.5]~Emissions~(tons)), 
          main=expression(Total~PM[2.5]~Emissions~`in`~the~Baltimore~City)))
axis(1, at=c(1:4), labels=c("1999", "2002", "2005", "2008"))

# close the png file
dev.off()



##########################################################

# Total emissions from PM2.5 have decreased in the Baltimore City, Maryland from 1999 to 2002,
# and from 2005 to 2008. But it increased from 2002 to 2005.

##########################################################