##################################################

dat <- datCamelIndNorm

x <- names(dat[,!(names(dat) %in% c('ID','FECHA','TIPO_DE_ENTIDAD'))])

for (i in x) {
    print(i)
    dat[,i] <- sapply(dat[,i], calificacionIndicador, id=i, camel_limites = camel_limites)
}

sapply(dat$indCap_CCCM, calificacionIndicador, id='indCap_CCCM',camel_limites = camel_limites)
sapply(dat$indAct_CEC, calificacionIndicador, id='indAct_CEC',camel_limites = camel_limites)

names(dat)

calificacionIndicador <- function(x, id, camel_limites) {
    
    if (camel_limites[camel_limites$indicador==id,'AD']=='DESCENDENTE') {
        
        limInf <- -Inf
        limSup <- camel_limites[camel_limites$indicador==id,'L2']
        
        if (x>=limInf && x<limSup)  {
            result <- 1
        }
        
        
        limInf <- camel_limites[camel_limites$indicador==id,'L2']
        limSup <- camel_limites[camel_limites$indicador==id,'L3']
        
        if (x>=limInf && x<limSup) {
            result <- 2
        }
        
        limInf <- camel_limites[camel_limites$indicador==id,'L3']
        limSup <- camel_limites[camel_limites$indicador==id,'L4']
        
        if (x>=limInf && x<limSup) {
            result <- 3
        }
        limInf <- camel_limites[camel_limites$indicador==id,'L4']
        limSup <- camel_limites[camel_limites$indicador==id,'L5']
        
        if (x>=limInf && x<limSup) {
            result <- 4
        }
        
        limInf <- camel_limites[camel_limites$indicador==id,'L5']
        limSup <- Inf
        
        if (x>=limInf && x<limSup)  {
            result <- 5
        }
        
    }
    
    if (camel_limites[camel_limites$indicador==id,'AD']=='ASCENDENTE') {
        
        
        limInf <- Inf
        limSup <- camel_limites[camel_limites$indicador==id,'L2']
        
        if (x<=limInf && x>limSup)  {
            result <- 1
        }
        
        
        limInf <- camel_limites[camel_limites$indicador==id,'L2']
        limSup <- camel_limites[camel_limites$indicador==id,'L3']
        
        if (x<=limInf && x>limSup) {
            result <- 2
        }
        
        limInf <- camel_limites[camel_limites$indicador==id,'L3']
        limSup <- camel_limites[camel_limites$indicador==id,'L4']
        
        if (x<=limInf && x>limSup) {
            result <- 3
        }
        limInf <- camel_limites[camel_limites$indicador==id,'L4']
        limSup <- camel_limites[camel_limites$indicador==id,'L5']
        
        if (x<=limInf && x>limSup) {
            result <- 4
        }
        
        limInf <- camel_limites[camel_limites$indicador==id,'L5']
        limSup <- -Inf
        
        if (x<=limInf && x>limSup)  {
            result <- 5
        }
        
    }
    
    return(result)
}
