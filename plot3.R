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

## Plot 3 code

plot3 <- function() {
        plot(data$timestamp,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(data$timestamp,data$Sub_metering_2,col="red")
        lines(data$timestamp,data$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
        dev.copy(png, file="plot3.png", width=480, height=480)
        dev.off()
        cat("plot3.png saved in", getwd())
}
plot3()
