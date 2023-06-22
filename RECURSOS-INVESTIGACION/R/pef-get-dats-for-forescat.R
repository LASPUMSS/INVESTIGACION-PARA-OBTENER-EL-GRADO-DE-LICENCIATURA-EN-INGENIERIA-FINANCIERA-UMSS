source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
source('RECURSOS-INVESTIGACION/R/pef-list-summary-resumen.R')
source("RECURSOS-INVESTIGACION/R/render-table-basic.R")

if (!('listResultPEF' %in% ls())) {
    datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
    
    ids <- c('ACTIVO',
             'PASIVO',
             'PATRIMONIO',
             'INGRESOS_FINANCIEROS',
             'GASTOS_FINANCIEROS',
             'EERR_S2_GASTOS_DE_ADMINISTRACION',
             'EERR_S2_RESULTADO_NETO_DE_LA_GESTION')
    
    listResultPEF <- getListFittedAndSimulateModels(datTotalSistema,ids)
    listResumeModels <- getListResumeSummaryModels(listResultPEF)
}

# DAT ORIGINAL
datCuentas <- 
    sapply(listResultPEF, 
           function(cuentas){
               
               tsTrain <- cuentas[['tsDatTrain']]
               tsTest <- cuentas[['tsDatTest']]
               
               result <- ts(c(tsTrain,tsTest), 
                            start=start(tsTrain), 
                            frequency = frequency(tsTrain))
               
               result
               
           }
    ) %>% 
    data.frame() %>% 
    mutate(FECHA=datTotalSistema$FECHA, 
           TIPO_DE_ENTIDAD=datTotalSistema$TIPO_DE_ENTIDAD,
           ID=datTotalSistema$ID) %>% 
    relocate(FECHA, .before = ACTIVO) %>% 
    relocate(TIPO_DE_ENTIDAD, .after = FECHA) %>% 
    relocate(ID, .before = FECHA)

# MCO MODEL
mcoDataForecastCuentas <- 
    sapply(listResultPEF, 
       function(cuentas){
           
           tsTrain <- cuentas[['tsDatTrain']]
           tsForecast <- cuentas[['mcoModel']] %>% forecast(h=12)
           tsForecast <-  tsForecast$mean
           
           result <- ts(c(tsTrain,tsForecast), 
                        start=start(tsTrain), 
                        frequency = frequency(tsTrain))
           
           result
           
           }
    ) %>% 
    data.frame() %>% 
    mutate(FECHA=datTotalSistema$FECHA, 
           TIPO_DE_ENTIDAD=datTotalSistema$TIPO_DE_ENTIDAD,
           ID=datTotalSistema$ID) %>% 
    relocate(FECHA, .before = ACTIVO) %>% 
    relocate(TIPO_DE_ENTIDAD, .after = FECHA) %>% 
    relocate(ID, .before = FECHA)

# NN MODEL
nnDataForecastCuentas <- 
    sapply(listResultPEF, 
       function(cuentas){
           
           tsTrain <- cuentas[['tsDatTrain']]
           tsForecast <- cuentas[['nnModel']] %>% forecast(h=12)
           tsForecast <-  tsForecast$mean
           
           result <- ts(c(tsTrain,tsForecast), 
                        start=start(tsTrain), 
                        frequency = frequency(tsTrain))
           
           result
           
       }
) %>% 
    data.frame() %>% 
    mutate(FECHA=datTotalSistema$FECHA, 
           TIPO_DE_ENTIDAD=datTotalSistema$TIPO_DE_ENTIDAD,
           ID=datTotalSistema$ID) %>% 
    relocate(FECHA, .before = ACTIVO) %>% 
    relocate(TIPO_DE_ENTIDAD, .after = FECHA) %>% 
    relocate(ID, .before = FECHA)

# ARIMA MODEL
arimaDataForecastCuentas <-  
    sapply(listResultPEF, 
       function(cuentas){
           
           tsTrain <- cuentas[['tsDatTrain']]
           tsForecast <- cuentas[['arimaModel']] %>% forecast(h=12)
           tsForecast <-  tsForecast$mean
           
           result <- ts(c(tsTrain,tsForecast), 
                        start=start(tsTrain), 
                        frequency = frequency(tsTrain))
           
           result
           
       }
) %>% 
    data.frame() %>% 
    mutate(FECHA=datTotalSistema$FECHA, 
           TIPO_DE_ENTIDAD=datTotalSistema$TIPO_DE_ENTIDAD,
           ID=datTotalSistema$ID) %>% 
    relocate(FECHA, .before = ACTIVO) %>% 
    relocate(TIPO_DE_ENTIDAD, .after = FECHA) %>% 
    relocate(ID, .before = FECHA)


listDataForecastCuentas <- 
    list(datCuentas=datCuentas,
         nnDataForecastCuentas=nnDataForecastCuentas,
         mcoDataForecastCuentas=mcoDataForecastCuentas,
         arimaDataForecastCuentas=arimaDataForecastCuentas
         )
