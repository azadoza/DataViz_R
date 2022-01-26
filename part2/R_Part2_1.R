library(tidyverse)
library(ggplot2)
View(PerceptionExperiment1)
## Updating theme, 
theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))

## Adding new column
PerceptionExperiment1$Error <- (PerceptionExperiment1$Response - PerceptionExperiment1$TrueValue)
PerceptionExperiment1$ABS_Error <- abs(PerceptionExperiment1$Error)

 ####################################
###### A. Univariate scatterplot ######
 ####################################
ggplot(PerceptionExperiment1, 
      aes(x = Test, y = ABS_Error))+
  geom_point(color = "darkseagreen", size =2) + 
  labs(x= "Type of Visual Encoding", 
      y="Error",  
      title = "Absolute Error of Perception Tests by Type of Visual Encoding" ) + 
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10))+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1))
#----------------------------------------------

###### B ###### 
  ##Graphing the same graphs as above, with error instead of absolute error, overlapped with a dot for the mean error per test, visually displays what neither of these graphs could show alone. This graph shows that while Slope has distribution from 0.7 to -0.7, the clustering around 0.2 – 0.3 is more intense than might have been perceived with only the scatterplot, meaning Slope was generally overestimated. Volume clearly has clustered around overestimation, and the median highlights this too.

##########################################
###### C. subset of Subjects Display ######
##########################################
# Creating subset from subjects 56 to 73
subset <- filter(PerceptionExperiment1, Subject >= 56 & Subject <= 73)
#----------------------------------------------
ggplot(subset, aes(x = Display, y = Error))+
  geom_point(color = "darkseagreen", size =2.5) +
  labs(x= "Display", y="Error",  
      title = "Error of Perception Tests for Subjects 56-73 \nIn Display 1 and 2, with Highlighted Mean" ) + 
  scale_x_discrete(limits = c(1, 2))+
  scale_y_continuous(expand = c(0, 0), limits = c(-.8, .8))+
  geom_hline(yintercept = 0, color = "grey40")+
  geom_point(data = subset, 
      aes(x= Display, 
      y = mean(Error)), 
      color = "darkgreen", 
      size = 2.5)+
  theme(plot.title = element_text(size=12))
#----------------------------------------------
####################################
###### D. Erroneous Stimulus ######
####################################
 # Finding the subset of subjects
filter(PerceptionExperiment1, Display == "1" & Test == "Vertical Distance, Non-Aligned" & Response == 1.00)
 # Subjects 56 - 73...
 # creating filter for graph. Filtered to show only Vertical Distance, non-aligned in Display 1
filter <- filter(PerceptionExperiment1, Test == "Vertical Distance, Non-Aligned", Display == "1" )

## resizing plot title for this session...
theme_update(plot.title = element_text(size=14))
theme_update(plot.subtitle = element_text(size=8))

# plotting with filter
#----------------------------------------------
ggplot(filter, 
       aes(x= Trial, y = Response))+
  geom_point(color = "darkseagreen", 
             size = 3) +
  geom_point(data = filter, 
             aes(x = Trial, y = TrueValue, col = TrueValue), 
             color = "grey20", 
             size = 3.1) +
  geom_point(data = filter, aes(x = Trial, y = 1.00, col = TrueValue), 
             color = "grey75", 
             size = 3.0) +
  scale_y_continuous(expand = c(0, 0), limits = c(0,1.1)) +
  labs(title = "Responses for Vertical Distance, Non-Aligned Tests in Display 1",
       subtitle = "Regular Responses in Green, True Value highlighted in Black, \nErroneous Responses marked Light Grey ")
#----------------------------------------------

## 1e. Experimenting with the data
 # summary
summary(PerceptionExperiment1)
theme_update(plot.title = element_text(size=13))

ggplot(PerceptionExperiment1, aes(x = TrueValue, y=Response))+
  geom_abline(intercept = 0, slope = 1, size = 1.5, color = "grey80") +
  geom_point(color = "darkseagreen",
             size = 2.5)+
  labs(title = "TrueValue vs Response in Perception Experiment 1")+
  scale_x_discrete(limits = c(.1, .2, .3, .4, .5, .6,.7, .8, .9), expand=c(0.1, 0))

ggplot(PerceptionExperiment1, aes(x = TrueValue, y=ABS_Error)) +
  geom_point(color = "darkseagreen",
             size = 2.5)+
  labs(title = "TrueValue vs Absolute Error in Perception Experiment 1")+
  scale_x_discrete(limits = c(.1, .2, .3, .4, .5, .6,.7, .8, .9), expand=c(0.1, 0))
