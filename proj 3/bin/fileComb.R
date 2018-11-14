library(tidyverse)
args = commandArgs(trailingOnly = TRUE)
a=read.csv(args[1])
inf = na.omit(a)
temp = inf %>% group_by(institute) %>% count() %>% arrange(desc(n)) %>% head(10)
inf2 = inf %>%
  semi_join(temp)
write.csv(inf2,"output.csv")