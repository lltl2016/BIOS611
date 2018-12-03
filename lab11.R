library(tidyverse)
WorldPhones = as.data.frame(WorldPhones) %>%
  rownames_to_column() 
colnames(WorldPhones)[1] = 'Year'
WorldPhones_df = WorldPhones %>%
  gather(Continent, Phones, N.Amer:Mid.Amer) %>%
  mutate(Year = as.numeric(Year))

mod1 = lm(Phones ~ Year * Continent, data = WorldPhones_df)
predictions = WorldPhones_df %>%
  data_grid(Year,Continent) %>%
  gather_predictions(mod1)

ggplot(WorldPhones_df, aes(x=Year, y=Phones, group=Continent)) +
  geom_point(aes(color = Continent)) +
  geom_line(data=predictions, aes(y=pred, color=Continent))


kmeans_wss <- Vectorize(function(c){
  return(sum(kmeans(attitude, centers=c)$withinss))
})

cluster_fit = tibble(num_centers=1:15) %>%
  mutate(wss = kmeans_wss(num_centers), diff_wss = wss - lag(wss))

ggplot(cluster_fit, aes(num_centers, wss)) +
  geom_point() +
  geom_line() +
  labs(x="Number of Clusters",
       y="Within groups sum of squares") 

k=3
km <- kmeans(attitude, 3)

attitude %>% 
  mutate(cluster = as.factor(km$cluster)) %>% 
  ggplot(aes(learning, complaints, col = cluster)) + 
  geom_point() +
  geom_point(data= as.data.frame(km$centers), 
             aes(learning, complaints), col = "black", size=3)


