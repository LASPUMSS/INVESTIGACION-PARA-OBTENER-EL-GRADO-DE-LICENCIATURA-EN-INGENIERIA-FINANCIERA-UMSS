
library(dplyr)

camel_l1 <- function(x) {mean(x)-2*sd(x)}
camel_l2 <- function(x) {mean(x)-sd(x)}
camel_l3 <- function(x) {mean(x)}
camel_l4 <- function(x) {mean(x)+sd(x)}
camel_l5 <- function(x) {mean(x)+2*sd(x)}

dat <- datCamelIndNorm
dat <- dat[,!(names(dat) %in% c('ID','FECHA','TIPO_DE_ENTIDAD'))]

l1 <-  t(dat %>% summarise_all(camel_l1))
l1 <- data.frame(indicador=row.names(l1), L1=l1)

l2 <-  t(dat %>% summarise_all(camel_l2))
l2 <- data.frame(indicador=row.names(l2), L2=l2)

l3 <-  t(dat %>% summarise_all(camel_l3))
l3 <- data.frame(indicador=row.names(l3), L3=l3)

l4 <-  t(dat %>% summarise_all(camel_l4))
l4 <- data.frame(indicador=row.names(l4), L4=l4)

l5 <-  t(dat %>% summarise_all(camel_l5))
l5 <- data.frame(indicador=row.names(l5), L5=l5)


camel_limites <- Reduce(function(x, y) merge(x, y, by='indicador'), list(l1, l2, l3,l4,l5))


indicadoresCamelId <- c('DESCENDENTE',
                        'DESCENDENTE',
                        'ASCENDENTE',
                        
                        'DESCENDENTE',
                        'ASCENDENTE',
                        'ASCENDENTE',
                        'DESCENDENTE',
                        
                        'DESCENDENTE',
                        'DESCENDENTE',
                        
                        'ASCENDENTE',
                        'ASCENDENTE',
                        
                        'ASCENDENTE',
                        'ASCENDENTE'
                        )

camel_limites <- cbind(indicador=camel_limites[,1],
           AD=indicadoresCamelId, 
           camel_limites[,-1])


for (i in 1:nrow(camel_limites)) {
    
    valor <- camel_limites[i,2]
    
    if (valor=='DESCENDENTE') {
        camel_limites[i,-(1:2)] <- sort(camel_limites[i,-(1:2)])
    }
    
    if (valor=='ASCENDENTE') {
        camel_limites[i,-(1:2)] <- sort(camel_limites[i,-(1:2)], decreasing = T)
    }
}




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
