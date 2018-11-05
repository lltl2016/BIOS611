library(tidyverse)
library(tidytext)
library(gutenbergr)

# Example from https://www.tidytextmining.com/tidytext.html

hgwells = gutenberg_download(c(35, 36, 5230, 159))

tidy_hgwells <- hgwells %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

tidy_hgwells %>%
  count(word, sort = TRUE)

write_csv(tidy_hgwells,"tidy_hgwells.csv")