library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(bdscale)

theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))

## Cleaning up Data, fixing date
Intel1990.20001$Date <- (mdy(Intel1990.20001$Date))
## 1a Date v Adj Close w/ Volume
ggplot(Intel1990.20001, aes(x = Date, y = Adj.Close, size = Volume))+
  geom_line(color = "80c3b5")+
  scale_y_continuous(labels=scales::dollar_format(), 
                     expand = c(0, 0), 
                     limits = c(0, 60))+
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  labs(title = "Adjusted Close Value and Volume of Intel per Day from 1900 to 2001", 
       x = "Date", 
       y = "Adjusted Close Value") 

## 1b Date v Adj Close w/ Volume
ggplot(Intel1990.20001, aes(x = Date, y = Adj.Close, color = Volume))+
  geom_line(size=2)+
  scale_x_bd(business.dates = nyse, labels=date_format('%Y'))+
  scale_y_continuous(labels=scales::dollar_format(), 
                     expand = c(0, 0), 
                     limits = c(0, 60)) +
  labs(title = "Adjusted Close Value and Volume of Intel per Day from 1900 to 2001", 
       x = "Date", 
       y = "Adjusted Close Value") +
  scale_color_gradient(low = "#80c3b5", high = "#7e2640")

## 1c LOG
ggplot(Intel1990.20001, aes(x = Date, y = Adj.Close, color = Volume))+
  geom_line(size=2)+
  scale_x_bd(business.dates = nyse, labels=date_format('%Y'))+
  scale_y_continuous(trans = "log", breaks = extended_breaks()(1:60), labels=scales::dollar_format())+
  scale_color_gradient(low = "#80c3b5", high = "#7e2640")+
  labs(title = "Adjusted Close Value and Volume of Intel per Day from 1900 to 2001", 
       x = "Date", 
       y = "Log Base 10 Adjusted Close Value")

## 1d log..2!!
 # first doing some grouping with lubridate
Intel1990.20001$Year <- floor_date(df$Date, "year")
df <- Intel1990.20001 %>% group_by(Year) %>% summarise(mean = mean(Adj.Close))
df2 <- Intel1990.20001 %>% group_by(Year) %>% summarise(sum = sum(Volume))
df$Volume <- df2$sum

ggplot(df, aes(x = Year, y = mean, color = Volume))+
  geom_line(size=2)+
  scale_x_date(date_breaks = "1 year", date_labels = "%Y")+
  scale_y_continuous(trans = "log", breaks = extended_breaks(), labels=scales::dollar_format())+
  scale_color_gradient(low = "#80c3b5", high = "#7e2640", name = "Total Volume\n(Billions)",labels = scales::label_number_si())+
  labs(title = "Average Close Value and Total Volume of Intel \nPer Year, 1900 to 2001", 
       x = "Date", 
       y = "Log Base 10 Adjusted Close Value")