library(ggplot2)
library(leaflet) 
library(rgdal) 
library(dplyr)

#Shapefile
policeBeatShape <- readOGR("~/Police_Beat_Boundary_View-shp")
policeBeatShape@data$BEAT_OF_OCCURRENCE = as.integer(as.character(policeBeatShape@data$BEAT_NUMBE))

# CSV with beat info
chicago_crashes <- read.csv("~/chicago_crashes.csv")
View(chicago_crashes)

## This shows us a bit about all accidents
 # No NA or invalid data shows up in summary,
 # no need for data cleanup
summary(chicago_crashes$BEAT_OF_OCCURRENCE)

## Aggregation 
 # gives simple df that shows how many crashes occured per beat
crashes.a <- chicago_crashes %>% 
  count(BEAT_OF_OCCURRENCE)

## Adding the counts to the shapefile into new crash.map df
crash.map <- merge(policeBeatShape, crashes.a, 
                   by.x  = "BEAT_OF_OCCURRENCE", 
                   by.y="BEAT_OF_OCCURRENCE")

## Map Plot
#### PLOT A. WITH MAP DETAILS ####
leaflet(crash.map) %>%
  addTiles() %>%  
  addPolygons(weight = 1, 
              smoothFactor = 0.5,
              color = ~pal(n),    
              opacity = 1.0, 
              fillOpacity = .8,
              )
#### PLOT B WITHOUT MAP DETAILS ####
leaflet(crash.map) %>%
  addPolygons(weight = 1, smoothFactor = 0.5,
              color = ~pal(n),    
              opacity = 1.0, fillOpacity = 0.5)
