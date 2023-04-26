library(shiny)
library(ggplot2)
library(dplyr)

# load iris dataset
data("iris")

ui <- fluidPage(
  # create a select input for the user to choose the species and color
  selectInput('species', 'Select Species', choices = unique(iris$Species)),
  selectInput('color', 'Select Color', choices = c('red', 'blue', 'green', 'yellow')),
  
  # create a plot output
  plotOutput('scatter_plot')
)

server <- function(input, output) {
  # create a reactive plot using ggplot
  output$scatter_plot <- renderPlot({
    # create a copy of the iris dataset
    iris_copy <- iris
    
    # update the color of the selected species
    iris_copy$color <- ifelse(iris_copy$Species == input$species, input$color, 'black')
    
    ggplot(iris_copy, aes(x = Sepal.Length, y = Sepal.Width, color = color)) +
      geom_point() +
      scale_color_identity()
  })
}

shinyApp(ui = ui, server = server)
