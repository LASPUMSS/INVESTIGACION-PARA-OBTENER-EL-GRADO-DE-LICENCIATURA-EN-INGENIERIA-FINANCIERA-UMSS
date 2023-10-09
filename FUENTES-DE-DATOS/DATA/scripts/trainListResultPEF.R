source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
source('RECURSOS-INVESTIGACION/R/pef-get-ids-for-models.R')
require(dplyr)

datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
ids <- getVariablesForModelsForecast()
listResultPEF <- getListFittedAndSimulateModels(datTotalSistema,ids,n_simulaicones = 100L)
saveRDS(listResultPEF, file ='FUENTES-DE-DATOS/DATA/listResultPEF.rds')
