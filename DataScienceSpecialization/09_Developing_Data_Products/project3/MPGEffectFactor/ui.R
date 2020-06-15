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
  
    titlePanel("Effect Factors of MPG"),
  
    sidebarLayout(
        sidebarPanel(
            h1("Introduction"),
            p("This App is based on the mtcars dataset with 10 aspects of 
              automobile design and performance for 32 automobiles."),
            
            h1("Operation"),
            p("Please choose one factor you are most concerned about:"),
            selectInput("var", "Choose one!",
                        list("Number of cylinders" = "cyl",
                             "Displacement (cu.in.)" = "disp",
                             "Gross horsepower" = "hp",
                             "Rear axle ratio" = "drat",
                             "Weight (1000 lbs)" = "wt",
                             "1/4 mile time" = "qsec",
                             "Engine (V-shaped or straight)" = "vs",
                             "Transmission (Automatic or manual)" = "am",
                             "Number of forward gears" = "gear",
                             "Number of carburetors" = "carb")),
            submitButton("Submit")
        ),
        
        mainPanel(
            tabsetPanel(type="tab",
                        tabPanel("Relationship Plot", br(), plotOutput("plot")),
                        tabPanel("Univariate Linear Regression Model", br(),
                                 tableOutput("fit"), textOutput("rsquared"))
            )
        )
    )
))
