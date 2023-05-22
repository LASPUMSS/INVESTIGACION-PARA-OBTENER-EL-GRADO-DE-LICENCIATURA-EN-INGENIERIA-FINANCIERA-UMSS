source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
source('RECURSOS-INVESTIGACION/R/get-ts-from-dat.R')

library(fpp2)
library(dplyr)

datNorm <- getDatEEFFNormalizada(by = 'TIPO_DE_ENTIDAD')

x <- 
    datNorm %>% 
    group_by(FECHA) %>% 
    summarise_if(is.numeric, sum)

id <- 'EERR_S2_GASTOS_DE_ADMINISTRACION'
tsDat <- getTsFromDat2(id,x)

autoplot(tsDat)

mcoModel <- tslm(tsDat~trend)
nnModel <- nnetar(tsDat)

mcoForecast <- forecast(mcoModel, h = 24)
nnForecast <- forecast(nnModel,h = 24)

autoplot(tsDat) + autolayer(mcoForecast, PI = F) + autolayer(nnForecast)



