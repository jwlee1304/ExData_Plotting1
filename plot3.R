# Load Libraries

# library('dplyr')
# library('ggplot2')
# library('reshape2')

# Get dataset from source
dataPath <- getwd()
dataURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(dataURL, file.path(dataPath, "household_power_consumption.zip"))
unzip(zipfile = "household_power_consumption.zip")


# Read data from file

data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ';')

# Subset data 
data <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')

# Convert to numeric features
ColNames <- names(data[3:9])
numericList <- c(ColNames)
data[, numericList] <- lapply(data[, numericList], function(x) as.numeric(as.character(x)))

# Merge date & time into single column
dateTime <- as.POSIXct(paste(data$Date, data$Time, sep = ";"), format = "%d/%m/%Y;%H:%M:%S")
data <- cbind("DateTime" = dateTime, data)
data$Date <- NULL
data$Time <- NULL
remove(dateTime)


# Plot graph and generate png file
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()