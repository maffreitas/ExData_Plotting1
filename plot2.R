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

# Plot2
datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subSetData$Global_active_power)
plot(datetime, globalActivePower, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# Saving file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()