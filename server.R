library(shiny)

library(dplyr)
library(ggplot2)
library(reshape2)
library(lubridate)

stormData <- read.csv("StormData.csv", stringsAsFactors = FALSE)
stormData$X <- NULL

# Define server logic required to draw the top N chart
shinyServer(function(input, output) {
  output$damagePlot <- renderPlot({
 
    yearCheck <- input$yearCheck
    topN <- input$topN
    
    varYear <- stormData[stormData$YEAR==yearCheck,]
    varYear$YEAR <- NULL
    
    varYear$FATIN <- varYear$FATALITIES + varYear$INJURIES
    # reorder the events based on the total fatalities and injuries
    varYear$EVTYPE <- factor(varYear$EVTYPE, varYear$EVTYPE[order(-varYear$FATIN)])
    varYear <- varYear[order(varYear$EVTYPE),]
    varYear$FATIN = NULL
    
    #get the top N results to graph
    health2topN <- varYear[1:topN,]
    health2m <- melt(health2topN)
    title <- paste(c("Top",topN,"Harmful Weather Events"), collapse=" ")
    g <- ggplot(health2m,aes(x=EVTYPE,y=value,fill=variable)) +
       ggtitle(title) +
       labs(x="",y="Number of People",fill="Health Effect") +
       theme( axis.text.x = element_text(angle=60, hjust=1))
    g + geom_bar(stat="identity")
    
  })
  
})
