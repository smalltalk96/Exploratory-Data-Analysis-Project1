#library(lattice)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
powerdata <- read.table(unz(temp, "household_power_consumption.txt"), head=T,sep=";",na.strings="?",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
unlink(temp)

#read.table(file="../household_power_consumption.txt", head=T,sep=";",na.strings="?",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))->d
data<-cbind(powerdata, datetime=strptime(paste(powerdata$Date,powerdata$Time), "%d/%m/%Y %X", tz="UTC"))
#names(d1)<-gsub("*", "_", names(d1))
data<-subset(data, (datetime>=strptime("2007-02-01", "%Y-%m-%d", tz="UTC") & (datetime<strptime("2007-02-03", "%Y-%m-%d", tz="UTC"))))

png(filename="plot2.png", width=480, height=480, units="px")

with(data, {
  plot(datetime, Global_active_power, type="l")
})

dev.off()
