#install and load required packages
install.packages("sqldf")
library(sqldf)

#obtain the HPC data.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="hpc.zip", method="curl")
unzip("hpc.zip")

#read in the data corresponding to the required dates
hpcraw <- read.csv2.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header=T)

#create a DateTime column
DateTime <- strptime(paste(hpcraw$Date,hpcraw$Time),"%d/%m/%Y %H:%M:%S")

#use the new DateTime column to create the final dataset
hpc <- cbind(DateTime,hpcraw[,3:9])

#open png device
png(file="plot4.png")

#set number of plots to display
par(mfrow=c(2,2))

#PLOT1(top left)
plot(hpc$DateTime,hpc$Global_active_power,type="l", ylab="Global Active Power",xlab="")

#PLOT2 (top right)
plot(hpc$DateTime,hpc$Voltage,type="l", ylab="Voltage",xlab="datetime")

#PLOT3 (bottom left)
#construct plot with sub metering 1 data
plot(hpc$DateTime,hpc$Sub_metering_1,type="l", ylab="Energy sub metering",xlab="")
#add data for sub metering 2 and 3
points(hpc$DateTime,hpc$Sub_metering_2,type="l",col="red")
points(hpc$DateTime,hpc$Sub_metering_3,type="l",col="blue")

#add a legend
legend("topright", bty="n",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))

#PLOT4 (bottom right)
plot(hpc$DateTime,hpc$Global_reactive_power,type="l", ylab="Global_reactive_power",xlab="datetime")

#close device
dev.off()