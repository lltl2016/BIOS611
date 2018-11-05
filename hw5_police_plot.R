library(tidyverse)
police = read_csv("police-locals.csv")
police %>%
  filter(police_force_size >= 1000) %>%
  ggplot(aes(x =all ,y=police_force_size)) +
  geom_point() +
  ggsave('police_plot.png')