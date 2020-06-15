##########################################################

# Question 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

##########################################################

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get the subset for motor vehicles sourses in the Baltimore City and Los Angeles County
NEI.sub <- subset(NEI, fips %in% c("24510", "06037") & type=="ON-ROAD")

# create a png file
png(filename="plot6.png", width=480, height=480, units="px")

# draw a plot
library(ggplot2)
ggplot(NEI.sub, aes(x=year, y=Emissions, color=fips)) +
    stat_summary(fun.y = sum, geom="line") + 
    geom_point(stat='summary', fun.y=sum) + 
    labs(x="Year", y=expression(Total~PM[2.5]~Emissions~(tons)),
         title=expression(Total~PM[2.5]~Emissions~from~Motor~Vehicles~Sources)) +
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) +
    scale_colour_discrete(name="City", labels=c("Los Angeles County", "Baltimore City"))


# close the png file
dev.off()


##########################################################

# Los Angeles County has seen the greatest changes over time in motor vehicle emissions.

##########################################################