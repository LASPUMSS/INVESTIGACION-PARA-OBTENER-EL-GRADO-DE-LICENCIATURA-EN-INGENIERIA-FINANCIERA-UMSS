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
        
        result <- list(simulate=sim, 
                       r2Model=r2Model, 
                       r2Mean=mean(r2Model, na.rm=TRUE))
        
    } else {
        
        sim <- ts(matrix(0, nrow=n_proyeciones, ncol=n_simulaicones),
                  start=end(tsDatTrain)[1L]+1L, frequency = frequency(tsDatTrain))
        r2Model <- rep(0,n_simulaicones)
        
        for(i in seq(n_simulaicones)){
            
            sim[,i] <- simulate(object, nsim=n_proyeciones)
            r2Model[i] <- (cor(sim[,i], tsDatTest))^2
            
        }
        
        result <- list(simulate=sim, 
                       r2Model=r2Model, 
                       r2Mean=mean(r2Model, na.rm=TRUE))
    }
    
}
