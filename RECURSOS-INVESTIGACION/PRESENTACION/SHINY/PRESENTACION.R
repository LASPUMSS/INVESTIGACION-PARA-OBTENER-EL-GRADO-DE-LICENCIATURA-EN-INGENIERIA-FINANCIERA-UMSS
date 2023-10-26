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
    
    includeCSS("RECURSOS-INVESTIGACION/PRESENTACION/SHINY/assets/css/style.css"),
    
    # Application title
    titlePanel("Proyección de estados financieros por el método de redes neuronales artificiales aplicable al sector financiero de Bolivia"),

    # Sidebar with a slider input for number of bins 
    navbarPage("",
               tabPanel("PERFIL"),
               tabPanel("MARCO TEORICO"),
               navbarMenu("DIAGNOSTICO FINANCIERO",
                          tabPanel("PRECISIONES DEL DIAGNOSTICO"),
                          tabPanel("CALCULO DE INDICADORES", uiOutput("diagnosticoCalculoIndicadoes"))
               ),
               tabPanel("PRONOSTICO DE ESTADOS FINANCIEROS POR NN"),
               navbarMenu("CONCLUSIONES Y RECOMENDACIONES",
                          tabPanel("OBJETIVOS", uiOutput("conclusionesObjetivos")),
                          tabPanel("GENERAL", uiOutput("conclusionesGeneral"))
               ),
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    # DIAGNOSTICO
    output$diagnosticoCalculoIndicadoes <- renderUI({
        HTML(markdown::markdownToHTML(knitr::knit("RECURSOS-INVESTIGACION/PRESENTACION/SHINY/DIAGNOSTICO/02-CALCULO-INDICADORES_PRESENTACION.Rmd", quiet = TRUE), fragment.only=TRUE))
        
    })
    
    
    # CONCLUSIONES
    output$conclusionesObjetivos <- renderUI({
        HTML(markdown::markdownToHTML(knitr::knit("RECURSOS-INVESTIGACION/PRESENTACION/SHINY/CONCLUSIONES/CONCLUSIONES_OBJETIVOS_PRESENTACION.Rmd", quiet = TRUE), fragment.only=TRUE))
        
    })
    
    output$conclusionesGeneral <- renderUI({
        HTML(markdown::markdownToHTML(knitr::knit("RECURSOS-INVESTIGACION/PRESENTACION/SHINY/CONCLUSIONES/CONCLUSIONES_GENERAL_PRESENTACION.Rmd", quiet = TRUE), fragment.only=TRUE))
        
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server,)

