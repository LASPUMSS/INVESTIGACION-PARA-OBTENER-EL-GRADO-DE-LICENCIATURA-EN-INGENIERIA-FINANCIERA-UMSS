source('RECURSOS-INVESTIGACION/R/pef-simulate-ts-models.R')
source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
source('RECURSOS-INVESTIGACION/R/get-ts-from-dat.R')

library(fpp2)
library(dplyr)
library(lubridate)
library(ggplot2)
library(patchwork)

datNorm <- getDatEEFFNormalizada(by = 'TIPO_DE_ENTIDAD', na.cero=TRUE)

dat <- 
    datNorm %>% 
    group_by(FECHA) %>% 
    summarise_if(is.numeric, sum)

gestionFn <- max(dat$FECHA) - years(1) + 4
datTrain <- dat %>% filter(FECHA<gestionFn)
datTest <- dat %>% filter(FECHA>gestionFn)

ids <- c('ACTIVO','PASIVO','PATRIMONIO')
id <- 'EERR_S2_GASTOS_DE_ADMINISTRACION'
id <- 'ACTIVO'

tsDatTrain <- getTsFromDat2(id,datTrain)
tsDatTest <- getTsFromDat2(id,datTest)

mcoModel <- tslm(tsDatTrain~trend)
nnModel <- nnetar(tsDatTrain)
arimaModel <- auto.arima(tsDatTrain)
arModel <- arfima(tsDatTrain)

# simular 

n_simulaicones <- 1000L
n_proyeciones <- 12L

mcoModelSimulate <- simulateTsModels(mcoModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
nnModelSimulate <- simulateTsModels(nnModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
arimaModelSimulate <- simulateTsModels(arimaModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
arModelSimulate <- simulateTsModels(arModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)


p1 <- data.frame(r2Model=mcoModelSimulate$r2Model) %>%  ggplot(aes(x=r2Model)) + geom_histogram()
p2 <- data.frame(r2Model=nnModelSimulate$r2Model) %>%  ggplot(aes(x=r2Model)) + geom_histogram()
p3 <- data.frame(r2Model=arimaModelSimulate$r2Model) %>%  ggplot(aes(x=r2Model)) + geom_histogram()
p4 <- data.frame(r2Model=arModelSimulate$r2Model) %>%  ggplot(aes(x=r2Model)) + geom_histogram()


p1/p2/p3/p4
