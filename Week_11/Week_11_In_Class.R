#### In Class Notes



library(shiny)
ui<-fluidPage('Hello World')
server<-function(input,output){}
shinyApp(ui = ui, server = server)

library(shiny)

ui <- fluidPage(
  # Put the sliderInput inside the UI
  sliderInput(
    inputId = "num",          # ID name for the input
    label = "Choose a number",# Label above the input
    value = 25,               # Default value
    min = 1,                  # Minimum value
    max = 100                 # Maximum value
  )
)
server <- function(input, output) {
  # Nothing here yet
}
shinyApp(ui = ui, server = server)


library(shiny)
ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ),
  plotOutput("hist") #creates space for a plot called hist
)
server<-function(input,output){}
shinyApp(ui = ui, server = server)


library(tidyverse)
ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ),
  plotOutput("hist") #creates space for a plot called hist  
)
server<-function(input,output){
  output$hist <- renderPlot({
    # {} allows us to put all our R code in one nice chunck
    data<-tibble(x = rnorm(100)) # 100 random normal points
    ggplot(data, aes(x = x))+ # make a histogram
      geom_histogram()
  })
}
shinyApp(ui = ui, server = server)

ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input 
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ),
  textInput(inputId = "title", # new Id is title
            label = "Write a title",
            value = "Histogram of Random Normal Values"), # starting title
  plotOutput("hist") #creates space for a plot called hist  
)
server<-function(input,output){
  output$hist <- renderPlot({
    # {} allows us to put all our R code in one nice chunck
    data<-tibble(x = rnorm(100)) # 100 random normal points
    ggplot(data, aes(x = x))+ # make a histogram
      geom_histogram()
  })
}

ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input 
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ),
  textInput(inputId = "title", # new Id is title
            label = "Write a title",
            value = "Histogram of Random Normal Values"), # starting title
  plotOutput("hist") #creates space for a plot called hist  
)
server<-function(input,output){
  output$hist <- renderPlot({
    # {} allows us to put all our R code in one nice chunck
    data<-tibble(x = rnorm(input$num)) # 100 random normal points 
    ggplot(data, aes(x = x))+ # make a histogram 
      geom_histogram() +
      labs(title = input$title) #Add a new title
  })
}




ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input 
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ),
  textInput(inputId = "title", # new Id is title 
            label = "Write a title",
            value = "Histogram of Random Normal Values"), # starting title 
  plotOutput("hist"), #creates space for a plot called hist
  verbatimTextOutput("stats") # create a space for stats
)
server<-function(input,output){
  output$hist <- renderPlot({
    # {} allows us to put all our R code in one nice chunck
    data<-tibble(x = rnorm(input$num)) # 100 random normal points 
    ggplot(data, aes(x = x))+ # make a histogram 
      geom_histogram() +
      labs(title = input$title) #Add a new title
  })
  output$stats <- renderPrint({
    summary(rnorm(input$num)) # calculate summary stats based on the numbers
  })
}



