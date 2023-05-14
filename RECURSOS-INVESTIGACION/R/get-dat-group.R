getDatEEFFByGroup <- function(dat=NULL, by='TIPO_DE_ENTIDAD') {
    
    source('RECURSOS-INVESTIGACION/R/camel-get-datCAP.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-basic.R')
    require(dplyr)
    
    datCAP <- getDatCAP()
    
    # Verificar si "dat" es nulo
    if (is.null(dat) ) { dat <- getDatEEFF() }
    
    # Agrupar por sectores
    if (by=='TIPO_DE_ENTIDAD') {
        
        dat <- 
            dat %>% 
            group_by(TIPO_DE_ENTIDAD, FECHA) %>% 
            summarise_if(is.numeric, sum) %>% 
            select(-GESTION, -MES, -DIA)

        datCAP <- 
            datCAP %>% 
            filter(ENTIDIDAD=='TOTAL_SISTEMA')
        
        
        dat$ID <- paste0(dat$TIPO_DE_ENTIDAD,
                         format(dat$FECHA, format='%Y'),
                         format(dat$FECHA, format='%m'))
        
        datCAP$ID <- paste0(datCAP$TIPO_DE_ENTIDAD,
                            format(datCAP$FECHA, format='%Y'),
                            format(datCAP$FECHA, format='%m'))
        
        datCAP <- datCAP %>% select(ID,COEFICIENTE_DE_ADECUACION_PATRIMONIAL)
        
        datResult <- 
            left_join(dat, datCAP, 
                      by = join_by(ID == ID), 
                      relationship = 'one-to-one', 
                      suffix = c("x", ""))
    }
    
    # Agrupar por entidades
    if (by=='ENTIDAD') {
        
        dat <- 
            dat %>% 
            select(-GESTION, -MES, -DIA)
        
        datCAP <- 
            datCAP %>% 
            filter(ENTIDIDAD!='TOTAL_SISTEMA')
        
        
        dat$ID <- paste0(dat$TIPO_DE_ENTIDAD,
                         dat$ENTIDIDAD,
                         format(dat$FECHA, format='%Y'),
                         format(dat$FECHA, format='%m'))
        
        datCAP$ID <- paste0(datCAP$TIPO_DE_ENTIDAD,
                            datCAP$ENTIDIDAD,
                            format(datCAP$FECHA, format='%Y'),
                            format(datCAP$FECHA, format='%m'))
        
        datCAP <- datCAP %>% select(ID,COEFICIENTE_DE_ADECUACION_PATRIMONIAL)
        
        datResult <- 
            left_join(dat, datCAP, 
                      by = join_by(ID == ID), 
                      relationship = 'one-to-one', 
                      suffix = c("x", ""))
    }
    
    return(datResult)
}