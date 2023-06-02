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

id <- 'EERR_S2_GASTOS_DE_ADMINISTRACION'
tsDatTrain <- getTsFromDat2(id,datTrain)
tsDatTest <- getTsFromDat2(id,datTest)

mcoModel <- tslm(tsDatTrain~trend)
nnModel <- nnetar(tsDatTrain)
arimaModel <- auto.arima(tsDatTrain)
arModel <- arfima(tsDatTrain)

mcoForecast <- forecast(mcoModel, h = 12,level = c(99))
nnForecast <- forecast(nnModel,h = 12, level = c(99))

autoplot(tsDatTrain) + 
    autolayer(mcoForecast, PI = T, series = 'MCO') + 
    autolayer(nnForecast, series = 'NN', PI = T)  + 
    autolayer(tsDatTest)

r2_nn <- (cor(nnForecast$mean, tsDatTest))^2
r2_mco <- (cor(mcoForecast$mean, tsDatTest))^2

# simular 

n_simulaicones <- 9L
n_proyeciones <- 12L



###########################################################################

sim <- ts(matrix(0, nrow=12L, ncol=n_simulaicones),
          start=end(tsDatTrain)[1L]+1L, frequency = 12)
r2_nn <- rep(0,n_simulaicones)

for(i in seq(n_simulaicones)){
    
    sim[,i] <- simulate(nnModel, nsim=12L)
    r2_nn[i] <- (cor(sim[,i], tsDatTest))^2
    
}

hist(r2_nn)
autoplot(tsDatTrain) + autolayer(sim)


sim <- ts(matrix(0, nrow=12L, ncol=n_simulaicones),
          start=end(tsDatTrain)[1L]+1L, frequency = 12)
r2_mco <- rep(0,n_simulaicones)

for(i in seq(n_simulaicones)){
    
    res <- na.omit(c(mcoModel$residuals - mean(mcoModel$residuals, na.rm = TRUE)))
    res <- sample(res,n_proyeciones,replace = T)
    
    sim[,i] <- mcoForecast$mean + res
    #x <- forecast(mcoModel, h = 12,newdata = tail(simulate(mcoModel),n = 12))
    #x$mean
    r2_mco[i] <- (cor(sim[,i], tsDatTest))^2
    
}

hist(r2_mco)
autoplot(tsDatTrain) + autolayer(sim)

p1 <- data.frame(r2_mco) %>%  ggplot(aes(x=r2_mco)) + geom_histogram()
p2 <- data.frame(r2_nn) %>%  ggplot(aes(x=r2_nn)) + geom_histogram()

p1/p2


###############################################
simulateTsModels <- function(object,n_simulaicones=9L,n_proyeciones=12L, tsDatTest, tsDatTrain) {
    
    if ("tslm" %in% class(object)) {
        
        sim <- ts(matrix(0, nrow=n_proyeciones, ncol=n_simulaicones),
                  start=end(tsDatTrain)[1L]+1L, frequency = frequency(tsDatTrain))
        
        modelForecast <- forecast(object, h = n_proyeciones)
        res <- na.omit(c(object$residuals - mean(object$residuals, na.rm = TRUE)))
        
        r2Model <- rep(0,n_simulaicones)
        
        for(i in seq(n_simulaicones)){
            
            error <- sample(res,n_proyeciones,replace = T)
            sim[,i] <- modelForecast$mean + error
            r2Model[i] <- (cor(sim[,i], tsDatTest))^2
            
        }
        
        result <- list(simulate=sim, r2Model=r2Model)
        
    } else {
        
        sim <- ts(matrix(0, nrow=n_proyeciones, ncol=n_simulaicones),
                  start=end(tsDatTrain)[1L]+1L, frequency = frequency(tsDatTrain))
        r2Model <- rep(0,n_simulaicones)
        
        for(i in seq(n_simulaicones)){
            
            sim[,i] <- simulate(object, nsim=n_proyeciones)
            r2Model[i] <- (cor(sim[,i], tsDatTest))^2
            
        }
        
        result <- list(simulate=sim, r2Model=r2Model)
    }
    
}
