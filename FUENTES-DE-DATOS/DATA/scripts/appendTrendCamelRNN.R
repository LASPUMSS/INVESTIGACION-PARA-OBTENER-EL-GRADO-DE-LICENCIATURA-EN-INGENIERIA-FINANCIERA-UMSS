createTrendsCamelRnnModels <- function(n=2) {
    
    source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
    source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
    source('RECURSOS-INVESTIGACION/R/pef-list-summary-resumen.R')
    source('RECURSOS-INVESTIGACION/R/pef-get-dats-for-forescat.R')
    source('RECURSOS-INVESTIGACION/R/pef-get-ids-for-models.R')
    source("RECURSOS-INVESTIGACION/R/render-table-basic.R")
    source("RECURSOS-INVESTIGACION/R/pef-get-camel-test.R")
    
    require(dplyr)
    
    datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
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
    
    
    if (file.exists("FUENTES-DE-DATOS/DATA/trendCamelRNN.rds")) {
        trendCamelRNN <- readRDS(file ='FUENTES-DE-DATOS/DATA/trendCamelRNN.rds')
        trendCamelRNN <- append(trendCamelRNN, trendCamelRnnNew)
        saveRDS(trendCamelRNN, 'FUENTES-DE-DATOS/DATA/trendCamelRNN.rds')
    }else{
        trendCamelRNN <- trendCamelRnnNew
        saveRDS(trendCamelRNN, 'FUENTES-DE-DATOS/DATA/trendCamelRNN.rds')
    }
    
    if (file.exists("FUENTES-DE-DATOS/DATA/sdCamelRNN.rds")) {
        sdCamelRNN <- readRDS(file ='FUENTES-DE-DATOS/DATA/sdCamelRNN.rds')
        sdCamelRNN <- append(sdCamelRNN, sdCamelRnnNew)
        saveRDS(sdCamelRNN, 'FUENTES-DE-DATOS/DATA/sdCamelRNN.rds')
    }else{
        sdCamelRNN<- sdCamelRnnNew
        saveRDS(sdCamelRNN, 'FUENTES-DE-DATOS/DATA/sdCamelRNN.rds')
    }
    
}

createTrendsCamelRnnModels(n=20)
