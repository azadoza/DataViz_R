library(tidyverse)
library(lubridate)
library(ggplot2)
## first: cleaning up data
Intel.1998$Date <- (mdy(Intel.1998$Date))

## A. line graph
plot((Intel.1998$Date), Intel.1998$Close, type = "l", main = "Closing Price of Intel per Day (1998)", ylab = "Price", xlab = "Date")

## B. bar graph
ggplot(data = Intel.1998, aes(x=Date, y=Volume)) + geom_bar(stat = "identity", width = 1) + 
  theme_bw(base_size = 12) + labs(title = "Volume of Intel per Day in 1998", x = "Date", y = "Volume") + 
  scale_y_continuous(labels = scales::label_number_si()) + scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  theme(plot.title = element_text(hjust = 0.5))

## C. histogram
ggplot(Intel.1998, aes(x=Volume)) + geom_histogram(bins = 25, color = "PINK") + 
  scale_x_continuous(labels = scales::label_number_si()) + 
  labs(title = "Frequency of Daily Volume, Intel 1998", y = "Occurances")

## D. scatterplot
Intel.1998$HighLowRange <- (Intel.1998$High - Intel.1998$Low)
ggplot(Intel.1998, aes(x=Volume, y=HighLowRange)) + geom_point(shape=16) + 
  scale_x_continuous(labels = scales::label_number_si()) + scale_y_continuous(labels=scales::dollar_format()) + 
  labs(title = "Daily Price Range vs Volume of Intel (1998)", y = "Price Range")
