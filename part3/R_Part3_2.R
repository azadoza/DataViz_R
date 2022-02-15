library(leaflet) 
library(rgdal) 
library(dplyr) 
policeBeatShape <- readOGR("~/Police_Beat_Boundary_View-shp")
policeBeatShape@data$BEAT_OF_OCCURRENCE = as.integer(as.character(policeBeatShape@data$BEAT_NUMBE))
chicago_crashes <- read.csv("~/chicago_crashes.csv")

View(chicago_crashes)
summary(chicago_crashes$BEAT_OF_OCCURRENCE)
crashes.a <- chicago_crashes %>% 
  count(BEAT_OF_OCCURRENCE)

crash.map <- merge(policeBeatShape, crashes.a, 
                   by.x  = "BEAT_OF_OCCURRENCE", 
                   by.y="BEAT_OF_OCCURRENCE")
