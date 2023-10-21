source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
source('RECURSOS-INVESTIGACION/R/pef-list-summary-resumen.R')
source('RECURSOS-INVESTIGACION/R/pef-get-dats-for-forescat.R')
source('RECURSOS-INVESTIGACION/R/pef-get-ids-for-models.R')
source("RECURSOS-INVESTIGACION/R/pef-get-camel-test.R")
source("RECURSOS-INVESTIGACION/R/render-table-basic.R")

require(kableExtra)
require(patchwork)
require(ggplot2)
require(scales)
require(dplyr)
require(fpp2)

datTotalSistema3 <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
datTotalSistema2 <- getDatEEFFNormalizada(by='TIPO_DE_ENTIDAD')

entidad <- 'BME'
datTotalSistema <- 
    getDatEEFFNormalizada(by='ENTIDAD') %>% 
    filter(TIPO_DE_ENTIDAD=='BME')

ids <- getVariablesForModelsForecast()

listResultPEF <- getListFittedAndSimulateModels(datTotalSistema,ids)

