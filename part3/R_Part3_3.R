library(dplyr)
library(ggplot2)
library(magrittr)
library(scales)
library(ggbeeswarm)

theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))

## Cleaning up data
AirQuality <- na.omit(AirQuality)
WindSolarAirQuality <- AirQuality %$% data.frame(wind = sort(Wind), solar= sort(Solar.R))

###############
##### B. ######
###############
ggplot(WindSolarAirQuality, aes(wind, solar)) + 
  geom_point(color="#5a6cb1", size =3)+
  geom_smooth(method = lm, color = "slategrey")+
  labs(title = "Wind vs Solar Radiation in New York from May to September",
       y = "Solar Radiation",
       x= "Wind")

###############
##### C. ######
###############
# Removing the Month of May, then pivoting the df longer
df <- AirQuality %>% select(-Month) %>% pivot_longer(!Day, names_to = "measurement", values_to = "value")
### BEESWARM PLOT ###
df %>% ggplot(aes(measurement, value)) +
  geom_beeswarm()+
  labs(title = "Distribution of Air Quality Measurements from May through Fall in New York",
       x = "Value",
       y = "Measurement Type")
