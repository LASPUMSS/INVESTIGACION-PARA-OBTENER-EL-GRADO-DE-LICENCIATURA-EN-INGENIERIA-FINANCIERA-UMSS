# PARA PODER EXPLORAR LAS CUENTAS DE MANERA INDIVIDUAL

getDatEEFFNormalizada <- function(by='TIPO_DE_ENTIDAD') {
    
    source('RECURSOS-INVESTIGACION/R/get-dat-basic.R')
    
    dat <- getDatEEFF() 
    dat <- getDatEEFFByGroup(dat, by)
    
    # Numero de filas que debera tener el data.frame 
    nGestiones <- (gestionFn-gestionInc+1)
    nMeses <- 12
    nEntidades <- length(entidades)
    n <- nGestiones*nMeses*nEntidades
    
}