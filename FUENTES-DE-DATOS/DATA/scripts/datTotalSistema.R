
source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')

datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')

saveRDS(datTotalSistema, file ='FUENTES-DE-DATOS/DATA/datTotalSistema.rds')




