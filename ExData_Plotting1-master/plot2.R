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

#plot2 - Global Active Power per week day
png(filename = "./Project/plot2.png", bg = "transparent")
  plot(electricConsumption$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
  axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(electricConsumption$Date)=="Friday")[1], nrow(electricConsumption)+1))
dev.off()
