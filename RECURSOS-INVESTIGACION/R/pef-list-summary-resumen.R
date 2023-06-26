getListResumeSummaryModels <- function(listResult) {
    
    require(dplyr)
    
    # AJUSTE DE MODELO
    r2nnModelMean <-  sapply(listResult, function(x) x[['r2nnModel']]) %>% mean(na.rm = TRUE)
    r2mcoModelMean <-  sapply(listResult, function(x) x[['r2mcoModel']]) %>% mean(na.rm = TRUE) 
    r2arimaModelMean <-  sapply(listResult, function(x) x[['r2arimaModel']]) %>% mean(na.rm = TRUE)
    
    # AJUSTE DE SIMULAICON DE PROYECCIONES
    nnModelSimulateR2Mean <-  sapply(listResult, function(x) x[['nnModelSimulate']][['r2Mean']]) %>% mean(na.rm = TRUE)
    mcoModelSimulateR2Mean <-  sapply(listResult, function(x) x[['mcoModelSimulate']][['r2Mean']]) %>% mean(na.rm = TRUE)
    arimaModelSimulateR2Mean <-  sapply(listResult, function(x) x[['arimaModelSimulate']][['r2Mean']]) %>% mean(na.rm = TRUE)
    
    # DATAFRAMES RESUMENES
    r2ModelsResum <- data.frame(
        CUENTAS = sapply(listResult, function(x) x[['r2mcoModel']]) %>% names(),
        NN = sapply(listResult, function(x) x[['r2nnModel']]),
        MCO = sapply(listResult, function(x) x[['r2mcoModel']]),
        ARIMA = sapply(listResult, function(x) x[['r2arimaModel']]),
        row.names = NULL
    )
    
    r2ForecastResum <- data.frame(
        CUENTAS = sapply(listResult, function(x) x[['mcoModelSimulate']][['r2Mean']]) %>% names(),
        NN = sapply(listResult, function(x) x[['nnModelSimulate']][['r2Mean']]),
        MCO = sapply(listResult, function(x) x[['mcoModelSimulate']][['r2Mean']]),
        ARIMA = sapply(listResult, function(x) x[['arimaModelSimulate']][['r2Mean']]),
        row.names = NULL
    )
    
    r2ModelsResumMean <- data.frame(
        MODELOS = c('NN','MCO','ARIMA'),
        R2_PROMEDIO = c(r2nnModelMean, r2mcoModelMean, r2arimaModelMean) ,
        row.names = NULL
    )
    
    r2ForecastResumMean <- data.frame(
        MODELOS = c('NN','MCO','ARIMA'),
        R2_PROMEDIO = c(nnModelSimulateR2Mean, mcoModelSimulateR2Mean, arimaModelSimulateR2Mean) ,
        row.names = NULL
    )
    
    listResult2 <- list(r2ModelsResum=r2ModelsResum,
                        r2ForecastResum=r2ForecastResum,
                        r2ModelsResumMean=r2ModelsResumMean,
                        r2ForecastResumMean=r2ForecastResumMean
    )
    
    return(listResult2)
    
}
