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


#Second Plot 
png(filename="plot2.png",width=480,height=480)
plot(power_sub4$date2,power_sub4$Global_active_power/1000,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
