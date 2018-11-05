library(tidyverse)
source("swing_state.r")
summerization_sup_rate = read_csv("data/ssr.csv")

summerization_sup_rate <- summerization_sup_rate %>%
  mutate(swing_state = sapply(state,is_swing_state))

swing_state_sup_rate <- sup.rate %>%
  mutate(state = substr(fips_code,1,2)) %>%
  left_join(summerization_sup_rate,by = "state") %>%
  filter(swing_state) %>%
  select(fips_code,mean_RUCA,sup_D_16,sup_R_16) %>%
  mutate(party = ifelse(sup_R_16 > sup_D_16, 'GOP', 'Democrats'))

write_csv(swing_state_sup_rate,"data/sssr.csv")