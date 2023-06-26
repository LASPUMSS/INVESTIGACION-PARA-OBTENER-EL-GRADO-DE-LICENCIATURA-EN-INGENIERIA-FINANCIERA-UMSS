source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
source('RECURSOS-INVESTIGACION/R/pef-list-summary-resumen.R')
source('RECURSOS-INVESTIGACION/R/pef-get-dats-for-forescat.R')
source("RECURSOS-INVESTIGACION/R/render-table-basic.R")

if (!('listResultPEF' %in% ls())) {
    datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
    
    ids <- c('ACTIVO',
             'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VENCIDA')
    
    listResultPEF <- getListFittedAndSimulateModels(datTotalSistema,ids)
    listResumeModels <- getListResumeSummaryModels(listResultPEF)
    listDatsForTestCamels <- getDatsForTestCamels(listResultPEF,datTotalSistema,12,TRUE)
}

######################################################################

source("RECURSOS-INVESTIGACION/R/pef-get-camel-test.R")
require(dplyr)


originalCamelTest <- getCamelTestForecast(listDatsForTestCamels$datCuentas)
nnCamelTest <- getCamelTestForecast(listDatsForTestCamels$nnDataForecastCuentas)
mcoCamelTest <- getCamelTestForecast(listDatsForTestCamels$mcoDataForecastCuentas)
arimaCamelTest <- getCamelTestForecast(listDatsForTestCamels$arimaDataForecastCuentas)


camelTestModels <- bind_rows(originalCamelTest,
                             nnCamelTest,
                             mcoCamelTest,
                             arimaCamelTest)


