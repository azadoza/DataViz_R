library(tidyverse)
library(scales)
library(ggplot2)
library(treemapify)

gmcar_price <- read.delim("~gmcar_price.txt")
View(gmcar_price)
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))
## cleaning data
gmcar_price<- gmcar_price[colSums(!is.na(gmcar_price)) > 0]
## A. Treemap
 # making new dataframe with relevant info
df <- gmcar_price %>% 
  group_by(Make, Model)%>%
  summarise(Average_Price = mean(Price, na.rm=TRUE))

ggplot(df, aes(area = Average_Price, fill = Average_Price, label = paste(Model, format(Average_Price), sep = "\n"), subgroup = Make, subgroup2 = Model)) + 
  geom_treemap() +
  labs(title = "Average Price of Recently Sold Car Make and Models")+
  geom_treemap_text(colour = "white", grow = FALSE, size = 10) +
  scale_fill_steps(low = "navy", high = "darkorange")