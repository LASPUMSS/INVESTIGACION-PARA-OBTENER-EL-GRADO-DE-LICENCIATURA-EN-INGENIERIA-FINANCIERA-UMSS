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

gestionFn <- max(dat$FECHA) - years(1) + 4

datTrain <- dat %>% filter(FECHA<gestionFn)
datTest <- dat %>% filter(FECHA>gestionFn)

id <- 'EERR_S2_GASTOS_DE_ADMINISTRACION'
tsDatTrain <- getTsFromDat2(id,datTrain)
tsDatTest <- getTsFromDat2(id,datTest)

mcoModel <- tslm(tsDatTrain~trend)
nnModel <- nnetar(tsDatTrain)

mcoForecast <- forecast(mcoModel, h = 12)
nnForecast <- forecast(nnModel,h = 12)

autoplot(tsDatTrain) + 
    autolayer(mcoForecast, PI = F, series = 'MCO') + 
    autolayer(nnForecast, series = 'NN')  + 
    autolayer(tsDatTest)

r2_nn <- (cor(nnForecast$mean, tsDatTest))^2
r2_mco <- (cor(mcoForecast$mean, tsDatTest))^2

# simular 
sim <- ts(matrix(0, nrow=12L, ncol=9L),
          start=end(tsDatTrain)[1L]+1L, frequency = 12)
for(i in seq(9)){
    
    sim[,i] <- simulate(nnModel, nsim=12L)
    
}
autoplot(tsDatTrain) + autolayer(sim)


sim <- ts(matrix(0, nrow=12L, ncol=9L),
          start=end(tsDatTrain)[1L]+1L, frequency = 12)
for(i in seq(9)){
    
    sim[,i] <- simulate(mcoModel, nsim=12L)
    
}
autoplot(tsDatTrain) + autolayer(sim)
