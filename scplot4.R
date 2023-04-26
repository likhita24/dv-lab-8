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
      selectInput("species", "Choose a species:",
                  choices = unique(iris$Species),
                  selected = unique(iris$Species)[1]),
      sliderInput("size", "Select point size:", min = 1, max = 10, value = 5),
      selectInput("shape", "Select point shape:", 
                  choices = c("circle", "square", "triangle"),
                  selected = "circle")
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
    iris %>% filter(Species == input$species)
  })
  
  # create scatter plot
  output$plot <- renderPlot({
    ggplot(filtered_data(), aes(x = Sepal.Length, y = Sepal.Width, 
                                color = Species, size = Petal.Length, 
                                shape = input$shape)) +
      geom_point() +
      scale_color_manual(values = c("setosa" = "red", 
                                    "versicolor" = "green", 
                                    "virginica" = "blue")) +
      scale_size_continuous(range = c(1, input$size)) +
      guides(shape = FALSE)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
