
getDatCamelCalificacionEntidad <- function(datCamelCalificacionIndicadores, ponderado=TRUE) {
    
    dat <- datCamelCalificacionIndicadores
    x <- names(dat[,!(names(dat) %in% c('ID','FECHA','TIPO_DE_ENTIDAD'))])
    
    CAMEL_C <- 0.3
    CAMEL_A <- 0.25
    CAMEL_M <- 0.10
    CAMEL_E <- 0.15
    CAMEL_L <- 0.20
    
    for (i in x) {
        
        
        valor <- 'indCap_'
        if (grepl(valor, i)) {
            n <- sum(grepl(valor, x))
            dat[,i] <- dat[,i]*ifelse(ponderado,CAMEL_C,1)/n
        }
        
        valor <- 'indAct_'
        if (grepl(valor, i)) {
            n <- sum(grepl(valor, x))
            dat[,i] <- dat[,i]*ifelse(ponderado,CAMEL_A,1)/n
        }
        
        valor <- 'indAdm_'
        if (grepl(valor, i)) {
            n <- sum(grepl(valor, x))
            dat[,i] <- dat[,i]*ifelse(ponderado,CAMEL_M,1)/n
        }
        
        valor <- 'indBenf_'
        if (grepl(valor, i)) {
            n <- sum(grepl(valor, x))
            dat[,i] <- dat[,i]*ifelse(ponderado,CAMEL_E,1)/n
        }
        
        valor <- 'indLq_'
        if (grepl(valor, i)) {
            n <- sum(grepl(valor, x))
            dat[,i] <- dat[,i]*ifelse(ponderado,CAMEL_L,1)/n
        }
    }
    
    
    result <- data.frame(ID=dat$ID,
                         FECHA=dat$FECHA,
                         TIPO_DE_ENTIDAD=dat$TIPO_DE_ENTIDAD,
                         C=rep(0,nrow(dat)),
                         A=rep(0,nrow(dat)),
                         M=rep(0,nrow(dat)),
                         E=rep(0,nrow(dat)),
                         L=rep(0,nrow(dat)),
                         CAMEL=rep(0,nrow(dat)))
    for (i in x) {
        
        result[,'CAMEL'] <- result[,'CAMEL'] + dat[,i]
        
        valor <- 'indCap_'
        if (grepl(valor, i)) {
            result[,'C'] <- result[,'C'] + dat[,i]
        }
        
        valor <- 'indAct_'
        if (grepl(valor, i)) {
            result[,'A'] <- result[,'A'] + dat[,i]
        }
        
        valor <- 'indAdm_'
        if (grepl(valor, i)) {
            result[,'M'] <- result[,'M'] + dat[,i]
        }
        
        valor <- 'indBenf_'
        if (grepl(valor, i)) {
            result[,'E'] <- result[,'E'] + dat[,i]
        }
        
        valor <- 'indLq_'
        if (grepl(valor, i)) {
            result[,'L'] <- result[,'L'] + dat[,i]
        }
        
        
    }
    
    return(result)
    
}

