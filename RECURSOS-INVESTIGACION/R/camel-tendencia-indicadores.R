

getDatTrendInd <- function(id='indCap_CAP', datCamelIndNorm, idsDecreasing = FALSE) {
    
    require(fpp2)
    dat <- datCamelIndNorm
    
    dat$TIPO_DE_ENTIDAD <- gsub('_', ' ', dat$TIPO_DE_ENTIDAD)
    
    gestInc <- min(as.numeric(format(dat$FECHA, format='%Y')))
    gestFn <- max(as.numeric(format(dat$FECHA, format='%Y')))
    
    tsDat <- ts(matrix(0, nrow=(gestFn-gestInc+1)*12, ncol=length(unique(dat$TIPO_DE_ENTIDAD))), 
                start=gestInc, frequency=12)
    
    for (i in 1:length(unique(dat$TIPO_DE_ENTIDAD))) {
        
        tipoEnt <- as.character(unique(dat$TIPO_DE_ENTIDAD)[i])
        colnames(tsDat)[i] <- tipoEnt
        x <- dat[dat$TIPO_DE_ENTIDAD==tipoEnt,][order(dat[dat$TIPO_DE_ENTIDAD==tipoEnt,'FECHA']),id]
        x <- sapply(x, as.numeric)
        tsDat[,i] <- x
    }
    
    datTrendInd <- data.frame(TIPO_DE_ENTIDAD=rep(NA,length(colnames(tsDat))),
                              TENDENCIA=rep(NA,length(colnames(tsDat))))
    
    for (i in 1:(length(colnames(tsDat)))) {
        
        valor <- colnames(tsDat)[i]
        
        if (all(is.na(tsDat[,valor]))) {
            
            datTrendInd[i,1] <- valor
            datTrendInd[i,2] <- NA
            
        } else {
        
            fit <- tslm(tsDat[,valor]~trend)
            datTrendInd[i,1] <- valor
            datTrendInd[i,2] <- fit$coefficients[2]
        }
    }
    
    datTrendInd <- datTrendInd[order(datTrendInd$TENDENCIA,decreasing = idsDecreasing),]
    
    datResult <- data.frame(TIPO_DE_ENTIDAD=datTrendInd$TIPO_DE_ENTIDAD,
                            TENDENCIA=datTrendInd$TENDENCIA)
    
    return(datResult)
}







