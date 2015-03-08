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
png(file="plot2.png")

#construct plot
plot(hpc$DateTime,hpc$Global_active_power,type="l", ylab="Global Active Power (kilowatts)",xlab="")

#close device
dev.off()