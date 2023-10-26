#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Proyección de estados financieros por el método de redes neuronales artificiales aplicable al sector financiero de Bolivia"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            uiOutput("mark")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$mark <- renderUI({
        HTML(markdown::markdownToHTML(knitr::knit("RECURSOS-INVESTIGACION/PRESENTACION/SHINY/02-CALCULO-INDICADORES.Rmd", quiet = TRUE), fragment.only=TRUE))
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

