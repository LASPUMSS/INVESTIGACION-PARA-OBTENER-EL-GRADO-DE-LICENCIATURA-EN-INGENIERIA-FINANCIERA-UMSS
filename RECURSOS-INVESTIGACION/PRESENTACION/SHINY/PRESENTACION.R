library(shiny)

# Agregar ruta de imagenes
addResourcePath(prefix = "imgResources", directoryPath = "RECURSOS-INVESTIGACION/PRESENTACION/SHINY/assets/img")

# Define UI for application
ui <- fluidPage(
    
    includeCSS("RECURSOS-INVESTIGACION/PRESENTACION/SHINY/assets/css/style.css"),
    
    # Application title
    tags$div(class="header-presentacion", checked=TRUE,
             tags$div(class="header-logo-umss", checked=TRUE,
                      tags$img(src='imgResources/logo-umss.jpg', width='100px',height='100px')
             ),
             tags$div(class="header-title-proyecto", checked=TRUE,
   
                       tags$text('PROYECCIÓN DE ESTADOS FINANCIEROS POR EL MÉTODO DE REDES NEURONALES ARTIFICIALES APLICABLE AL SECTOR FINANCIERO DE BOLIVIA')
             ),
             tags$div(class="header-logo-fce", checked=TRUE,
                      
                      tags$img(src='imgResources/logo-fce.jpg', width='100px',height='100px')
             )
    ),
    
    # Sidebar with a slider input for number of bins 
    navbarPage("",
               
               ####################################################################
               # INICIO UI
               ####################################################################
               
               tabPanel("INICIO",uiOutput("inicio")),
               
               ####################################################################
               # PERFIL UI
               ####################################################################
               
               navbarMenu("PERFIL ",
                          tabPanel("PLANTEAMIENTO DEL PROBLEMA",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("perfilPlanteamientoProblema"))
                                   )),
                          tabPanel("FORMULACIÓN DEL PROBLEMA CENTRAL",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("perfilProblemaCentral"))
                                   )),
                          tabPanel("JUSTIFICACIÓN",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("perfilJustificacion"))
                                   )),
                          tabPanel("ALCANCE Y DELIMITACIÓN",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("perfilAlcance"))
                                   )),
                          tabPanel("OBJETIVOS DE LA INVESTIGACIÓN",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("perfilObjetivos"))
                                   )),
                          tabPanel("HIPÓTESIS",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("perfilHipotesis"))
                                   )),
                          tabPanel("MARCO METODOLÓGICO",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("perfilMetodologia"))
                                   ))
               ),
               
               ####################################################################
               # MARCO TEORICO UI
               ####################################################################
    
               navbarMenu("MARCO TEORICO",
                          
                          # FINANZAS - EVALUACION FINANCIERA
                          tabPanel("FINANZAS - EVALUACION FINANCIERA",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("marcoTeoricoFinanzasEvaluacion_Intro")),
                                       tabPanel("FINANZAS", uiOutput("marcoTeoricoFinanzasEvaluacion_Finanzas")),
                                       tabPanel("EVALUACION FINANCIERA", uiOutput("marcoTeoricoFinanzasEvaluacion_EvalFin")),
                                       tabPanel("METODOLOGIA CAMEL", uiOutput("marcoTeoricoFinanzasEvaluacion_Camel"))
                                       )),
                          
                          # REDES NEURONALES
                          tabPanel("REDES NEURONALES",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("marcoTeoricoRedesNeuronales_Intro")),
                                       tabPanel("ELEMENTOS", uiOutput("marcoTeoricoRedesNeuronales_Elementos")),
                                       tabPanel("REGRESION", uiOutput("marcoTeoricoRedesNeuronales_Regresion")),
                                       tabPanel("FUNCIONES DE ACTIVACION", uiOutput("marcoTeoricoRedesNeuronales_Colapso")),
                                       tabPanel("PROP. ADELANTE", uiOutput("marcoTeoricoRedesNeuronales_PropAdelante")),
                                       tabPanel("PROP. ATRAS", uiOutput("marcoTeoricoRedesNeuronales_PropAtras"))
                                   )),
                          
                          # PROYECCION - EVALUACION
                          tabPanel("PROYECCION - SIMULACIONES",
                                   tabsetPanel(
                                       tabPanel("UMSS", uiOutput("marcoTeoricoPronosticosEvaluacion_Intro")),
                                       tabPanel("COEFICIENTE DE DETERMINACION - AJUSTE", uiOutput("marcoTeoricoPronosticosEvaluacion_PronAjuste")),
                                       tabPanel("GENERALIZACION", uiOutput("marcoTeoricoPronosticosEvaluacion_Generalizacion")),
                                       tabPanel("MCO", uiOutput("marcoTeoricoPronosticosEvaluacion_MCO")),
                                       tabPanel("ARIMA", uiOutput("marcoTeoricoPronosticosEvaluacion_ARIMA"))
                                   ))
                          
                          ),
               
               ####################################################################
               # DIAGNOSTICO UI
               ####################################################################
               
               navbarMenu("DIAGNOSTICO FINANCIERO",
                          tabPanel("PRECISIONES DEL DIAGNOSTICO", 
                                   tabsetPanel(
                                       tabPanel("ENTIDADES FIANCIERAS COMPRENDIDAS", uiOutput("diagnosticoPresicionesEntidadesFinancieras")),
                                       tabPanel("VARIABLES COMPRENDIDAS", uiOutput("diagnosticoPresicionesVariablesComprendidas"))
                                   )),
                          tabPanel("CALCULO DE INDICADORES",
                                   tabsetPanel(
                                       tabPanel("CAPITAL (C)", uiOutput("diagnosticoCalculoIndicadoresCapital")),
                                       tabPanel("ACTIVOS (A)", uiOutput("diagnosticoCalculoIndicadoresActivos")),
                                       tabPanel("ADMINISTRACION (M)", uiOutput("diagnosticoCalculoIndicadoresAdmin")),
                                       tabPanel("BENEFICIOS (E)", uiOutput("diagnosticoCalculoIndicadoresBeneficios")),
                                       tabPanel("LIQUIDEZ (L)", uiOutput("diagnosticoCalculoIndicadoresLiquidez"))
                                   )),
                          tabPanel("DEFINICIÓN DE RANGOS Y LÍMITES DE LOS INDICADORES CAMEL", 
                                   tabsetPanel(
                                       tabPanel("LIMITES INDICADORES CAMEL", uiOutput("diagnosticoRangosLimites")),
                                       tabPanel("RANGOS FLEXIBLES", uiOutput("diagnosticoRangosLimitesFlexibles")),
                                       tabPanel("RANGOS ESTRICTOS", uiOutput("diagnosticoRangosLimitesEstrictos"))
                                   )),
                          tabPanel("PONDERACIÓN DE ELEMENTOS CAMEL", uiOutput("diagnosticoPonderacion")),
                          tabPanel("RESULTADOS CAMEL DEL SISTEMA FINANCIERO",
                                   tabsetPanel(
                                       tabPanel("GRAFICO", uiOutput("diagnosticoResultadosCamelGrafico")),
                                       tabPanel("TABLA RESUMEN", uiOutput("diagnosticoResultadosCamelTabla"))
                                   ))
               ),
               
               ####################################################################
               # PROYECCIONES UI
               ####################################################################
               
               navbarMenu("PROYECCION DE ESTADOS FINANCIEROS",
                          tabPanel("PRECISIONES DE LOS PRONÓSTICOS DE ESTADOS FINANCIEROS", 
                                   tabsetPanel(
                                       tabPanel("SERIES DE TIEMPO", uiOutput("proyeccionesPrecisionesSeriesTiempo")),
                                       tabPanel("MODELOS - EVALUACION", uiOutput("proyeccionesPrecisionesModelosEvaluacion")),
                                       tabPanel("VARIABLES COMPRENDIDAS", uiOutput("proyeccionesPrecisionesVariablesComprendidas"))
                                   )),
                          tabPanel("ENTRENAMIENTO DE MODELOS, PROYECCIONES Y SIMULACIONES",
                                   tabsetPanel(
                                       tabPanel("MODELO CLASICO", uiOutput("proyeccionesEntrenamientoEjemploMCO")),
                                       tabPanel("ARIMA", uiOutput("proyeccionesEntrenamientoEjemploARIMA")),
                                       tabPanel("NN", uiOutput("proyeccionesEntrenamientoEjemploNN")),
                                       tabPanel("EFICIENCIA", uiOutput("proyeccionesEntrenamientoEjemploEficiencia")),
                                       tabPanel("SIMULACION", uiOutput("proyeccionesEntrenamientoEjemploSimulacion"))
                                   )),
                          tabPanel("EVALUACIÓN DE DATOS AJUSTADOS DE MODELOS", 
                                   tabsetPanel(
                                       tabPanel("AJUSTE MODELOS", uiOutput("proyeccionesEvaluarModelosAjusteModelos")),
                                       tabPanel("AJUSTE MODELOS RESUMIDO", uiOutput("proyeccionesEvaluarModelosAjusteModelosResumido")),
                                       tabPanel("AJUSTE PROYECCIONES", uiOutput("proyeccionesEvaluarModelosAjusteProyecciones")),
                                       tabPanel("AJUSTE PROYECCIONES RESUMIDO", uiOutput("proyeccionesEvaluarModelosAjusteProyeccionesResumido"))
                                   )),
                          tabPanel("APLICACIÓN DE METODOLOGÍA CAMEL SOBRE DATOS PROYECTADOS", 
                                   tabsetPanel(
                                       tabPanel("CAMEL SOBRE DATOS PROYECTADOS", uiOutput("proyeccionesAplicacionCamel")),
                                       tabPanel("HISTOGRAMA DE TENDENCIA Y DESVIACION (NN) ", uiOutput("proyeccionesAplicacionCamelHistograma"))
                                   ))
               ),
               
               ####################################################################
               # CONCLUSIONES UI
               ####################################################################
               
               navbarMenu("CONCLUSIONES Y RECOMENDACIONES",
                          tabPanel('AQUI',
                                    tabsetPanel(
                                        tabPanel("CONCLUSION GENERAL", uiOutput("conclusionesGeneral")),
                                        tabPanel("CONCLUSIONES OBJETIVOS", uiOutput("conclusionesObjetivos"))
                                        ))
                          
               ),
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    rootMainDir <- 'RECURSOS-INVESTIGACION/PRESENTACION/SHINY/'
    ####################################################################
    # INICIO
    ####################################################################
    
    output$inicio <- renderUI({
        rootDirFile <- "INICIO/INICIO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    ####################################################################
    # PERFIL
    ####################################################################
    
    output$perfilPlanteamientoProblema <- renderUI({
        rootDirFile <- "PERFIL/01-01-PLANTEAMIENTO-PROBLEMA.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$perfilProblemaCentral <- renderUI({
        rootDirFile <- "PERFIL/01-02-PROBLEMA-CENTRAL.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$perfilJustificacion <- renderUI({
        rootDirFile <- "PERFIL/01-03-JUSTIFICACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$perfilAlcance <- renderUI({
        rootDirFile <- "PERFIL/01-04-ALCANCE-DELIMITACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$perfilObjetivos <- renderUI({
        rootDirFile <- "PERFIL/01-05-OBJETIVOS-INVESTIGACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$perfilHipotesis <- renderUI({
        rootDirFile <- "PERFIL/01-06-HIPOTESIS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$perfilMetodologia <- renderUI({
        rootDirFile <- "PERFIL/01-07-MARCO-METODOLOGICO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    ####################################################################
    # MARCO TEORICO
    ####################################################################
    
    # MARCO TEORICO - FINANZAS - EVALUACION FINANCIERA
    output$marcoTeoricoFinanzasEvaluacion_Intro <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-01-01-FINANZAS-EVALUACION-FINANCIERA-INTRO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoFinanzasEvaluacion_Finanzas <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-01-02-FINANZAS-EVALUACION-FINANCIERA-FINANZAS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoFinanzasEvaluacion_EvalFin <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-01-03-FINANZAS-EVALUACION-FINANCIERA-EVAL-FIN.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoFinanzasEvaluacion_Camel <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-01-04-FINANZAS-EVALUACION-FINANCIERA-CAMEL.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # MARCO TEORICO - REDES NEURONALES
    output$marcoTeoricoRedesNeuronales_Intro <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-02-01-REDES-NEURONALES-INTRO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoRedesNeuronales_Elementos <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-02-02-REDES-NEURONALES-ELEMENTOS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoRedesNeuronales_Regresion <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-02-03-REDES-NEURONALES-REGRESION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoRedesNeuronales_Colapso <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-02-04-REDES-NEURONALES-COLAPSO-RED.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoRedesNeuronales_PropAdelante <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-02-05-REDES-NEURONALES-PROP-ADELANTE.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoRedesNeuronales_PropAtras <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-02-06-REDES-NEURONALES-PROP-ATRAS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # MARCO TEORICO - EVALUACION
    output$marcoTeoricoPronosticosEvaluacion_Intro <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-03-01-PRONOSTICOS-EVALUACION-INTRO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoPronosticosEvaluacion_PronAjuste <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-03-02-PRONOSTICOS-EVALUACION-PRONOSTICO-AJUSTE.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoPronosticosEvaluacion_Generalizacion <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-03-03-PRONOSTICOS-EVALUACION-GENERALIZACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoPronosticosEvaluacion_MCO <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-03-04-PRONOSTICOS-EVALUACION-MCO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$marcoTeoricoPronosticosEvaluacion_ARIMA <- renderUI({
        rootDirFile <- "MARCO-TEORICO/02-03-05-PRONOSTICOS-EVALUACION-ARIMA.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    ####################################################################
    # DIAGNOSTICO
    ####################################################################
    
    # PRESICIONES DIAGNOSTICO
    
    output$diagnosticoPresicionesEntidadesFinancieras <- renderUI({
        rootDirFile <- "DIAGNOSTICO/01-01-ENTIDADES-FINANCIERAS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$diagnosticoPresicionesVariablesComprendidas <- renderUI({
        rootDirFile <- "DIAGNOSTICO/01-02-VARIABLES-COMPRENDIDAS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    
    # CALCULO INDICADORES
    
    output$diagnosticoCalculoIndicadoresCapital <- renderUI({
        rootDirFile <- "DIAGNOSTICO/02-01-CI_CAPTIAL.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$diagnosticoCalculoIndicadoresActivos <- renderUI({
        rootDirFile <- "DIAGNOSTICO/02-02-CI_ACTIVOS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$diagnosticoCalculoIndicadoresAdmin <- renderUI({
        rootDirFile <- "DIAGNOSTICO/02-03_CI_ADMINISTRACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$diagnosticoCalculoIndicadoresBeneficios <- renderUI({
        rootDirFile <- "DIAGNOSTICO/02-04-BENEFICIOS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$diagnosticoCalculoIndicadoresLiquidez <- renderUI({
        rootDirFile <- "DIAGNOSTICO/02-05-CI_LIQUIDEZ.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # RANGOS Y LIMITES
    
    output$diagnosticoRangosLimites <- renderUI({
        rootDirFile <- "DIAGNOSTICO/03-01-LIMITES.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$diagnosticoRangosLimitesFlexibles <- renderUI({
        rootDirFile <- "DIAGNOSTICO/03-02-RANGOS-FLEXIBLES.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    output$diagnosticoRangosLimitesEstrictos <- renderUI({
        rootDirFile <- "DIAGNOSTICO/03-03-RANGOS-EXTRICTOS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # PONDERACION
    
    output$diagnosticoPonderacion <- renderUI({
        rootDirFile <- "DIAGNOSTICO/04-PONDERACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # RESULTADOS CAMEL
    output$diagnosticoResultadosCamelGrafico <- renderUI({
        rootDirFile <- "DIAGNOSTICO/05-01-RESULTADOS-CAMEL-GRAFICO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    output$diagnosticoResultadosCamelTabla <- renderUI({
        rootDirFile <- "DIAGNOSTICO/05-02-RESULTADOS-CAMEL-TABLA.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    ####################################################################
    # PROYECCIONES
    ####################################################################
    
    # DEFINICION PROYECCIONES
    
    output$proyeccionesPrecisionesSeriesTiempo <- renderUI({
        rootDirFile <- "PROYECCIONES/01-01-SERIES-DE-TIEMPO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesPrecisionesModelosEvaluacion <- renderUI({
        rootDirFile <- "PROYECCIONES/01-02-MODELOS-EVALUACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesPrecisionesVariablesComprendidas <- renderUI({
        rootDirFile <- "PROYECCIONES/01-03-VARIABLES-COMPRENDIDAS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # ENTRENAMIENTO EJEMPLO
    
    output$proyeccionesEntrenamientoEjemploMCO <- renderUI({
        rootDirFile <- "PROYECCIONES/02-01-MODELO-CLASICO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesEntrenamientoEjemploARIMA <- renderUI({
        rootDirFile <- "PROYECCIONES/02-02-ARIMA.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesEntrenamientoEjemploNN <- renderUI({
        rootDirFile <- "PROYECCIONES/02-03-NN.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesEntrenamientoEjemploEficiencia <- renderUI({
        rootDirFile <- "PROYECCIONES/02-04-EFICIENCIA.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesEntrenamientoEjemploSimulacion <- renderUI({
        rootDirFile <- "PROYECCIONES/02-05-SIMULACION.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # EVALUACION MODELOS POR R2
    
    output$proyeccionesEvaluarModelosAjusteModelos <- renderUI({
        rootDirFile <- "PROYECCIONES/03-01-AJUSTE-MODELOS.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesEvaluarModelosAjusteModelosResumido <- renderUI({
        rootDirFile <- "PROYECCIONES/03-02-AJUSTE-MODELOS-RESUMIDO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesEvaluarModelosAjusteProyecciones <- renderUI({
        rootDirFile <- "PROYECCIONES/03-03-AJUSTE-PROYECCIONES.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesEvaluarModelosAjusteProyeccionesResumido <- renderUI({
        rootDirFile <- "PROYECCIONES/03-04-AJUSTE-PROYECCIONES-RESUMIDO.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    # APLICACION CAMEL SOBRE PROYECCIONES
    
    output$proyeccionesAplicacionCamel <- renderUI({
        rootDirFile <- "PROYECCIONES/04-01-APLICACION-CAMEL.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    output$proyeccionesAplicacionCamelHistograma <- renderUI({
        rootDirFile <- "PROYECCIONES/04-02-HISTOGRAMA-NN-CAMEL.Rmd"
        HTML(markdown::markdownToHTML(knitr::knit(paste0(rootMainDir,rootDirFile), quiet = TRUE), fragment.only=TRUE))
    })
    
    ####################################################################
    # CONCLUSIONES
    ####################################################################
    
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
shinyApp(ui = ui, server = server)

###########################################
# DELETE FILES
filesMD_RM <- list.files('.')[grepl("\\.md", list.files('.'))]
filesMD_RM <- filesMD_RM[!(filesMD_RM %in% "README.md")]
file.remove(filesMD_RM)
