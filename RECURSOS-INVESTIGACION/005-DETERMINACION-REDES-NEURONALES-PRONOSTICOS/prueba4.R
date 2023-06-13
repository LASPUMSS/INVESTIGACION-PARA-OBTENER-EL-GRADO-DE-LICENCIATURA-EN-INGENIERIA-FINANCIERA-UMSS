source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
source('RECURSOS-INVESTIGACION/R/pef-list-summary-resumen.R')

datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')


ids <- c('ACTIVO',
         'PASIVO',
         'PATRIMONIO',
         'INGRESOS_FINANCIEROS',
         'GASTOS_FINANCIEROS',
         'EERR_S2_GASTOS_DE_ADMINISTRACION',
         'EERR_S2_RESULTADO_NETO_DE_LA_GESTION')

listResult <- getListFittedAndSimulateModels(datTotalSistema)
listResumeModels <- getListResumeSummaryModels(listResult)
