library(tidyverse)
library(caret)


police1 = police %>%
  select(white,non.white,all)
kmeans_wss <- Vectorize(function(c){
  return(sum(kmeans(police1, centers=c)$withinss))
})

cluster_fit1 = tibble(num_centers=1:15) %>%
  mutate(wss = kmeans_wss(num_centers), diff_wss = wss - lag(wss))

ggplot(cluster_fit1, aes(num_centers, wss)) +
  geom_point() +
  geom_line() +
  labs(x="Number of Clusters",
       y="Within groups sum of squares") 

## It seems that the number of clusters should be 4.

fit = kmeans(police1,4)
# Append cluster assignment
police1$cluster = as.factor(fit$cluster)

# Plot results
ggplot(police1, aes(non.white, white,all, group=cluster)) +
  geom_point(size=2, alpha=0.75, aes(color=cluster))

new_cities_df = tibble(all=c(0.89, 0.51, 0.1), 
                       white=c(0.93, 0.34, 0.01), 
                       `non.white`=c(0.65, 0.2, 0.3))
# Train a k-nearest-neighbors model
knn_fit = train(cluster ~ all + white + non.white, data = police1, method = "knn")

# Predict type for new data
knn_classification = predict(knn_fit, new_cities_df, type="raw")