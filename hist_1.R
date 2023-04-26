library(shiny)
library(datasets)

# Load Iris dataset
data("iris")

# Define UI for app and Set up sidebar layout
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "sepal_length_bin", label = "Sepal Length Bin Size", min = 1, max = 10, value = 5),
      sliderInput(inputId = "sepal_width_bin", label = "Sepal Width Bin Size", min = 1, max = 10, value = 5),
      sliderInput(inputId = "petal_length_bin", label = "Petal Length Bin Size", min = 1, max = 10, value = 5),
      sliderInput(inputId = "petal_width_bin", label = "Petal Width Bin Size", min = 1, max = 10, value = 5)
      
    ),
    mainPanel(
      plotOutput(outputId = "sepal_length_hist"),
      plotOutput(outputId = "sepal_width_hist"),
      plotOutput(outputId = "petal_length_hist"),
      plotOutput(outputId = "petal_width_hist")
    )
  )
)

server <- function(input, output) {
  
  # sepal length variable
  output$sepal_length_hist <- renderPlot({
    bins <- seq(min(iris$Sepal.Length), max(iris$Sepal.Length), length.out = input$sepal_length_bin + 1)
    hist(iris$Sepal.Length, col = "#777bc2", main = "Sepal Length", xlab = "Length", breaks = bins)
  })
  
  # sepal width variable
  output$sepal_width_hist <- renderPlot({
    bins <- seq(min(iris$Sepal.Width), max(iris$Sepal.Width), length.out = input$sepal_width_bin + 1)
    hist(iris$Sepal.Width, col = "#777bc2", main = "Sepal Width", xlab = "Width", breaks = bins)
  })
  
  # petal length variable
  output$petal_length_hist <- renderPlot({
    bins <- seq(min(iris$Petal.Length), max(iris$Petal.Length), length.out = input$petal_length_bin + 1)
    hist(iris$Petal.Length, col = "#777bc2",  main = "Petal Length", xlab = "Length", breaks = bins)
  })
  
  # petal width variable
  output$petal_width_hist <- renderPlot({
    bins <- seq(min(iris$Petal.Width), max(iris$Petal.Width), length.out = input$petal_width_bin + 1)
    hist(iris$Petal.Width, col = "#777bc2", main = "Petal Width", xlab = "Width", breaks = bins)
  })
  
}

# Run the app
shinyApp(ui = ui, server = server)

