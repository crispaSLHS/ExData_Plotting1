################################################################################
#
# Author:       	Andrew Crisp
# Filename: 			plot3.R
# Comments:			  
#						      This script will:
#  					      1. Check for and acquire the dataset as necessary.
#  					      2. Sanitize the data.
#                 3. Build the graphic.
#  					      4. Write the graphic to file.
#    				      
################################################################################
################################################################################
### Load dataset
################################################################################
if(!file.exists("household_power_consumption")){
  if(!file.exists("exdata-data-household_power_consumption.zip")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destFile <- "exdata-data-household_power_consumption.zip"
    download.file(url=fileUrl, destfile=destFile)
  }
  unzip("exdata-data-household_power_consumption.zip")
}

################################################################################
### Sanitize data
################################################################################
household_power_consumption<-read.table(file="household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",nrows=2075259,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
household_power_consumption$Date <- as.Date(x = household_power_consumption$Date, format = "%d/%m/%Y")

daysOfInterest <- subset(household_power_consumption, Date=="2007-02-01"|Date=="2007-02-02")
daysOfInterest$DateTime <- paste(daysOfInterest$Date,daysOfInterest$Time)
daysOfInterest$DateTime <- strptime(x = daysOfInterest$DateTime, format = "%Y-%m-%d %H:%M:%S")

################################################################################
### Draw graphic
################################################################################
png("plot3.png", width=480, height=480)
plot(daysOfInterest$DateTime,daysOfInterest$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = "")
points(daysOfInterest$DateTime,daysOfInterest$Sub_metering_1, col="black", type="l")
points(daysOfInterest$DateTime,daysOfInterest$Sub_metering_2, col="red", type="l")
points(daysOfInterest$DateTime,daysOfInterest$Sub_metering_3, col="blue", type="l")
legend("topright", col=c("black", "red", "blue"), lty=1,legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

################################################################################
### Write to file
################################################################################
dev.off()