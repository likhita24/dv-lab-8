library(shiny)
library(ggplot2)
library(datasets)

# Define UI
ui <- fluidPage(
  titlePanel("Iris Data Scatter Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x_var", "X-axis variable:", choices = colnames(iris[-5])),
      selectInput("y_var", "Y-axis variable:", choices = colnames(iris[-5])),
      width = 3
    ),
    mainPanel(
      plotOutput("iris_plot")
    )
  )
)

# Define server
server <- function(input, output) {
  
  # Create scatter plot of iris data
  output$iris_plot <- renderPlot({
    ggplot(iris, aes(x = !!sym(input$x_var), y = !!sym(input$y_var), color = Species)) +
      geom_point()
  })
  
}

# Run the app
shinyApp(ui = ui, server = server)
