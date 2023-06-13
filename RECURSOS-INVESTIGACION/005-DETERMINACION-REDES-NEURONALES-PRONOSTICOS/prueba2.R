source('RECURSOS-INVESTIGACION/R/pef-simulate-ts-models.R')
source('RECURSOS-INVESTIGACION/R/pef-fitted-ts-models.R')
source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
source('RECURSOS-INVESTIGACION/R/get-ts-from-dat.R')

library(fpp2)
library(dplyr)
library(lubridate)
library(ggplot2)
library(patchwork)

dat <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')

gestionFn <- max(dat$FECHA) - years(1) + 4
datTrain <- dat %>% filter(FECHA<gestionFn)
datTest <- dat %>% filter(FECHA>gestionFn)

ids <- c('ACTIVO',
         'PASIVO',
         'PATRIMONIO',
         'INGRESOS_FINANCIEROS',
         'GASTOS_FINANCIEROS',
         'EERR_S2_GASTOS_DE_ADMINISTRACION',
         'EERR_S2_RESULTADO_NETO_DE_LA_GESTION')

id <- 'INGRESOS_FINANCIEROS'

tsDatTrain <- getTsFromDat2(id,datTrain)
tsDatTest <- getTsFromDat2(id,datTest)

mcoModel <- tslm(tsDatTrain~trend+season)
nnModel <- nnetar(tsDatTrain)
arimaModel <- auto.arima(tsDatTrain)

# Ajuste de modelos
r2mcoModel <- fittedTsModels(mcoModel,tsDatTrain)
r2nnModel <- fittedTsModels(nnModel,tsDatTrain)
r2arimaModel <- fittedTsModels(arimaModel,tsDatTrain)

# Simulación de modelos
n_simulaicones <- 1000L
n_proyeciones <- 12L

mcoModelSimulate <- simulateTsModels(mcoModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
nnModelSimulate <- simulateTsModels(nnModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
arimaModelSimulate <- simulateTsModels(arimaModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)

# Gráficos
p1 <- data.frame(r2Model=mcoModelSimulate$r2Model) %>%  ggplot(aes(x=r2Model)) + geom_histogram()
p2 <- data.frame(r2Model=nnModelSimulate$r2Model) %>%  ggplot(aes(x=r2Model)) + geom_histogram()
p3 <- data.frame(r2Model=arimaModelSimulate$r2Model) %>%  ggplot(aes(x=r2Model)) + geom_histogram()

p <- (p1/p2/p3)
p
