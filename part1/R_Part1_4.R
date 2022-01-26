library(tidyverse)
library(scales)
library(ggplot2)
library(treemapify)
library(viridis)
library(packcircles)

gmcar_price <- read.delim("~gmcar_price.txt")
View(gmcar_price)

## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))

## cleaning data
gmcar_price<- gmcar_price[colSums(!is.na(gmcar_price)) > 0]

######## A. Treemap ##########
 # making new dataframe with relevant info
df <- gmcar_price %>% 
  group_by(Make, Model)%>%
  summarise(Average_Price = mean(Price, na.rm=TRUE))

 # creating formating equation for plot clarity
format <- scales::dollar_format(accuracy = 1, big.mark = ",")

 # Treemap plot by make and model
ggplot(df, aes(area = Average_Price, fill = Average_Price, label = paste(Model, format(Average_Price), sep = "\n"), subgroup = Make, subgroup2 = Model)) + 
  geom_treemap() +
  labs(title = "Average Price of Recently Sold Car Make and Models")+
  geom_treemap_text(colour = "white", grow = FALSE, size = 10) +
  geom_treemap_subgroup_border(colour = "white", size = 5) +
  geom_treemap_subgroup_text(colour = "white", place = "bottom", grow = FALSE, alpha = 0.5) + 
  scale_fill_steps(low = "navy", high = "darkorange")

########## B. Packed Bubble ##########
theme_set(theme_bw() + 
            theme(panel.grid = element_blank(), 
                  axis.text=element_blank(),
                  axis.ticks=element_blank(), 
                  axis.title=element_blank(),
                  plot.title = element_text(hjust = 0.5)))

data <- cbind(df, circleProgressiveLayout(df$Average_Price, sizetype = c("area", "radius")))
data.paack <- circleLayoutVertices(circleProgressiveLayout(df$Average_Price, sizetype = c("area", "radius")))

##packed bubbles plot
ggplot() +
  geom_polygon(data = data.paack, aes(x,y, group = id, fill=-id), colour = "beige", show.legend = FALSE) +
  scale_fill_steps(low = "navy", high = "darkorange") +
  geom_text(data = data, aes(x, y, label = paste(Model, format(Average_Price), sep = "\n")), colour = "white", size = 3,fontface='bold')+
  labs(title = "Average Price of Recently Sold Cars")

#### this is for power BI ####
df$text <- format(df$Average_Price)
write.csv(df, file="gmcardf3.csv")
