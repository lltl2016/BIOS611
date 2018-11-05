library(tidyverse)
result <- read_csv("data/US_County_Level_Presidential_Results_08-16.csv")
ruca2010 <- read_csv("data/ruca2010.csv")

for (i in 1:nrow(ruca2010)){
  if (ruca2010[i,3] == 99){
    ruca2010[i,3] = 10
  }
}

for (i in 1:nrow(result)){
  if (result[i,1] == '29105'){
    result[i,3] = result[i,4]+result[i,5]+result[i,6]
  }
}

ruca <- ruca2010 %>%
  group_by(`State-County FIPS Code`) %>%
  mutate(mean_RUCA = round(mean(`Primary RUCA Code 2010`),2)) %>%
  rename( fips_code =`State-County FIPS Code`) %>%
  select(fips_code,mean_RUCA) %>%
  distinct()

write_csv(ruca, "data/ruca.csv")