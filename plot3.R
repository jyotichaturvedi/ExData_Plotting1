##Exploratory Data Analysis Project
##Author:Jyoti Chaturvedi
## The program downloads the files from the specified URL and draws line plots for the specified date range

#Download file from specified URL
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localFileName<-"./power_consumption_dataset.zip"
# Check if does not exists, download the file
if (file.exists(localFileName) == FALSE) {
  download.file(fileURL, destfile = localFileName)
}

# Variable for uncompressed folder name
dataFileDir<-"./household_power_consumption.txt"
# Uncompress the zip file
if (file.exists(dataFileDir) == FALSE) {
  unzip(localFileName)
}
#Create dataset,remove incomplete records
dtConsumption<-read.table(dataFileDir,header=TRUE,sep=";",dec=".",stringsAsFactors=FALSE,na.strings = "?")
#Create subset of the data for specified date range
dtSubSet<-dtConsumption[dtConsumption$Date %in% c("1/2/2007","2/2/2007") ,]
#Combine date and time so variation can be plotted within a day
datetime <- strptime(paste(dtSubSet$Date, dtSubSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
#Create plot on screen
plot(datetime,dtSubSet$Sub_metering_1,type="l", ylab = "Energy Sub metering", xlab = "")
lines(datetime,dtSubSet$Sub_metering_2,type="l", ylab = "Energy Submetering",col="red")
lines(datetime,dtSubSet$Sub_metering_3,type="l", ylab = "Energy Submetering",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
#Copy the plot to png file
dev.copy(png,file="plot3.png")
#Close the device
dev.off()