
getDatCamelIndNormalizada <- function(gestionInc=2014, gestionFn=2022, by='TIPO_DE_ENTIDAD') {
    
    # Librerias necesarias
    require(dplyr)
    
    # Funciones necesarias
    source('RECURSOS-INVESTIGACION/R/camel-get-datCamelIndicadores.R')
    
    datCamelInd <- getDatCamelIndicadores(by=by)
    
    entidades <- unique(datCamelInd$TIPO_DE_ENTIDAD)
    
    datCamelInd$ID <- paste0(datCamelInd$TIPO_DE_ENTIDAD,
                             format(datCamelInd$FECHA, format='%Y'),
                             format(datCamelInd$FECHA, format='%m'))
    datCamelInd <- select(datCamelInd, -c(TIPO_DE_ENTIDAD, FECHA))
    
    # Numero de filas que debera tener el data.frame 
    nGestiones <- (gestionFn-gestionInc+1)
    nMeses <- 12
    nEntidades <- length(entidades)
    n <- nGestiones*nMeses*nEntidades
    
    datCamelIndNorm <- data.frame(
        
        ID=rep(NA,n),
        TIPO_DE_ENTIDAD=rep(NA,n),
        FECHA=rep(NA,n),
        
        indCap_CAP=rep(NA,n),
        indCap_CCCM=rep(NA,n),
        indCap_CACCM=rep(NA,n),
        indCap_CCP=rep(NA,n),
        
        indAct_CEC=rep(NA,n),
        indAct_CPC=rep(NA,n),
        indAct_CPCM=rep(NA,n),
        indAct_CRC=rep(NA,n),
        
        indAdm_CCGA=rep(NA,n),
        indAdm_CACGA=rep(NA,n),
        
        indBenf_ROA=rep(NA,n),
        indBenf_ROE=rep(NA,n),
        
        indLq_CCPP=rep(NA,n),
        indLq_CACPP=rep(NA,n)
        
    )
    
    datCamelIndNorm$TIPO_DE_ENTIDAD <- sort(rep(entidades,nMeses*nGestiones))
    
    mesesId <- c('01','02','03','04','05','06','07','08','09','10','11','12')
    fechas <- vector()
    
    for (i in seq(gestionInc, gestionFn)) {
        
        for (i2 in mesesId) {
            
            fechas <- append(fechas, paste0(i,'-',i2,'-28'))
            
        }
        
    }
    
    datCamelIndNorm$FECHA <- as.Date(rep(fechas,nEntidades))
    datCamelIndNorm$ID <- paste0(datCamelIndNorm$TIPO_DE_ENTIDAD,
                                 format(datCamelIndNorm$FECHA, format='%Y'),
                                 format(datCamelIndNorm$FECHA, format='%m'))
    
    
    datResult <- 
        left_join(datCamelIndNorm, 
                  datCamelInd, 
                  by = join_by(ID == ID), 
                  relationship = 'one-to-one', 
                  suffix = c("_x", "")) %>% 
        select(-ends_with("_x")) %>% 
        relocate(FECHA, .after = ID)
    
    return(datResult)
}


