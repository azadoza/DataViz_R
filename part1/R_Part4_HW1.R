library(tidyverse)
library(scales)
library(ggplot2)
gmcar_price <- read.delim("~gmcar_price.txt")
View(gmcar_price)
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))
