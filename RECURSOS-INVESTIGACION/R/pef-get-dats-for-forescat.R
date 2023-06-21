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

x <- forecast(listResultPEF$ACTIVO$arimaModel,h = 12)
x$mean

x2 <- ts(c(listResultPEF$ACTIVO$tsDatTrain,x$mean),
        start = start(listResultPEF$ACTIVO$tsDatTrain), 
        frequency = frequency(listResultPEF$ACTIVO$tsDatTrain))
x2

