library(dplyr)
library(ggplot2)
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
