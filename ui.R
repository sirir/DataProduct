library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Developing Data Prodcuts - Project"),
  sidebarPanel(
    h2("Instructions"),   
    h5("predictors are HorsePower, Cylinders Count, Weight of the car for the MPG prediction Model"),
    h5("Enter the values for HorsePower, Cylinders Count, Weight of the car below"),
    h5("Result will be predicted in MPG"),
    h4("Choose Horsepower using Slide bar"),
    sliderInput(inputId = "hp",
                label = "Horse Power",
                value = "200", min = 100, max = 500
    ),
    selectInput( inputId = "cyl", 
                 label = "Cylinders Count",
                 list("4", "6", "8", "10")),
    numericInput(inputId = "wt",
                 label = "Weight (lbs)",
                 2000, min = 2000, max = 10000, step = 50)
  ),
  mainPanel(
    h2("Values entered"),
    p(h4("Horsepower:")),
    textOutput("ohp"),
    p("\n"),
    
    p(h4("Cylinders Count:")),
    textOutput("ocyl"),
    p("\n"),
    
    p(h4("Weight (lbs)   :")),
    textOutput("owt"),
    p("\n"),
    
    h2("Predicted result"),
    h5("MPG relative to cars in mtcars dataset"),
    
    plotOutput("plots"),
    h3("Implementation"),
    p("\n"),
    p("Applying the linear modeling on mtcars dataset to understand the impact of horsepower, 
      Cylinders count and weight on the mpg of car.  Restricting 
      cylinder selection to 4, 6, 8 and 10 with radio buttons.  For the weight,
      reactive() is used to convert the user input weight into the units 
      used by the model, lb/1000.  A linear model function is used to 
      predict the mpg based on the three variables 
      input by the user.")
    )
    ))
