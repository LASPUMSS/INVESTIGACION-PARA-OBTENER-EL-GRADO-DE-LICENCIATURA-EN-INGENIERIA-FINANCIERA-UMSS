source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
source('RECURSOS-INVESTIGACION/R/get-ts-from-dat.R')

library(fpp2)
library(dplyr)
library(lubridate)

datNorm <- getDatEEFFNormalizada(by = 'TIPO_DE_ENTIDAD')

dat <- 
    datNorm %>% 
    group_by(FECHA) %>% 
    summarise_if(is.numeric, sum)

gestionFn <- max(dat$FECHA) - years(1)

datTrain <- dat %>% filter(FECHA<gestionFn)
datTest <- dat %>% filter(FECHA>gestionFn)

id <- 'ACTIVO'
tsDatTrain <- getTsFromDat2(id,datTrain)
tsDatTest <- getTsFromDat2(id,datTest)

mcoModel <- tslm(tsDatTrain~trend)
nnModel <- nnetar(tsDatTrain)

mcoForecast <- forecast(mcoModel, h = 13)
nnForecast <- forecast(nnModel,h = 13)

autoplot(tsDatTrain) + 
    autolayer(mcoForecast, PI = F, series = 'MCO') + 
    autolayer(nnForecast, series = 'NN')  + 
    autolayer(tsDatTest)



