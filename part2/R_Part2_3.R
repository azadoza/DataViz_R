library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5, size = 13), 
             panel.background = element_blank(),
             plot.subtitle = element_text(size = 10),
             panel.grid.minor = element_blank())

View(MontanaPopulationData)

######### A ###########
ggplot(MontanaPopulationData, aes(x=Year, y= Population))+
  geom_line(size=2, color = "#094780")+
  scale_y_continuous(trans = "log", breaks = pretty_breaks(), labels = scales::label_number_si())+
  scale_x_continuous(n.breaks = 12)+
  theme(panel.grid.minor = element_blank())+
  labs(title = "Population of Montana Every Ten Years from 1890 to 2000", subtitle = "Plotted Logarithmically to Display Population Doubling")

## 3b
 # change calculation 
MontanaPopulationData$PercentChange <- 
  (MontanaPopulationData$Population - lag(MontanaPopulationData$Population, 1))/
  lag(MontanaPopulationData$Population, 1) + 1
 # plot
ggplot(MontanaPopulationData, aes(x=Year, y=PercentChange))+
  geom_line(size=2.5, color = "#0D6ABF")+
  geom_point(size=2, color = "#0D6ABF")+
  scale_y_continuous(trans = "log", breaks = pretty_breaks(n=5),limits = c(.8, 2))+
  scale_x_continuous(n.breaks = 11, limits = c(1900, 2000))+
  labs(title = "Percent Population Change in Montana per Decade from 1890 to 2000",
       x= "Year",
       y= "Log Base10_ Percent Population Change")

