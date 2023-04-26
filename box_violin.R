library(shiny)
library(ggplot2)
library(dplyr)

# load iris dataset
data(iris)

# Define UI
ui <- fluidPage(
  titlePanel("Iris Data Visualization"),
  sidebarLayout(
    sidebarPanel(
      selectInput("plotType", "Choose a plot type:",
                  choices = c("Box Plot", "Violin Plot"),
                  selected = "Box Plot"),
      checkboxGroupInput("species", "Choose species:",
                         choices = unique(iris$Species),
                         selected = unique(iris$Species)),
      sliderInput("width", "Box/Violin Width:",
                  min = 0.1, max = 1, value = 0.5, step = 0.1)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server
server <- function(input, output) {
  
  # filter data based on selected species
  filtered_data <- reactive({
    iris %>% filter(Species %in% input$species)
  })
  
  # create box plot or violin plot
  output$plot <- renderPlot({
    if (input$plotType == "Box Plot") {
      ggplot(filtered_data(), aes(x = Species, y = Sepal.Length)) +
        geom_boxplot(width = input$width) +
        ggtitle("Box Plot of Sepal Length by Species")
    } else {
      ggplot(filtered_data(), aes(x = Species, y = Sepal.Length)) +
        geom_violin(width = input$width) +
        ggtitle("Violin Plot of Sepal Length by Species")
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
