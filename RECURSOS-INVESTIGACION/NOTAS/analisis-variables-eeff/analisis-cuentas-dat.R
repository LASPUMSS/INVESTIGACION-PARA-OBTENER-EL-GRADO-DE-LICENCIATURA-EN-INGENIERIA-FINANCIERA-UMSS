source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
source('RECURSOS-INVESTIGACION/R/get-ts-from-dat.R')

library(fpp2)

datNorm <- getDatEEFFNormalizada(by = 'ENTIDAD')

datTest <- datNorm %>% filter(TIPO_DE_ENTIDAD=='CJB' )

id <- 'EERR_S2_GASTOS_DE_ADMINISTRACION'
tsDat <- getTsFromDat(id,datTest)
autoplot(tsDat)


id <- 'ACTIVO'
tsDat <- getTsFromDat(id,datTest)
autoplot(tsDat)


id <- 'CUENTAS_CONTINGENTES_DEUDORAS'
plotIndCamel(id = id,datTest )
