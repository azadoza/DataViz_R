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

ds <- aggregate(PerceptionExperiment1$Error, list(PerceptionExperiment1$Test), median)
ggplot(data=ds, aes(x=x, y=Group.1)) + 
  geom_bar(stat = "identity", color = "deepskyblue2", fill = "lightsteelblue") + 
  scale_y_discrete(limits=ds$Group.1[order(ds$x)]) +
  labs(title = "Median Response Difference from True Value by Test", y = "", x = "Median Difference")

ds2 <- aggregate(PerceptionExperiment1$Error, list(PerceptionExperiment1$Test), sd)
ggplot(data=ds2, aes(x=Group.1, y=x)) + 
  geom_bar(stat = "identity", color = "deepskyblue2", fill = "lightsteelblue") + 
  scale_x_discrete(limits=ds2$Group.1[order(ds2$x)]) +
  labs(title = "Standard Deviation of Perception Response Error \nfrom True Value by Test, Experiment 1", y = "Standard Deviation", x = "Test")