# PARA PODER EXPLORAR LAS CUENTAS DE MANERA INDIVIDUAL

getDatEEFFNormalizada <- function(by='TIPO_DE_ENTIDAD', na.cero=FALSE) {
    
    source('RECURSOS-INVESTIGACION/R/get-dat-basic.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-group.R')
    
    dat <- getDatEEFF() 
    dat <- getDatEEFFByGroup(dat, by)
    names(dat)[2] <- 'TIPO_DE_ENTIDAD'
    
    # Numero de filas que debera tener el data.frame 
    entidades <- unique(dat$TIPO_DE_ENTIDAD)
    gestionInc <- min(as.numeric(format(dat$FECHA, format='%Y')))
    gestionFn <- max(as.numeric(format(dat$FECHA, format='%Y')))
    nGestiones <- (gestionFn-gestionInc+1)
    nMeses <- 12
    nEntidades <- length(entidades)
    n <- nGestiones*nMeses*nEntidades
    
    datNorm <- data.frame(matrix(0, nrow = n, ncol = ncol(dat)))
    names(datNorm) <- names(dat)
    
    datNorm$TIPO_DE_ENTIDAD <- sort(rep(entidades,nMeses*nGestiones))
    
    mesesId <- c('01','02','03','04','05','06','07','08','09','10','11','12')
    fechas <- vector()
    
    for (i in seq(gestionInc, gestionFn)) {
        
        for (i2 in mesesId) {
            
            fechas <- append(fechas, paste0(i,'-',i2,'-28'))
            
        }
        
    }
    
    datNorm$FECHA <- as.Date(rep(fechas,nEntidades))
    datNorm$ID <- paste0(datNorm$TIPO_DE_ENTIDAD,
                         format(datNorm$FECHA, format='%Y'),
                         format(datNorm$FECHA, format='%m'))
    
    dat$ID <- paste0(dat$TIPO_DE_ENTIDAD,
                         format(dat$FECHA, format='%Y'),
                         format(dat$FECHA, format='%m'))
    
    dat <- dat[,c(-2,-3)]
    
    datResult <- 
        left_join(datNorm, 
                  dat, 
                  by = join_by(ID == ID), 
                  relationship = 'one-to-one', 
                  suffix = c("_x", "")) %>% 
        select(-ends_with("_x")) %>% 
        relocate(FECHA, .after = ID)
    
    if (na.cero) {
        datResult <- datResult %>% replace(is.na(.), 0)
        
    }
    return(datResult)
}