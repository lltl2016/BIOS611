library(tidyverse)
swing_state_sup_rate = read.csv("data/sssr.csv")
ggplot(swing_state_sup_rate, aes(party,mean_RUCA,fill=party)) +
  scale_fill_manual(values=c("#0000FF", "#FF0000"))+  #Give them the color they should have!!!
  geom_violin()+
  xlab("Party Won the election")+
  ylab("RUCA code of the county") +
  ggtitle("Fig 3. Violin plot of mean RUCA codes versus which party won in that county")+
  ggsave("violinPlot.png")