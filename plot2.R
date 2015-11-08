## Reading and transforming data

if (!file.exists("./Assignment/household_power_consumption.txt")) {
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./Assignment/power_data.zip", method = "wget")
    unzip("./Assignment/power_data.zip", overwrite = T, exdir = "./Assignment")
}

file_path<-"./Assignment/household_power_consumption.txt"

elec_data <- read.table(file_path, header=T, sep=";")

elec_data$Date <- as.Date(elec_data$Date, format="%d/%m/%Y")

## Selecting only the Feb 1 and Feb 2 data

data <- elec_data[(elec_data$Date=="2007-02-01") | (elec_data$Date=="2007-02-02"),]

## Format conversion to Numeric for plot and display

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))


## Transforming date and time fieild

data <- transform(data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## Plot 1 code
plot1 <- function() {
        hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        cat("Plot1.png saved in", getwd())
}

plot1()
