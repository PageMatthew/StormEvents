library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Top Weather Events for Harmful Health Effects"),
  
  # Sidebar with a slider input for number of bins 
    sidebarPanel(
       sliderInput("yearCheck",
                   "Year",
                   min = 1951,
                   max = 2011,
                   value = 2000,
                   sep = ''),
       sliderInput("topN",
                   "Number of Event Types",
                   min = 1,
                   max = 20,
                   value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("damagePlot")
    ),
  div(
     p("Description:  With this app you can view the top most devestating natural disasters with regards to human life and injury.  The graph shows the number of fatalities and injuries in a stacked bar chart."),
     p("Instructions: Move the above sliders to the right or left to choose the value to search with."),
     p("Move the Year slider to select a year in the range between 1951 and 2011, the default value is 2000"),
     p("Move the Number of Event Types to select the number of different types of natural disasters to display in the graph.  The minimum is 1 and the maximum is 20.  The default value is 10.  Note that in the early years, there may not be many recorded natural events.  If there are three events, then only three will display even if you set the slider to a number larger than 3.")
  )
  )
)
