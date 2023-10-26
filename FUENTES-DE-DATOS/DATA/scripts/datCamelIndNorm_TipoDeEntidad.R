
source('RECURSOS-INVESTIGACION/R/camel-get-datCamelIndicadores.R')

if (!('dat' %in% ls())) {dat <- NULL}
datCamelIndNorm <- getDatCamelIndicadores(dat=dat, by='TIPO_DE_ENTIDAD')

saveRDS(datCamelIndNorm, file ='FUENTES-DE-DATOS/DATA/datCamelIndNorm_TipoDeEntidad.rds')




