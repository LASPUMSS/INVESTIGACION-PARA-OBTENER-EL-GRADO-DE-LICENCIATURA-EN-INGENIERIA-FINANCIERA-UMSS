getDatCAP <- function() {
    
    require(stringi)
    
    dat <- read.xlsx('FUENTES-DE-DATOS/ASFI/ConsoleAppPrepararDatos/bin/Debug/DATOS_ASFI/BBDD_INDICADORES_FINANCIEROS.xlsx')
    dat$FECHA <- convertToDate(dat$FECHA)
    
    dat$TIPO_DE_ENTIDAD <- gsub('COPERATIVAS_DE_AHORRO_Y_CREDITO',
                                 'COOPERATIVAS_DE_AHORRO_Y_CREDITO',
                                 dat$TIPO_DE_ENTIDAD)
    
    dat$ENTIDIDAD <- gsub('BFO \\(5\\)','BFO', dat$ENTIDIDAD)
    dat$ENTIDIDAD <- gsub('BFO ','BFO', dat$ENTIDIDAD)
    dat$ENTIDIDAD <- gsub('CSN \\(6\\)','CSN', dat$ENTIDIDAD)
    
    for (i in nrow(dat)) {
        
        if (grepl('TOTAL', dat[i,'ENTIDIDAD']) ) {
            print('aqui')
            dat[i,'ENTIDIDAD'] <- 'TOTAL'
        }
        
    }
    
    unique(dat$ENTIDIDAD)
    
    dat$ENTIDIDAD <- gsub('TOTAL SISTEMA \\(5\\)','TOTAL_SISTEMA', dat$ENTIDIDAD)
    dat$ENTIDIDAD <- gsub('TOTAL SISTEMA','TOTAL_SISTEMA', dat$ENTIDIDAD)
    
    #dat$ENTIDIDAD <- gsub('TOTAL','TOTAL_SISTEMA', dat$ENTIDIDAD)
    
    dat$ID <- paste0(dat$TIPO_DE_ENTIDAD,
                      format(dat$FECHA, format='%Y'),
                      format(dat$FECHA, format='%m'))
    
    return(dat)
    
    
}