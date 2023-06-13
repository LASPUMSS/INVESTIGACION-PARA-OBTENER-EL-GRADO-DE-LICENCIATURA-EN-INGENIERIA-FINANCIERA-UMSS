source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')

datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')


ids <- c('ACTIVO',
         'PASIVO',
         'PATRIMONIO',
         'INGRESOS_FINANCIEROS',
         'GASTOS_FINANCIEROS',
         'EERR_S2_GASTOS_DE_ADMINISTRACION',
         'EERR_S2_RESULTADO_NETO_DE_LA_GESTION')

listResult <- getListFittedAndSimulateModels(datTotalSistema)

# AJUSTE DE MODELO
r2nnModelMean <-  sapply(listResult, function(x) x[['r2nnModel']]) %>% mean()
r2mcoModelMean <-  sapply(listResult, function(x) x[['r2mcoModel']]) %>% mean() 
r2arimaModelMean <-  sapply(listResult, function(x) x[['r2arimaModel']]) %>% mean()

# AJUSTE DE SIMULAICON DE PROYECCIONES
nnModelSimulateR2Mean <-  sapply(listResult, function(x) x[['nnModelSimulate']][['r2Mean']]) %>% mean()
mcoModelSimulateR2Mean <-  sapply(listResult, function(x) x[['mcoModelSimulate']][['r2Mean']]) %>% mean()
arimaModelSimulateR2Mean <-  sapply(listResult, function(x) x[['arimaModelSimulate']][['r2Mean']]) %>% mean()

# DATAFRAMES RESUMENES
r2ModelsResum <- data.frame(
    CUENTAS = sapply(listResult, function(x) x[['r2mcoModel']]) %>% names(),
    NN = sapply(listResult, function(x) x[['r2nnModel']]),
    MCO = sapply(listResult, function(x) x[['r2mcoModel']]),
    ARIMA = sapply(listResult, function(x) x[['r2arimaModel']])
)

r2ForecastResum <- data.frame(
    CUENTAS = sapply(listResult, function(x) x[['mcoModelSimulate']][['r2Mean']]) %>% names(),
    NN = sapply(listResult, function(x) x[['nnModelSimulate']][['r2Mean']]),
    MCO = sapply(listResult, function(x) x[['mcoModelSimulate']][['r2Mean']]),
    ARIMA = sapply(listResult, function(x) x[['arimaModelSimulate']][['r2Mean']])
)

r2ModelsResumMean <- data.frame(
    MODELOS = c('NN','MCO','ARIMA'),
    R2_PROMEDIO = c(r2nnModelMean, r2mcoModelMean, r2arimaModelMean) 
)

r2ForecastResumMean <- data.frame(
    MODELOS = c('NN','MCO','ARIMA'),
    R2_PROMEDIO = c(nnModelSimulateR2Mean, mcoModelSimulateR2Mean, arimaModelSimulateR2Mean) 
)
