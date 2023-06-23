getCamelTestForecast <- function(dat) {
    source('RECURSOS-INVESTIGACION/R/camel-get-datCamelIndicadores.R')
    source('RECURSOS-INVESTIGACION/R/camel-get-limites-rangos.R')
    source("RECURSOS-INVESTIGACION/R/camel-get-tabla-referencia-calificaciones.R")
    source('RECURSOS-INVESTIGACION/R/camel-calificacion-indicadores.R')
    source('RECURSOS-INVESTIGACION/R/camel-calificacion-entidad.R')
    source('RECURSOS-INVESTIGACION/R/camel-getListStatsIndicadores.R')
    source('RECURSOS-INVESTIGACION/R/camel-getListPlotsIndicadores.R')
    source('RECURSOS-INVESTIGACION/R/camel-get-datIdsNamesCamelInds.R')
    
    datCamelIndNorm <- getDatCamelIndicadores(dat=dat, by='TOTAL_SISTEMA')
    datCamelRangosLimites <- getDatCamelRangosLimites(datCamelIndNorm)
    
    
    datCamelCalificacionIndicadoresHard <- 
        getDatCamelCalificacionIndicadores(datCamelIndNorm,datCamelRangosLimites,
                                           calificacionDuro = TRUE)
    
    datCamelCalificacionEntidadSinPoderarHard <- 
        getDatCamelCalificacionEntidad(datCamelCalificacionIndicadoresHard, ponderado = FALSE)
    
    datCamelCalificacionEntidadHard <- 
        getDatCamelCalificacionEntidad(datCamelCalificacionIndicadoresHard, ponderado = TRUE)
    
    datIdsNamesCamelInds <- getDatIdsNamesCamelIndicadores()
    
    ids <- c('CAMEL')
    listResult <- getListStatsOverviewInd(ids, 
                                          datCamelCalificacionEntidadHard, 
                                          datIdsNamesCamelInds,
                                          TRUE)
    return(listResult$CAMEL$datTrendInd)
}