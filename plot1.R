library(lattice)
read.table(file="../household_power_consumption.txt", head=T,sep=";",na.strings="?",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))->d
cbind(d, "Time1"=strptime(paste(d$Date,d$Time), "%d/%m/%Y %X", tz="UTC"))->data
#names(d1)<-gsub("*", "_", names(d1))
d1<- subset(data, (Time1>=ymd("2007-02-01") & (Time1<ymd("2007-02-3"))))
#png(filename="plot1.png", width=480, height=480, units="px")
hist(d1$Global_active_power, col="red", ylim=c(0, 1200), main="Global active power", xlab="Global active power(kilowatts)")
plot(d1$Time1, d1$Global_active_power, type="l")
#xyplot()
#dev.off()
