getDatsForTestCamels <- function(listResultPEF, nF=12) {
    
    require(dplyr)
    
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
                   tsForecast <- cuentas[['mcoModel']] %>% forecast(h=nF)
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
                   tsForecast <- cuentas[['nnModel']] %>% forecast(h=nF)
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
                   tsForecast <- cuentas[['arimaModel']] %>% forecast(h=nF)
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
    
    return(listDataForecastCuentas)
    
    
}

