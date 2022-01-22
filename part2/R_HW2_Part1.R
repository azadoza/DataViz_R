library(tidyverse)
library(ggplot2)
View(PerceptionExperiment1)
## Updating theme, 
theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))

## Adding new column
PerceptionExperiment1$Error <- (PerceptionExperiment1$Response - PerceptionExperiment1$TrueValue)
PerceptionExperiment1$ABS_Error <- abs(PerceptionExperiment1$Error)
 
## a. Univariate scatterplot
ggplot(PerceptionExperiment1, aes(x = Test, y = ABS_Error))+
  geom_point(size =2) + 
  labs(x= "Type of Visual Encoding", y="Error",  title = "Absolute Error of Perception Tests by Type of Visual Encoding" ) + 
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10))+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1))

