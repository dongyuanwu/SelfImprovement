##########################################################

# Question 3

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999¨C2008 for Baltimore City? 
# Which have seen increases in emissions from 1999¨C2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

##########################################################

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get a subset for the Baltimore City, Maryland (fips == "24510")
NEI.sub <- subset(NEI, fips == "24510")

# create a png file
png(filename="plot3.png", width=480, height=480, units="px")

# draw a plot
library(ggplot2)
ggplot(NEI.sub, aes(x=year, y=Emissions, color=type)) +
    stat_summary(fun.y=sum, geom="line") + 
    geom_point(stat='summary', fun.y=sum) +
    labs(x="Year", y=expression(Total~PM[2.5]~Emissions~(tons)),
         title=expression(Total~PM[2.5]~Emissions~`in`~the~Baltimore~City)) +
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))


# close the png file
dev.off()


##########################################################

# Emissions of non-road, nonpoint, on-road types of sources have seen decreases
# from 1999-2008 for Baltimore City. Emissions of point type of sources have seen
# increases from 1999-2005, but also decreases after 2005.

##########################################################
