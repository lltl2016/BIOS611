library(tidyverse)
sup.rate = read.csv("data/sup_rate.csv")
ggplot(sup.rate) +
  geom_point(aes(x = mean_RUCA, y = sup_R_16)) +
  xlab("Mean RUCA code of a county (smaller the number, more urban the county is)") + 
  ylab("Supporting rate for GOP in 2016 election") +
  ggtitle("Fig 1. Scatter Plot of the Supporting Rate Versus the Setting of a County")+
  ggsave("Scatter_plot.png")