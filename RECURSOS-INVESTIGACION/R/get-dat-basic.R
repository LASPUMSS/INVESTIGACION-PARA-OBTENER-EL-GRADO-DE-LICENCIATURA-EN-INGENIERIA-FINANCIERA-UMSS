getDatEEFF <- function() {
    
    require(openxlsx)
    require(dplyr)
    
    rootMainDir <- 'E:/INVESTIGACION-PARA-OBTENER-EL-GRADO-DE-LICENCIATURA-EN-INGENIERIA-FINANCIERA-UMSS'
    rootFile <- 'FUENTES-DE-DATOS/ASFI/ConsoleAppPrepararDatos/bin/Debug/DATOS_ASFI/BBDD_ESTADOS_FINANCIEROS.xlsx'
    
    if (getwd() == rootMainDir ) {
        dat <- read.xlsx(rootFile) 
    }else{
        dat <- read.xlsx(paste0('../../',rootFile) ) 
    }
    
    dat$FECHA <- convertToDate(dat$FECHA)
    
    dat$TIPO_DE_ENTIDAD <- gsub('COPERATIVAS_DE_AHORRO_Y_CREDITO',
                                'COOPERATIVAS_DE_AHORRO_Y_CREDITO',
                                dat$TIPO_DE_ENTIDAD)
    
    dat$ENTIDIDAD <- gsub('CSN \\(1\\)','CSN', dat$ENTIDIDAD)
    
    dat$GESTION <- as.character(dat$GESTION)
    dat$MES <- as.character(dat$MES)
    dat$DIA <- as.character(dat$DIA)
    
    datEMB <- dat %>% 
        filter(EXPRESADO=='EN_MILES_DE_BOLIVIANOS') %>% 
        mutate(across(.cols = where(is.numeric), ~ .x * 1000 ))
    
    datEB <- dat %>% 
        filter(EXPRESADO=='EN_BOLIVIANOS')
    
    dat <- bind_rows(datEMB,datEB)
    
    dat$EXPRESADO <- rep('EN_BOLIVIANOS',nrow(dat))
    
    dat$GESTION <- as.numeric(dat$GESTION)
    dat$MES <- as.numeric(dat$MES)
    dat$DIA <- as.numeric(dat$DIA)
    
    return(dat)
    
}
