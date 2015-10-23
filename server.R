library(shiny)
data(mtcars)

modFit <- lm(mpg ~ hp+cyl+wt, data = mtcars)

modFit$coefficients
mpg <- function(hp, cyl, wt) {
  modFit$coefficients[1] + modFit$coefficients[2] * hp + 
    modFit$coefficients[3] * cyl + modFit$coefficients[4] * wt
}
shinyServer(
  function(input, output) {
    
    modified_weight <- reactive({input$wt/1000})
    predicted_mpg <- reactive({mpg(input$hp, as.numeric(input$cyl), 
                                   modified_weight())
    })
    output$ohp <- renderPrint({paste(input$hp, "Horsepower")})
    output$ocyl <- renderPrint({paste(input$cyl, "Cylinders")})
    output$owt <- renderPrint({paste(input$wt, "Weight in lbs")})
    output$prediction <- renderPrint({paste(round(predicted_mpg(), 2), 
                                            "miles per gallon")
    })
    output$plots <- renderPlot({
      par(mfrow = c(1, 3))
      with(mtcars, plot(hp, mpg,
                        xlab='Horsepower',
                        ylab='MPG',
                        main='MPG vs Horsepower'))
      points(input$hp, predicted_mpg(), col='blue', cex=3)                 
      with(mtcars, plot(cyl, mpg,
                        xlab='Cylinders',
                        ylab='MPG',
                        main='MPG vs Cylinders'))
      points(as.numeric(input$cyl), predicted_mpg(), col='blue', cex=3)  
      with(mtcars, plot(wt, mpg,
                        xlab='Weight (lb/1000)',
                        ylab='MPG',
                        main='MPG vs weight(Lbs)'))
      points(modified_weight(), predicted_mpg(), col='blue', cex=3)  
    })
  }
)

