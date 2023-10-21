createTrendsCamelRnnModelsByEntidad <- function(n=2, entidad=NULL) {
    
    source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
    source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
    source('RECURSOS-INVESTIGACION/R/pef-list-summary-resumen.R')
    source('RECURSOS-INVESTIGACION/R/pef-get-dats-for-forescat.R')
    source('RECURSOS-INVESTIGACION/R/pef-get-ids-for-models.R')
    source("RECURSOS-INVESTIGACION/R/render-table-basic.R")
    source("RECURSOS-INVESTIGACION/R/pef-get-camel-test.R")
    
    require(dplyr)
    
    stopifnot(!is.null(entidad))
    
    datTotalSistema <- 
        getDatEEFFNormalizada(by = 'ENTIDAD')%>% 
        filter(TIPO_DE_ENTIDAD==entidad)
    
    ids <- getVariablesForModelsForecast()
    
    listResult <- 
        replicate(n = n, 
                  getListFittedAndSimulateModelsRNN(datTotalSistema,ids), 
                  simplify=FALSE) %>% 
        sapply(function(x){
            print('Next trendsCamelRNN...')
            listDatsForTestCamels <- getDatsForTestCamels(x,datTotalSistema,12,TRUE)
            result <- getCamelTestForecast(listDatsForTestCamels$nnDataForecastCuentas)
            trendCamelRnnNew <- result$TENDENCIA
            sdCamelRnnNew <- result$DESVIACION
            
            return(list(trendCamelRnnNew=trendCamelRnnNew,
                        sdCamelRnnNew=sdCamelRnnNew))
            
        }) %>% 
        t() %>% 
        as.data.frame()
    
    trendCamelRnnNew <- listResult$trendCamelRnnNew %>% as.numeric()
    sdCamelRnnNew <- listResult$sdCamelRnnNew %>% as.numeric()
    
    rootTrendCamelRNN <- paste0("FUENTES-DE-DATOS/DATA/trendCamelRNN_",entidad,".rds")
        
    if (file.exists(rootTrendCamelRNN)) {
        trendCamelRNN <- readRDS(file =rootTrendCamelRNN)
        trendCamelRNN <- append(trendCamelRNN, trendCamelRnnNew)
        saveRDS(trendCamelRNN, rootTrendCamelRNN)
    }else{
        trendCamelRNN <- trendCamelRnnNew
        saveRDS(trendCamelRNN, rootTrendCamelRNN)
    }
    
    rootSdCamelRNN <- paste0("FUENTES-DE-DATOS/DATA/sdCamelRNN_",entidad,".rds")
    
    if (file.exists(rootSdCamelRNN)) {
        sdCamelRNN <- readRDS(file =rootSdCamelRNN)
        sdCamelRNN <- append(sdCamelRNN, sdCamelRnnNew)
        saveRDS(sdCamelRNN, rootSdCamelRNN)
    }else{
        sdCamelRNN<- sdCamelRnnNew
        saveRDS(sdCamelRNN, rootSdCamelRNN)
    }
    
}

siglasEntidades <- c('BCR','BEC','BFO','BFS','BGA','BIE','BIS','BME','BNA','BNB','BPR','BSO','BUN')

for (ent in siglasEntidades){
    cat(paste0('\n', ent))
    createTrendsCamelRnnModelsByEntidad(n=10, entidad = ent)
}

