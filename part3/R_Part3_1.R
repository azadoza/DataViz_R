library(ggplot2)
library(maps)
library(tidyverse)
library(mapproj)
library(choroplethrMaps)
# removing all the background in plot theme
theme_update(panel.background = element_blank(),
             plot.subtitle = element_text(size = 10),
             panel.grid.minor = element_blank())
# setting state and county long/lat maps
states <- map_data("state")
counties <- map_data("county")
# renaming the columns to something tolerable
colnames(FoodSrvcByCounty)[colnames(FoodSrvcByCounty) %in% c("FoodServices.97", "FoodServices.2002", "FoodServices.2007")] <- c("Food1997", "Food2002", "Food2007")
 # setting to same lowercase as in county data
FoodSrvcByCounty$County <- tolower(FoodSrvcByCounty$County)
 # Left join to create FoodMapState and County sets
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
        plot.title = element_text(hjust = 0.5, size = 15))+
  labs(title = "Availability of Food Services by State in 2007")

## there's counties without state info so I'm just...DELETE
df <- filter(FoodSrvcByCounty, State != "")
 # now
FoodMapCounty <- left_join(counties, df, by = c("subregion" = "County"))
 # Plot
ggplot(FoodMapCounty,
       aes(
         x= long, 
         y= lat, 
         group = group, 
         fill = (Food2007))
         )+
  geom_polygon(color = "grey50", size = .5) +
  coord_map("polyconic")+
  scale_fill_continuous(low = "#183537", high = "#72e5ef", 
                        name = "Food Services", 
                        trans = "log10")+
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 15))+
  labs(title = "Availability of Food Services by County in 2007")+
  expand_limits(x = fifty_states$long, y = fifty_states$lat)
