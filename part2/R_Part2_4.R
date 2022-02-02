library(dplyr)
library(ggplot2)
library(scales)
library(viridis)
View(MessierData)
theme_update(plot.title = element_text(hjust = 0.5, size = 13), 
             panel.background = element_blank(),
             plot.subtitle = element_text(size = 10),
             panel.grid.minor = element_blank())
