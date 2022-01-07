library(tidyverse)
library(ggplot2)
View(PerceptionExperiment1)
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))
PerceptionExperiment1$Error <- (PerceptionExperiment1$Response - PerceptionExperiment1$TrueValue)
ggplot(PerceptionExperiment1, aes(x=Error)) + geom_histogram(bins = 16, color = "deepskyblue3", fill = "lightsteelblue") + 
  scale_x_continuous(limits = c(-1, 1)) +
  labs(title = "Frequency of True Value Difference (Error) from \nResponse of Perception Experiment 1", y="Frequency")
