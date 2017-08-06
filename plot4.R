library(lubridate)
library(anytime)
library(dplyr)
library(utils)

#Read and prepare the data 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
path=paste0(getwd(),"/","household_power_consumption.zip")
power_consumption<-unzip(path)

power<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

power$Date <- as.Date(as.character(power$Date),"%d/%m/%Y")

power_sub<-filter(power,power$Date == "2007-02-01" | power$Date == "2007-02-02")

power_sub4 = mutate(power_sub,date2=paste(power_sub$Date,power_sub$Time))

power_sub4$date2 = strptime(power_sub4$date2,"%Y-%m-%d %H:%M:%S")

power_sub4$Global_active_power=as.numeric(power_sub4$Global_active_power)

power_sub4$Global_reactive_power=as.numeric(power_sub4$Global_reactive_power)


#Let us now get the 4th plot 
png(filename="plot4.png",width=480,height=480)
par(mfrow=c(2,2))

plot(power_sub4$date2,power_sub4$Global_active_power/1000,type="l",ylab="Global Active Power (kilowatts)",xlab="")

plot(power_sub4$date2,power_sub4$Voltage,ylab="Voltage",xlab="datetime",type="l")

plot(power_sub4$date2,power_sub4$Sub_metering_1,type="n",ylab="Energy Sub Metering", xlab="")
points(power_sub4$date2,power_sub4$Sub_metering_1,col="black",type="l")
points(power_sub4$date2,power_sub4$Sub_metering_2,col="red",type="l")
points(power_sub4$date2,power_sub4$Sub_metering_3,col="blue",type="l")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"),pch="-",lty=1,bty="n")

power_sub4$Global_reactive_power = as.numeric(power_sub4$Global_reactive_power)
plot(power_sub4$date2, power_sub4$Global_reactive_power/1000,ylab="Global_reactive_power",xlab="datetime",type="l")

dev.off()

