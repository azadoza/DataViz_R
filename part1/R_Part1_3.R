View(InfantData1)
library(tidyverse)
library(scales)
library(ggplot2)
InfantData1 <- read.csv("~/InfantData1.csv")
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))

## 1 M/F scatterplot
ggplot(InfantData1, aes(HeightIn, WeightLbs, color = factor(Sex))) + 
  geom_point() +
  labs(x= "Height (in)", y="Weight", colour= "Gender", title = "Height vs Weight in Male and Female Infants" ) +
  scale_x_continuous(expand = c(0, 0), limits = c(13, 25))  +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 12), labels = unit_format(unit = "lbs", scale = 1))

summary(InfantData1)
#------------------------------
## 2 Tread
ggplot(InfantData1, aes(HeightIn, WeightLbs, color = factor(Sex), )) + 
  geom_point(size = 3) + 
  scale_color_manual(values = c("F" = "palevioletred1", "M"="Turquoise3")) +
  geom_smooth(method = "lm", formula = "y~x", se=FALSE, size = 1.2) + 
  labs(x= "Height (in)", y="Weight (lbs)", colour= "Gender",  title = "Height vs Weight in Male vs Female Infants" ) + 
  scale_x_continuous(expand = c(0, 0), limits = c(13, 26)) +  
  scale_y_continuous(expand = c(0, 0), limits = c(0, 12))
#------------------------------
