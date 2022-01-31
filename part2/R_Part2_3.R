library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))

View(MontanaPopulationData)
######### A ###########
ggplot(MontanaPopulationData, aes(x=Year, y= Population))+
  geom_line(size=2)+
  scale_y_continuous(trans = "log", labels = scales::label_number_si())+
  scale_x_continuous(n.breaks = 12)+
  theme(panel.grid.minor = element_blank())+
  labs(title = "Population of Montana Every Ten Years from 1890 to 2000", subtitle = "Plotted Logarithmically to Display Population Doubling")



