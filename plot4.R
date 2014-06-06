#library(lattice)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
powerdata <- read.table(unz(temp, "household_power_consumption.txt"), head=T,sep=";",na.strings="?",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
unlink(temp)

#read.table(file="../household_power_consumption.txt", head=T,sep=";",na.strings="?",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))->d
data<-cbind(powerdata, datetime=strptime(paste(powerdata$Date,powerdata$Time), "%d/%m/%Y %X", tz="UTC"))
#names(d1)<-gsub("*", "_", names(d1))
data<-subset(data, (datetime>=strptime("2007-02-01", "%Y-%m-%d", tz="UTC") & (datetime<strptime("2007-02-03", "%Y-%m-%d", tz="UTC"))))

png(filename="plot4.png", width=480, height=480, units="px")

with(data, {
  #plot1
  hist(Global_active_power, col="red", ylim=c(0, 1200), main="Global active power", xlab="Global active power(kilowatts)")
  #plot2
  #plot(d1$datetime, d1$Global_active_power, type="l")
  #plot3/4
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  plot(datetime, Global_active_power, type="l")
  plot(datetime, Voltage, type="l")
  plot(datetime, Sub_metering_1, type="l", col="black")
  lines(datetime, Sub_metering_2, type="l", col="red")
  lines(datetime, Sub_metering_3, type="l", col="blue")
  legend(x = "topright",  
         bty = "n",  
         y.intersp = 1,  
         #xjust = 0,  
         #inset = 0.07,   
         #yjust = 1,  
         
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),   
         lty=c(1, 1, 1),   
         lwd=c(2.5, 2.5, 2.5),  
         col=c("black", "red", "blue")  
         #pt.cex=5,  
         #cex=1  
  )
  plot(datetime, Global_reactive_power, type="l")
  #xyplot()
})

dev.off()
