#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    
    mtcars$vs <- factor(mtcars$vs, labels = c("V-shaped", "Straight"))
    mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual"))
    mtcars$cyl  <- ordered(mtcars$cyl)
    mtcars$gear <- ordered(mtcars$gear)
    mtcars$carb <- ordered(mtcars$carb)
    
    xlab <- reactive({
        if(input$var == "cyl") {
            "Number of Cylinders"
        } else if(input$var == "disp") {
            "Displacement (cu.in.)"
        } else if(input$var == "hp") {
            "Gross Horsepower"
        } else if(input$var == "drat") {
            "Rear Axle Ratio"
        } else if(input$var == "wt") {
            "Weight (1000 lbs)"
        } else if(input$var == "qsec") {
            "1/4 Mile Time"
        } else if(input$var == "vs") {
            "Engine"
        } else if(input$var == "am") {
            "Transmission"
        } else if(input$var == "gear") {
            "Number of Forward Gears"
        } else "Number of Carburetors"
    })

    model <- reactive({
        formu <- formula(paste("mpg~", input$var))
        summary(lm(formu, data=mtcars))
    })
    
    output$plot <- renderPlot({
        var <- mtcars[, input$var]
        if("factor" %in% class(var)) {
            ggplot(mtcars, aes(x=var, y=mpg, fill=var)) + geom_boxplot() +
                labs(y="Miles per (US) Gallon", x=xlab()) +
                guides(fill=guide_legend(title=xlab()))
        } else {
            ggplot(mtcars, aes(x=var, y=mpg)) + geom_point(size=2, alpha=0.7, colour="blue") +
                labs(y="Miles per (US) Gallon", x=xlab())
        }
    })
    
    output$fit <- renderTable({
        tabl <- as.data.frame(model()$coefficients)
        tabl$Var <- rownames(tabl)
        tabl <- tabl[, c(5, 1:4)]
        tabl
    })
    
    output$rsquared <- renderText({
        descr <- paste("The R-Squared for this univariate linear regression model is:",
                       model()$r.squared)
        descr
    })
  
})
