source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
source('RECURSOS-INVESTIGACION/R/pef-get-ids-for-models.R')
require(dplyr)

siglasEntidades <- c('BCR','BEC','BFO','BFS','BGA','BIE','BIS','BME','BNA','BNB','BPR','BSO','BUN')


for (ent in siglasEntidades) {
    
    cat(paste0('\n', ent))
    entidad <- ent
    
    datTotalSistema <- 
        getDatEEFFNormalizada(by = 'ENTIDAD') %>% 
        filter(TIPO_DE_ENTIDAD==entidad)
    
    ids <- getVariablesForModelsForecast()
    listResultPEF <- getListFittedAndSimulateModels(datTotalSistema,ids,n_simulaicones = 100L, printEnt = TRUE)
    saveRDS(listResultPEF, file =paste0('FUENTES-DE-DATOS/DATA/listResultPEF_', entidad, '.rds'))
}



