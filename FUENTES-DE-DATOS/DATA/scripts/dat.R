
source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')

dat <- getDatEEFFNormalizada(by='TIPO_DE_ENTIDAD')

saveRDS(dat, file ='FUENTES-DE-DATOS/DATA/dat.rds')




