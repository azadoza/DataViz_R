library(ggplot2)
library(maps)
library(tidyverse)
library(mapproj)
library(choroplethrMaps)
theme_update(panel.background = element_blank(),
             plot.subtitle = element_text(size = 10),
             panel.grid.minor = element_blank())
states <- map_data("state")
counties <- map_data("county")
colnames(FoodSrvcByCounty)[colnames(FoodSrvcByCounty) %in% c("FoodServices.97", "FoodServices.2002", "FoodServices.2007")] <- c("Food1997", "Food2002", "Food2007")
FoodSrvcByCounty$County <- tolower(FoodSrvcByCounty$County)
FoodMapState <- left_join(states, FoodSrvcByCounty, by = c("region" = "County"))
ggplot(FoodMapState,
       aes(
         x= long, 
         y= lat, 
         group = group, 
         fill = Food2007)
       )+
  geom_polygon(color = "black") +
  coord_map("polyconic")+
  scale_fill_continuous(low = "#183537", high = "#72e5ef", 
                        name = "Food Services", labels = scales::label_number_si())+
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 15)) +
  labs(title = "Availability of Food Services by State in 2007")
