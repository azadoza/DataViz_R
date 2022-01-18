library(dplyr)
library(ggplot2)
library(lubridate)

View(reservation70_00)
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))

## 5a. Fixing 1970, Pivoting, and removing percent column
colnames(reservation70_00)[colnames(reservation70_00) == "1970*"] <- '1970'
reservationV2 <- reservation70_00 %>% 
  pivot_longer(
    cols = ends_with("0"), 
    names_to = "Year", 
    values_to = "Population") %>% 
  select(-`Percent Change`)

 # Setting Year to Date
reservationV2$Year <- 
  lubridate::ymd(paste0(as.double(reservationV2$Year), "01", "01"))
head(reservationV2)

 # getting rid of Montana & other clean up
reservationV2 <- reservationV2[!grepl("Montana", reservationV2$Location),]
reservationV2$Location <- gsub('[**]', '', reservationV2$Location)

 # Line plot but with points 
ggplot(data = reservationV2, aes(x=Year, y=Population, color = Location)) + 
  geom_line(size=1.2) + 
  geom_point(size=2)+
  labs(title = "Population Growth of Montana's Reservations", x="Year", y="Population") + 
  scale_x_date(limits = as.Date(c("1970-01-01","2000-01-01"))) +
  scale_y_continuous(labels = scales::label_number_si())+
  theme(legend.position = "bottom", legend.title = element_blank())+
  guides(color = guide_legend(nrow = 4, byrow = TRUE, reverse = TRUE))
  