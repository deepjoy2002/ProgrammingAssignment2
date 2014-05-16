# read header and get data rows. Data should be in a folder named "Project" in the working directory
colsText <- readLines("./Project/household_power_consumption.txt", n=1)
rowsData <- grep("^1/2/2007|^2/2/2007", readLines("./Project/household_power_consumption.txt", n=2075259))

# read data in selection (identified in rowsData) and name columns
electricConsumption <- read.table("./Project/household_power_consumption.txt", 
                                  header=F, sep=";", na.strings="?", 
                                  skip=rowsData[1]-1, nrows=length(rowsData),
                                  colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
names(electricConsumption) <- unlist(strsplit(colsText, ";", fixed=T))

#clean up variables
rm(colsText, rowsData)
electricConsumption$Date <- as.Date(electricConsumption$Date, format="%d/%m/%Y")

#plot4 - set of graphs
png(filename = "./Project/plot4.png", bg = "transparent")
  par(mfrow = c(2, 2))
  plot(electricConsumption$Global_active_power, type="l", ylab="Global Active Power", xlab="", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(electricConsumption$Date)=="Friday")[1], nrow(electricConsumption)+1))

  plot(electricConsumption$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(electricConsumption$Date)=="Friday")[1], nrow(electricConsumption)+1))

  plot(electricConsumption$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="", xaxt="n")
  lines(electricConsumption$Sub_metering_1)
  lines(electricConsumption$Sub_metering_2, col="red")
  lines(electricConsumption$Sub_metering_3, col="blue")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(electricConsumption$Date)=="Friday")[1], nrow(electricConsumption)+1))
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

  plot(electricConsumption$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(electricConsumption$Date)=="Friday")[1], nrow(electricConsumption)+1))
dev.off()