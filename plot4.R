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
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")

par(mfrow = c(2, 2))

# Add plot1 to top left
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Add plot2 to top right
plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Add plot3 to bottom left
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), bty = 'n', col = c("black", "red", "blue"))

# Add plot4 to bottom right
plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", lwd = 0.5)

dev.off()