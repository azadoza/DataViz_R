View(InfantData1)
library(tidyverse)
library(ggplot2)
InfantData1 <- read.csv("~/InfantData1.csv")
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))
summary(InfantData1)