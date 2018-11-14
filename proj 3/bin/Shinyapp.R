library(shiny)
library(tidyverse)
library(tidytext)

args = commandArgs(trailingOnly = TRUE)
top10=read.csv(args[1])
topten = topten[,3:5]
ranking = as.data.frame(topten %>%
  group_by(institute) %>%
  count() %>%
  arrange(desc(n)))
Institute = as.vector(ranking$institute)

## Please note: I tried to make it easier to make the following code appear in the SERVER part of the UI, but it will return error..
`Duke University` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "Duke University") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`Baylor College of Medicine` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "Baylor College of Medicine") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`University of California` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "University of California") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`University of Washington` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "University of Washington") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`Harvard Medical School` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "Harvard Medical School") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`Duke University Medical Center` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "Duke University Medical Center") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`Memorial Sloan Kettering Cancer Center` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "Memorial Sloan Kettering Cancer Center") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`National Cancer Institute` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "National Cancer Institute") %>%
                                    select(word,n) %>%
                                    arrange(desc(n)))
`The University of Texas MD Anderson Cancer Center` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "The University of Texas MD Anderson Cancer Center") %>%
                                    select(word,n) %>%
                                    arrange(desc(n))) 
                                    
`University of Chicago` = as.data.frame(topten %>%
                                    mutate(text=paste(title,abs)) %>%
                                    unnest_tokens(word, text) %>%
                                    anti_join(stop_words) %>%
                                    count(institute, word) %>%
                                    filter(institute == "University of Chicago") %>%
                                    select(word,n) %>%
                                    arrange(desc(n))) 

# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Shiny Dashboard: Top 10 Collaborator Institute of UNC"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Integer for the number of bins ----
      selectInput(inputId = "Institute","Choose an institute to view research topics:",
                  list(`Overall` = c("Overall"),
                       `Institute` = Institute))
      ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram and table----
      plotOutput(outputId = "popPlot"),
      dataTableOutput(outputId = "popTable")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # renderPlot creates histogram and links to ui
  output$popPlot <- renderPlot({
  ggplot(topten) +
    geom_bar(aes(x = institute,fill = institute))+
    coord_polar(theta = "x", direction=1 )+
    ggtitle("Top 10 Institute with Collaboration with UNC") +
    theme(axis.ticks = element_blank(),
          panel.grid  = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          plot.title = element_text(hjust = 0.5))
  })
  
  # Data table output, linked to ui
  output$popTable <- renderDataTable({
    if(input$Institute == "Overall"){
      ranking
    }else{
      get(input$Institute)
    }
  })
}

shinyApp(ui = ui, server = server)