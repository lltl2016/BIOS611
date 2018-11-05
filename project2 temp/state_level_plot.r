library(tidyverse)
summerization_sup_rate = read_csv("data/ssr.csv")
ggplot(summerization_sup_rate,aes(x = state_ruca, y = sup_R)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  xlab("Mean RUCA code of a state (smaller the number, more urban the state is)") + 
  ylab("Supporting rate for GOP in 2016 election") +
  ggtitle("Fig 2. Scatter Plot of the Supporting Rate Versus the Setting of a State")+
  ggsave("state_level_plot.png")