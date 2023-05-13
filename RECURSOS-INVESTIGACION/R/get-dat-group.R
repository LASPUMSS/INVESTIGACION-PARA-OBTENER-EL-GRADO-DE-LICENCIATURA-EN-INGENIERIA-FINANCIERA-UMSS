getDatEEFFByGroup <- function(dat=NULL, by='TIPO_DE_ENTIDAD') {
    
    # Paquetes necesarios
    require(dplyr)
    
    # Verificar si "dat" es nulo
    if (is.null(dat) ) {
        source('RECURSOS-INVESTIGACION/R/get-dat-basic.R')
        dat <- getDatEEFF()   
    }
    
    # Agrupar por sectores
    if (by=='TIPO_DE_ENTIDAD') {
        dat <- dat %>% group_by(TIPO_DE_ENTIDAD, FECHA) %>% summarise_if(is.numeric, sum)
        dat <- dat[ , !(names(dat) %in% c('GESTION','MES','DIA'))]   
    }
    
    # Agrupar por entidades
    if (by=='ENTIDAD') {
        dat <- dat 
    }
    
    return(dat)
}