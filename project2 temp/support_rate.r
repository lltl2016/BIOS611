library(tidyverse)
result = read.csv("data/result.csv")
sup.rate <-result %>%
  mutate(sup_D_16 = round(dem_2016/total_2016*100,2),sup_R_16 = round(gop_2016/total_2016*100,2)) %>%
  select(fips_code,mean_RUCA,sup_D_16,sup_R_16)
write_csv(sup.rate,"data/sup_rate.csv")