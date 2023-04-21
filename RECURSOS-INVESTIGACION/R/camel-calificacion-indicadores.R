

getDatCamelCalificacionIndicadores <- function(datCamelIndNorm, datCamelRangosLimites) {
    
    calificacionIndicador <- function(x, id, camel_limites, nameColAD='DIRECCION') {
        
        if (camel_limites[camel_limites$INDICADOR==id,nameColAD]=='DESCENDENTE') {
            
            limInf <- -Inf
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L2']
            
            if (x>=limInf && x<limSup)  {
                result <- 1
            }
            
            
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L2']
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L3']
            
            if (x>=limInf && x<limSup) {
                result <- 2
            }
            
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L3']
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L4']
            
            if (x>=limInf && x<limSup) {
                result <- 3
            }
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L4']
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L5']
            
            if (x>=limInf && x<limSup) {
                result <- 4
            }
            
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L5']
            limSup <- Inf
            
            if (x>=limInf && x<limSup)  {
                result <- 5
            }
            
        }
        
        if (camel_limites[camel_limites$INDICADOR==id,nameColAD]=='ASCENDENTE') {
            
            
            limInf <- Inf
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L2']
            
            if (x<=limInf && x>limSup)  {
                result <- 1
            }
            
            
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L2']
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L3']
            
            if (x<=limInf && x>limSup) {
                result <- 2
            }
            
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L3']
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L4']
            
            if (x<=limInf && x>limSup) {
                result <- 3
            }
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L4']
            limSup <- camel_limites[camel_limites$INDICADOR==id,'L5']
            
            if (x<=limInf && x>limSup) {
                result <- 4
            }
            
            limInf <- camel_limites[camel_limites$INDICADOR==id,'L5']
            limSup <- -Inf
            
            if (x<=limInf && x>limSup)  {
                result <- 5
            }
            
        }
        
        return(result)
    }
    
    dat <- datCamelIndNorm
    x <- names(dat[,!(names(dat) %in% c('ID','FECHA','TIPO_DE_ENTIDAD'))])
    for (i in x) {
        dat[,i] <- sapply(dat[,i], 
                          calificacionIndicador, 
                          id=i, 
                          camel_limites = datCamelRangosLimites,
                          nameColAD='DIRECCION')
    }
    
    return(dat)
}





