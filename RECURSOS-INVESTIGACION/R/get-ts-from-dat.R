getTsFromDat <- function(id, dat) {
    
    dat$TIPO_DE_ENTIDAD <- gsub('_', ' ', dat$TIPO_DE_ENTIDAD)
    
    gestInc <- min(as.numeric(format(dat$FECHA, format='%Y')))
    gestFn <- max(as.numeric(format(dat$FECHA, format='%Y')))
    
    tsDat <- ts(matrix(0, nrow=(gestFn-gestInc+1)*12, ncol=length(unique(dat$TIPO_DE_ENTIDAD))), 
                start=gestInc, frequency=12)
    
    for (i in 1:length(unique(dat$TIPO_DE_ENTIDAD))) {
        
        tipoEnt <- as.character(unique(dat$TIPO_DE_ENTIDAD)[i])
        colnames(tsDat)[i] <- tipoEnt
        #x <- dat %>% filter(TIPO_DE_ENTIDAD==tipoEnt) %>% select(id)
        x <- dat[dat$TIPO_DE_ENTIDAD==tipoEnt,][order(dat[dat$TIPO_DE_ENTIDAD==tipoEnt,'FECHA']),id]
        x <- sapply(x, as.numeric)
        tsDat[,i] <- x
    }
    
    return(tsDat)
}


getTsFromDat2 <- function(id, dat) {
    
    gestInc <- min(as.numeric(format(dat$FECHA, format='%Y')))
    gestFn <- max(as.numeric(format(dat$FECHA, format='%Y')))
    
    tsDat <- ts(dat[,id], start=gestInc, frequency=12)
    

    
    return(tsDat)
}