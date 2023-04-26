# Load the necessary libraries
library(shiny)
library(datasets)

# Define the user interface
ui <- fluidPage(
  titlePanel("Box Plot of Sepal Length by Species"),
  sidebarLayout(
    sidebarPanel(
      selectInput("species", "Select a Species:",
                  choices = unique(iris$Species))
    ),
    mainPanel(
      plotOutput("boxplot")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$boxplot <- renderPlot({
    boxplot(Sepal.Length ~ Species, data = iris[iris$Species == input$species,],
            xlab = "Species", ylab = "Sepal Length",
            main = paste0("Box Plot of Sepal Length for ", input$species))
  })
}

# Run the shiny app
shinyApp(ui = ui, server = server)
