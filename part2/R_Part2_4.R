library(dplyr)
library(ggplot2)
library(scales)
library(viridis)
View(MessierData)
theme_update(plot.title = element_text(hjust = 0.5, size = 13), 
             panel.background = element_blank(),
             plot.subtitle = element_text(size = 10),
             panel.grid.minor = element_blank())
################################
########## VIOLIN PLOT ##########
################################
ggplot(MessierData[which(MessierData$Kind != ""),], aes(x= Distance..LY., y=Kind))+
  geom_violin(size=1, 
              color="slateblue",
              fill = "grey90")+
  geom_jitter(height = 0.1, width = 0, color = "grey40")+
  scale_x_log10(labels = scales::label_number_si())+
  labs(title = "Distribution of Distance in Light Years by Kind of Messier Object",
       x= "Log Base10_ Distance",
       y= "Kind")+ 
  theme(legend.position = "none")

################################
######## C. SCATTERPLOT #######
################################
ggplot(MessierData, aes(x=Apparent.Magnitude, y=Distance..LY., color = Apparent.Magnitude))+
  geom_point(size=5, shape = 18)+
  scale_y_log10(labels = scales::label_number_si())+
  theme(legend.position = "none")+
  labs(title = "Apparent Magnitude vs Distance of Messier Objects",
       x="Apparent Magnitude",
       y="Distance (LY)")+
  scale_color_gradient(low = "gold", high="#7c381f")+
  theme( 
    panel.background = element_rect(fill = "black"),
    panel.grid.major = element_line(colour = "#433858"), 
    panel.grid.minor = element_line(colour = "#685F79")
  )