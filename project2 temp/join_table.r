library(tidyverse)
result <- read_csv("data/US_County_Level_Presidential_Results_08-16.csv")
ruca <- read_csv("data/ruca.csv")
result <- result %>%
  left_join(ruca, by = "fips_code")
write.csv(result,"data/result.csv")