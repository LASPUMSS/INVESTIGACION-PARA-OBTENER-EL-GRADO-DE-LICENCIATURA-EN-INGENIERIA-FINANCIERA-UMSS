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
    
    trendCamelRnnNew <-  
        replicate(n = n, 
                  getListFittedAndSimulateModelsRNN(datTotalSistema,ids), 
                  simplify=FALSE) %>% 
        sapply(function(x){
            print('Next trendCamelRNN...')
            listDatsForTestCamels <- getDatsForTestCamels(x,datTotalSistema,12,TRUE)
            getCamelTestForecast(listDatsForTestCamels$nnDataForecastCuentas)$TENDENCIA
        })
    
    if (file.exists("FUENTES-DE-DATOS/DATA/trendCamelRNN.rds")) {
        trendCamelRNN <- readRDS(file ='FUENTES-DE-DATOS/DATA/trendCamelRNN.rds')
        trendCamelRNN <- append(trendCamelRNN, trendCamelRnnNew)
        saveRDS(trendCamelRNN, 'FUENTES-DE-DATOS/DATA/trendCamelRNN.rds')
    }else{
        trendCamelRNN <- trendCamelRnnNew
        saveRDS(trendCamelRNN, 'FUENTES-DE-DATOS/DATA/trendCamelRNN.rds')
    }
    
}
