#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)
library(stringr)
library(quanteda)

fivegram <- readRDS("fivegram.rds");
quadgram <- readRDS("quadgram.rds");
trigram <- readRDS("trigram.rds");
bigram <- readRDS("bigram.rds");

# Clean input data

str.token <- function(string) {
    token <- tokens(string, what="word", remove_numbers=TRUE, 
                    remove_punct=TRUE, remove_separators=TRUE, 
                    remove_symbols=TRUE)
    token <- tokens_tolower(token)
    return(token)
}

# Ngrams
pred.five <- function(inputstr) {
    posi <- (fivegram$first == inputstr[1]) &
        (fivegram$second == inputstr[2]) &
        (fivegram$third == inputstr[3]) &
        (fivegram$fourth == inputstr[4])
    return(posi)
}
pred.quad <- function(inputstr) {
    posi <- (quadgram$first == inputstr[1]) &
        (quadgram$second == inputstr[2]) &
        (quadgram$third == inputstr[3])
    return(posi)
}
pred.tri <- function(inputstr) {
    posi <- (trigram$first == inputstr[1]) &
        (trigram$second == inputstr[2])
    return(posi)
}
pred.bi <- function(inputstr) {
    posi <- (bigram$first == inputstr[1])
    return(posi)
}

# Prediction model

Predict <- function(string) {
    
    # Back Off Algorithm
    inputstr <- str.token(string)$text1
    if (length(inputstr) >= 4) {
        inputstr <- tail(inputstr, 4)
        posi.five <- pred.five(inputstr)
        if (sum(posi.five) == 0) {
            inputstr <- inputstr[-1]
        } else {
            return(c(as.character(fivegram$fifth[posi.five][1]), "5-grams"))
        }
    }
    if (length(inputstr) == 3) {
        posi.quad <- pred.quad(inputstr)
        if (sum(posi.quad) == 0) {
            inputstr <- inputstr[-1]
        } else {
            return(c(as.character(quadgram$fourth[posi.quad][1]), "4-grams"))
        }
    }
    if (length(inputstr) == 2) {
        posi.tri <- pred.tri(inputstr)
        if (sum(posi.tri) == 0) {
            inputstr <- inputstr[-1]
        } else {
            return(c(as.character(trigram$third[posi.tri][1]), "3-grams"))
        }
    }
    if (length(inputstr) == 1) {
        posi.bi <- pred.bi(inputstr)
        if (sum(posi.bi) == 0) {
            return("0")
        } else {
            return(c(as.character(bigram$second[posi.bi][1]), "2-grams"))
        }
    }

}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    prediction <- reactive({
        req(input$inputString)
        Predict(input$inputString)
    })
    inputstr <- reactive({
        req(input$inputString)
        input$inputString
    })

    output$text1 <- renderText({
        inputstr()
    })
    output$text2 <- renderText({
        if (prediction()[1] == "0") {
            "Sorry, I could not predict the next word :("
        } else {
            prediction()[1]
        }
    })
    output$text3 <- renderText({
        if (prediction()[1] == "0") {
            ""
        } else {
            paste("The next word is predicted by using", prediction()[2], ".")
        }
    })
})
