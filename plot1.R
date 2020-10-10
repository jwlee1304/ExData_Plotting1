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

# Plot graph and generate png file
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()