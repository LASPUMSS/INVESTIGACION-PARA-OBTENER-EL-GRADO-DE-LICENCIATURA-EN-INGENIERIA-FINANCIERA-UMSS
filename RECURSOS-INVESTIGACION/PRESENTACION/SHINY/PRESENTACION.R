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
    tags$div(class="header-presentacion", checked=TRUE,
             tags$div(class="header-logo-umss", checked=TRUE,
                      tags$img(src='https://drive.google.com/uc?export=view&id=1NoTXxCel5n3nbP1xrPLowXDz__3hC-zs', width='100px',height='100px')
             ),
             tags$div(class="header-title-proyecto", checked=TRUE,
   
                       tags$text('PROYECCIÓN DE ESTADOS FINANCIEROS POR EL MÉTODO DE REDES NEURONALES ARTIFICIALES APLICABLE AL SECTOR FINANCIERO DE BOLIVIA')
             ),
             tags$div(class="header-logo-fce", checked=TRUE,
                      
                      tags$img(src='https://drive.google.com/uc?export=view&id=1NSE4R6ae1MQpFtBdos5-R-NWTSDXYPpA', width='100px',height='100px')
             )
    ),
    
    # Sidebar with a slider input for number of bins 
    navbarPage("",
               navbarMenu("PERFIL DE INVESTIGACION",
                          tabPanel("PLANTEAMIENTO DEL PROBLEMA"),
                          tabPanel("FORMULACIÓN DEL PROBLEMA CENTRAL"),
                          tabPanel("JUSTIFICACIÓN"),
                          tabPanel("ALCANCE Y DELIMITACIÓN"),
                          tabPanel("OBJETIVOS DE LA INVESTIGACIÓN"),
                          tabPanel("HIPÓTESIS"),
                          tabPanel("MARCO METODOLÓGICO")
               ),
               
               tabPanel("MARCO TEORICO"),
               
               navbarMenu("DIAGNOSTICO FINANCIERO",
                          tabPanel("PRECISIONES DEL DIAGNOSTICO"),
                          tabPanel("CALCULO DE INDICADORES", uiOutput("diagnosticoCalculoIndicadoes")),
                          tabPanel("DEFINICIÓN DE RANGOS Y LÍMITES DE LOS INDICADORES CAMEL"),
                          tabPanel("PONDERACIÓN DE ELEMENTOS CAMEL"),
                          tabPanel("RESULTADOS CAMEL DEL SISTEMA FINANCIERO")
               ),
               
               navbarMenu("PROYECCION DE ESTADOS FINANCIEROS",
                          tabPanel("PRECISIONES DE LOS PRONÓSTICOS DE ESTADOS FINANCIEROS"),
                          tabPanel("ENTRENAMIENTO DE MODELOS, PROYECCIONES Y SIMULACIONES"),
                          tabPanel("EVALUACIÓN DE DATOS AJUSTADOS DE MODELOS"),
                          tabPanel("EVALUACIÓN DE DATOS PROYECTADOS DE MODELOS"),
                          tabPanel("APLICACIÓN DE METODOLOGÍA CAMEL SOBRE DATOS PROYECTADOS")
               ),
               
               navbarMenu("CONCLUSIONES Y RECOMENDACIONES",
                          tabPanel("CONCLUSIÓN OBJETIVOS", uiOutput("conclusionesObjetivos")),
                          tabPanel("CONCLUSIÓN GENERAL", uiOutput("conclusionesGeneral"))
               ),
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    rootMainDir <- 'RECURSOS-INVESTIGACION/PRESENTACION/SHINY/'
    
    # DIAGNOSTICO
    
    # DIAGNOSTICO
    
    output$diagnosticoCalculoIndicadoes <- renderUI({
        rootDirFile <- "DIAGNOSTICO/02-CALCULO-INDICADORES_PRESENTACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    
    # CONCLUSIONES
    output$conclusionesObjetivos <- renderUI({
        rootDirFile <- "CONCLUSIONES/CONCLUSIONES_OBJETIVOS_PRESENTACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$conclusionesGeneral <- renderUI({
        rootDirFile <- "CONCLUSIONES/CONCLUSIONES_GENERAL_PRESENTACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server,)

