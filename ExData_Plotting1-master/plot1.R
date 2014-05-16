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

#plot1 - Global Active Power
png(filename = "./Project/plot1.png", bg = "transparent")
  hist(electricConsumption$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
