library(dplyr)
library(ggplot2)

theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))

## cleaning up
AirQuality <- na.omit(AirQuality)
WindSolarAirQuality <- AirQuality %$% data.frame(wind = sort(Wind), solar= sort(Solar.R))

## b
ggplot(WindSolarAirQuality, aes(wind, solar)) + 
  geom_point(color="#5a6cb1", size =3)+
  geom_smooth(method = lm, color = "slategrey")+
  labs(title = "Wind vs Solar Radiation in New York from May to September",
       y = "Solar Radiation",
       x= "Wind")


