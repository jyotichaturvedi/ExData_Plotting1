##Exploratory Data Analysis Project
##Author:Jyoti Chaturvedi
## The program downloads the files from the specified URL and draws line plot for the specified date range

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
#Create plot on device
png(file="plot2.png")
plot(datetime,dtSubSet$Global_active_power, ylab="Global Active Power (kilowatts)",xlab = "",type="l")
#Close the device
dev.off()