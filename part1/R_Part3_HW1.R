View(InfantData1)
library(tidyverse)
library(scales)
library(ggplot2)
InfantData1 <- read.csv("~/InfantData1.csv")
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))
summary(InfantData1)
#scatterplot
ggplot(InfantData1, aes(HeightIn, WeightLbs, color = factor(Sex))) + 
  geom_point() +
  scale_x_continuous(expand = c(0, 0), limits = c(13, 25))  +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 12), labels = unit_format(unit = "lbs", scale = 1))

