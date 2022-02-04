library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(tidyquant)
theme_update(plot.title = element_text(hjust = 0.5, size = 13), 
             panel.background = element_blank(),
             plot.subtitle = element_text(size = 10),
             panel.grid.minor = element_blank())
View(PortlandWaterLevel2003)

PortlandWaterLevel2003$DateTime <- mdy_hm(paste(PortlandWaterLevel2003$Date,PortlandWaterLevel2003$Time, sep = ""))
#######################
########## A ##########
#######################
ggplot(PortlandWaterLevel2003, 
       aes(
         x= DateTime,
         y=WL)
       )+
  xlim(mdy_h(0101200321), mdy_h(0201200311))+
  geom_ma(color = "#2298aa", ma_fun = SMA, n=5, linetype=1, size=1.1)+
  labs(title = "Moving Average of Portland Water Levels Every Hour in January 2003", x= "Date", y="Water Level")

#######################
########## B ##########
#######################
library(ggTimeSeries)
PortlandWaterLevel2003$time2 <- gsub(":00","", perl = TRUE, PortlandWaterLevel2003$Time)
PortlandWaterLevel2003$time2 <- as.numeric(PortlandWaterLevel2003$time2)

ggplot_horizon(PortlandWaterLevel2003, 
               'Date', 
               'WL',
               vcGroupingColumnNames = 'time2',
               bandwidth = 1)+
     facet_grid(time2 ~ .)+
     scale_fill_continuous(low = "green", high = "red")+
     theme(legend.position = 'none') +
  labs(title = "Water Level in Portland Each Hour in 2003",
       y = "Hour",
       Color = "Water Level")
