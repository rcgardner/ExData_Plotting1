	#include dplyr, set up read of file	
	require(dplyr)
	fname <- "household_power_consumption.txt"
	df <- read.table(fname,header=TRUE,sep=';',colClasses = c("character","character",rep("numeric",7)),strip.white=TRUE,stringsAsFactors=FALSE,check.names=FALSE,encoding="UTF-8",comment.char='',na.strings='?')
	
	# modify and create time stamp column for day filter
	df$TimeStamp <- as.POSIXct(strptime(paste(df$Date,df$Time,sep=' '),format="%e/%m/%Y %H:%M:%S"),tz="UTC")
	
	# subset of two days
	power_days <- df %>% filter(TimeStamp >  as.POSIXct("2007-02-01",tz="UTC") & TimeStamp < as.POSIXct("2007-02-03",tz="UTC"))

	# array of 2x2 plots for 4 total, various parameters, for 2 days
	par(mfrow = c(2,2))

	# line plot of overall power for 2 days
	plot(power_days$TimeStamp,power_days$Global_active_power,type="l",ylab="Global Active Power",xlab="")
	
	# line plot of voltage for 2 days
	plot(power_days$TimeStamp,power_days$Voltage,type="l",ylab="Voltage",xlab="datetime")

	# line plots of submetered power for 2 days
	plot(power_days$TimeStamp,power_days$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
	lines(power_days$TimeStamp,power_days$Sub_metering_1,col="black")
	lines(power_days$TimeStamp,power_days$Sub_metering_2,col="red")
	lines(power_days$TimeStamp,power_days$Sub_metering_3,col="blue")
	legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, seg.len = 2, bty = "n")

	# line plot of reactive power for 2 days
	plot(power_days$TimeStamp,power_days$Global_reactive_power,type="l",ylab="Global_rective_power",xlab="datetime")

	# save line plot to png file
	dev.copy(png,file="plot4.png",height=480,width=480)
	dev.off()

	

