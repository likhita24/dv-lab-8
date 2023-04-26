# Load the necessary libraries
library(shiny)
library(datasets)

# Define the user interface
ui <- fluidPage(
  titlePanel("Histograms of Iris Properties"),
  sidebarLayout(
    sidebarPanel(
      selectInput("sl_color_sl", "Select a color for Sepal Length:",
                  choices = c("red", "green", "blue", "orange", "purple", "black"),
                  selected = "red"),
      selectInput("sw_color_sl", "Select a color for Sepal Width:",
                  choices = c("red", "green", "blue", "orange", "purple", "black"),
                  selected = "green"),
      selectInput("pl_color_sl", "Select a color for Petal Length:",
                  choices = c("red", "green", "blue", "orange", "purple", "black"),
                  selected = "blue"),
      selectInput("pw_color_sl", "Select a color for Petal Width:",
                  choices = c("red", "green", "blue", "orange", "purple", "black"),
                  selected = "orange")
    ),
    mainPanel(
      plotOutput("histograms")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$histograms <- renderPlot({
    par(mfrow=c(2,2))
    hist(iris$Sepal.Length, col = input$sl_color_sl,
         xlab = "Sepal Length", main = "Histogram of Sepal Length")
    hist(iris$Sepal.Width, col = input$sw_color_sl,
         xlab = "Sepal Width", main = "Histogram of Sepal Width")
    hist(iris$Petal.Length, col = input$pl_color_sl,
         xlab = "Petal Length", main = "Histogram of Petal Length")
    hist(iris$Petal.Width, col = input$pw_color_sl,
         xlab = "Petal Width", main = "Histogram of Petal Width")
  })
}

# Run the shiny app
shinyApp(ui = ui, server = server)
