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

# Plot3
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subSetData$Global_active_power)
subMetering1 <- as.numeric(subSetData$Sub_metering_1)
subMetering2 <- as.numeric(subSetData$Sub_metering_2)
subMetering3 <- as.numeric(subSetData$Sub_metering_3)

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="Red")
lines(datetime, subMetering3, type="l", col="Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# with(globalActivePower, {
    # plot(datetime, subMetering1, type="l",
         # ylab="Global Active Power (kilowatts)", xlab="")
    # lines(datetime, subMetering2,col='Red')
    # lines(datetime, subMetering3,col='Blue')
# })
# legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       # legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()