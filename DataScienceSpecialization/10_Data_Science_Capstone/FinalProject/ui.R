#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
    
    titlePanel("NextWord"),
    
    sidebarLayout(
        sidebarPanel(width = 6,
            h1("Introduction"),
            p("This App can predict the next word for your input according to the back of algorithm."),
            
            h1("Operation"),
            textInput("inputString", "Please enter a partial sentence here", value = ""),
            submitButton("Submit")
        ),
        
        mainPanel(
            strong("Sentence Input:"),
            textOutput('text1'),
            strong("The next word may be:"),
            textOutput('text2'),
            textOutput('text3')
        )
    )
))

