	#include dplyr, set up read of file	
	require(dplyr)
	fname <- "household_power_consumption.txt"
	df <- read.table(fname,header=TRUE,sep=';',colClasses = c("character","character",rep("numeric",7)),strip.white=TRUE,stringsAsFactors=FALSE,check.names=FALSE,encoding="UTF-8",comment.char='',na.strings='?')
	
	# modify and create time stamp column for day filter
	df$TimeStamp <- as.POSIXct(strptime(paste(df$Date,df$Time,sep=' '),format="%e/%m/%Y %H:%M:%S"),tz="UTC")
	
	# subset of two days
	power_days <- df %>% filter(TimeStamp >  as.POSIXct("2007-02-01",tz="UTC") & TimeStamp < as.POSIXct("2007-02-03",tz="UTC"))
	
	# histogram of overall power for 2 days
	hist(power_days$Global_active_power,breaks=15,col="red",border="black",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")
	
	# save histogram to png file
	dev.copy(png,file="plot1.png",height=480,width=480)
	dev.off()


	

