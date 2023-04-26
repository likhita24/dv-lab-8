library(shiny)
library(ggplot2)
library(dplyr)

# load iris dataset
data("iris")

ui <- fluidPage(
  # create a select input for the user to choose the species to filter
  selectInput('species', 'Select Species', choices = unique(iris$Species)),
  
  # create a plot output
  plotOutput('scatter_plot')
)

server <- function(input, output) {
  # create a reactive plot using ggplot
  output$scatter_plot <- renderPlot({
    filtered_iris <- iris %>% filter(Species == input$species)
    ggplot(filtered_iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point()
  })
}

shinyApp(ui = ui, server = server)
