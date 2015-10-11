# Preparing the work directory
WD <- getwd()
dir_exdata <- "C:/Users/marcos.de.freitas/Git/ExData_Plotting1"
if ( WD != dir_exdata){
setwd(dir_exdata)
} 
getwd()

# Getting the data
if (!file.exists("./data/household_power_consumption.txt")){

	url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	file <- "exdata-data-household_power_consumption.zip"
	download.file(url, file)
	unzip(file, list = FALSE, overwrite = TRUE)

	my.file.rename <- function(from, to) {
		todir <- dirname(to)
		if (!isTRUE(file.info(todir)$isdir)) dir.create(todir, recursive=TRUE)
		file.rename(from = from,  to = to)
	}

	my.file.rename(from = "C:/Users/marcos.de.freitas/Git/ExData_Plotting1/household_power_consumption.txt", 
				   to =   "C:/Users/marcos.de.freitas/Git/ExData_Plotting1/data/household_power_consumption.txt")

}				   
dataFile <- "./data/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Plot4
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subSetData$Global_active_power)
globalReactivePower <- as.numeric(subSetData$Global_reactive_power)
voltage <- as.numeric(subSetData$Voltage)
subMetering1 <- as.numeric(subSetData$Sub_metering_1)
subMetering2 <- as.numeric(subSetData$Sub_metering_2)
subMetering3 <- as.numeric(subSetData$Sub_metering_3)

par(mfrow = c(2, 2)) 
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

# Saving file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()