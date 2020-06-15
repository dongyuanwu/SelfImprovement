##########################################################

# Question 4

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999¨C2008?

##########################################################

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find the coal combustion-related code
coal.scc <- SCC$SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE)]

# get the subset for coal combustion-related sources
NEI.sub <- subset(NEI, SCC %in% coal.scc)

# create a png file
png(filename="plot4.png", width=480, height=480, units="px")

# draw a plot
library(ggplot2)
ggplot(NEI.sub, aes(x=year, y=Emissions)) +
    stat_summary(fun.y = sum, geom="line") + 
    geom_point(stat='summary', fun.y=sum) + 
    labs(x="Year", y=expression(Total~PM[2.5]~Emissions~(tons)),
         title=expression(Total~PM[2.5]~Emissions~from~Coal~Combustion~`-`~Related~Sources)) +
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) +
    scale_y_continuous(limits=c(0, 650000))


# close the png file
dev.off()


##########################################################

# Emissions from coal combustion-related sources have decreased from 1999-2008.

##########################################################