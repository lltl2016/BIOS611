library(tidyverse)
result <- read_csv("data/US_County_Level_Presidential_Results_08-16.csv")

result_by_state <- result %>%
  mutate(state = substr(fips_code,1,2)) %>%
  select(fips_code,state,total_2016,dem_2016,gop_2016,mean_RUCA)

summerization <- result_by_state %>%
  group_by(state) %>%
  summarise(total_2016_by_state = sum(total_2016),dem_2016_by_state = sum(dem_2016),gop_2016_by_state = sum(gop_2016),state_ruca = round(mean(mean_RUCA),2))

summerization_sup_rate <- summerization%>%
  mutate(sup_D = round(dem_2016_by_state/total_2016_by_state*100,2), sup_R = round(gop_2016_by_state/total_2016_by_state*100,2)) %>%
  select(state, state_ruca,sup_D,sup_R)

write_csv(summerization_sup_rate,"data/ssr.csv")