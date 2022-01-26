library(tidyverse)
library(ggplot2)
View(PerceptionExperiment1)
## Updating theme, 
theme_set(theme_light())
theme_update(plot.title = element_text(hjust = 0.5))
## Adding new column
PerceptionExperiment1$Error <- (PerceptionExperiment1$Response - PerceptionExperiment1$TrueValue)
## 2a. Histogram 
ggplot(PerceptionExperiment1, aes(x=Error)) + geom_histogram(bins = 16, color = "deepskyblue3", fill = "lightsteelblue") + 
  scale_x_continuous(limits = c(-1, 1)) +
  labs(title = "Frequency of True Value Difference (Error) from \nResponse of Perception Experiment 1", y="Frequency")
#------------------------------
## 2b. Error v Test Median Bar Graph
ds <- aggregate(PerceptionExperiment1$Error, list(PerceptionExperiment1$Test), median)
ggplot(data=ds, aes(x=x, y=Group.1)) + 
  geom_bar(stat = "identity", color = "deepskyblue2", fill = "lightsteelblue") + 
  scale_y_discrete(limits=ds$Group.1[order(ds$x)]) +
  labs(title = "Median Response Difference from True Value by Test", y = "", x = "Median Difference")
#------------------------------
## 2c. Standard Deviation
ds2 <- aggregate(PerceptionExperiment1$Error, list(PerceptionExperiment1$Test), sd)
ggplot(data=ds2, aes(x=Group.1, y=x)) + 
  geom_bar(stat = "identity", color = "deepskyblue2", fill = "lightsteelblue") + 
  scale_x_discrete(limits=ds2$Group.1[order(ds2$x)], labels = function(x) stringr::str_wrap(x, width = 10)) +
  labs(title = "Standard Deviation of Perception Response Error \nfrom True Value by Test, Experiment 1", y = "Standard Deviation", x = "Test")
#------------------------------
## 2d. Absolute Error
PerceptionExperiment1$ABS_Error <- abs(PerceptionExperiment1$Error)
ds_abs <- aggregate(PerceptionExperiment1$ABS_Error, list(PerceptionExperiment1$Test), median)
ggplot(data=ds_abs, aes(x=Group.1, y=x)) + 
  geom_bar(stat = "identity", color = "deepskyblue3", fill = "lightsteelblue2", width = 0.8) + 
  scale_x_discrete(limits=ds_abs$Group.1[order(ds_abs$x)], labels = function(x) stringr::str_wrap(x, width = 10)) +
  labs(title = "Median of Perception Response Error by Test,\nAbsolute Values, Experiment 1", y = "Standard Deviation", x = "Test")

