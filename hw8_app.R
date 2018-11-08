library(tidyverse)
library(shiny)

policedata = read_delim("police-incident-reports-written.csv",delim = ";")

# Define UI for app that draws a histogram and a data table----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Chapel Hill Police Data: Victim Age research"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Integer for the number of bins ----
      numericInput(inputId = "Age",
                   label = "Victim Age",
                   min = 1,
                   max = 100,
                   value = 30)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram and table----
      plotOutput(outputId = "popPlot")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # renderPlot creates histogram and links to ui
  output$popPlot <- renderPlot({
    Age = seq(min(policedata$`Victim Age`, na.rm = T), 
               max(policedata$`Victim Age`, na.rm = T), 
               length.out = input$Age + 1)
    
    ggplot(policedata,aes(`Victim Age`)) +
      geom_histogram(binwidth = 1) +
      labs(x = "Victim Age",
           title = "Histogram of Victim Age in Chapel Hill Police Data") +
      geom_vline(xintercept = input$Age)+
      geom_text(aes(x = input$Age + 5, y = 50,label = paste("Age = ",input$Age),color = "blue"))
  })
  
  

}

shinyApp(ui = ui, server = server)