# download file, unzip and load into data frame
temp <- tempfile()
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', temp, 'curl')
df <- read.table(unz(temp, 'household_power_consumption.txt'), header = T, sep = ';', na.strings = '?')
unlink(temp)

png('plot3.png')

# filter data frame and plot to screen
df$Date <- as.Date(df$Date, '%d/%m/%Y')
df <- df[df$Date %in% as.Date(c('2007-02-01', '2007-02-02')), ]
df$datetime <- strptime(paste(df$Date, df$Time), '%Y-%m-%d %H:%M:%S')
with(df, {
        plot(datetime, Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
        points(datetime, Sub_metering_2, type = 'l', col = 'red')
        points(datetime, Sub_metering_3, type = 'l', col = 'blue')
})
legend('topright', lty = 'solid', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

dev.off()