## PRUEBAS
source("FUENTES-DE-DATOS/DATA/scripts/appendTrendCamelRNN.R")
createTrendsCamelRnnModels(n = 50)

ids <- c('ACTIVO','PASIVO','PATRIMONIO')

datAccounts <- listDatsForTestCamels$datCuentas %>% tail(n = 1) %>% select(any_of(ids)) 
originalData <- cbind(names(datAccounts), t(datAccounts)) %>% data.frame(row.names = NULL)
names(originalData) <- c('DESCRIPCION','OBSERVADO')

datAccounts <- listDatsForTestCamels$mcoDataForecastCuentas %>% tail(n = 1)
mcoForecasData <- cbind(names(datAccounts), t(datAccounts)) %>% data.frame(row.names = NULL)
names(mcoForecasData) <- c('DESCRIPCION','MCO')

datAccounts <- listDatsForTestCamels$arimaDataForecastCuentas %>% tail(n = 1) 
arimaForecasData <- cbind(names(datAccounts), t(datAccounts)) %>% data.frame(row.names = NULL)
names(arimaForecasData) <- c('DESCRIPCION','ARIMA')

datAccounts <- listDatsForTestCamels$nnDataForecastCuentas %>% tail(n = 1)
nnForecasData <- cbind(names(datAccounts), t(datAccounts)) %>% data.frame(row.names = NULL)
names(nnForecasData) <- c('DESCRIPCION','NN')

left_join(originalData, mcoForecasData, by='DESCRIPCION') %>%
    left_join(., arimaForecasData, by='DESCRIPCION')  %>%
    left_join(., nnForecasData, by='DESCRIPCION') 
