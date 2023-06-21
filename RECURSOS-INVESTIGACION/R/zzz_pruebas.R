source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/camel-get-datCamelIndicadores.R')
source('RECURSOS-INVESTIGACION/R/camel-get-limites-rangos.R')


dat1 <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
dat2 <- getDatEEFFNormalizada(by = 'TIPO_DE_ENTIDAD')
dat3 <- getDatEEFFNormalizada(by = 'ENTIDAD')


datCamelIndNorm1 <- getDatCamelIndicadores2(dat1,by='TOTAL_SISTEMA')
datCamelIndNorm2 <- getDatCamelIndicadores2(dat2,by='TIPO_DE_ENTIDAD')
datCamelIndNorm3 <- getDatCamelIndicadores2(dat3,by='ENTIDAD')

datCamelRangosLimites1 <- getDatCamelRangosLimites(datCamelIndNorm1)
datCamelRangosLimites2 <- getDatCamelRangosLimites(datCamelIndNorm2)
datCamelRangosLimites3 <- getDatCamelRangosLimites(datCamelIndNorm3)
