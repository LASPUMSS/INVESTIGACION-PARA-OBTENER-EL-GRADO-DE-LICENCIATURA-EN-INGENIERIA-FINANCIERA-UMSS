library(openxlsx)
library(dplyr)
library(fpp2)

dat <- read.xlsx('FUENTES-DE-DATOS\\ASFI\\ConsoleAppPrepararDatos\\bin\\Debug\\DATOS_ASFI\\BBDD_ESTADOS_FINANCIEROS.xlsx')

dat$FECHA <- convertToDate(dat$FECHA)
names(dat)

dat <- dat %>% group_by(TIPO_DE_ENTIDAD, FECHA) %>% summarise_if(is.numeric, sum)
dat <- dat[ , !(names(dat) %in% c('GESTION','MES','DIA'))]


dat$indCap_CCCM <- INDICADORES_CAMEL$indCap_CCCM(cartVnc = dat$ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL,
                                                 cartEjc = dat$ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL,
                                                 prevCart = dat$ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA,
                                                 patrimonio = dat$PATRIMONIO)

dat$indCap_CACCM <- INDICADORES_CAMEL$indCap_CACCM(cartVnc = dat$ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL,
                                                   cartEjc = dat$ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL,
                                                   prevCart = dat$ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA,
                                                   realizables = dat$ACTIVO_BIENES_REALIZABLES,
                                                   patrimonio = dat$PATRIMONIO)


INDICADORES_CAMEL <- list()
######################################################
#### INDICADORES DE CAPITAL
######################################################

# Coeficiente De Cobertura De Cartera En Mora 
INDICADORES_CAMEL$indCap_CCCM <- function(cartVnc=NA, cartEjc=NA, prevCart=NA, patrimonio=NA) {
    result <- ((cartVnc+cartEjc)-abs(prevCart))/patrimonio
    return(result)
}

# Coeficiente Ácido De Cobertura De Cartera En Mora
INDICADORES_CAMEL$indCap_CACCM <- function(cartVnc=NA, cartEjc=NA, prevCart=NA, realizables=NA, patrimonio=NA) {
    result <- ((cartVnc+cartEjc)-abs(prevCart)+realizables)/patrimonio
    return(result)
}




######################################################
tsDat <- ts(matrix(0, nrow=(2022-2021+1)*12, ncol=length(unique(dat$TIPO_DE_ENTIDAD))), 
            start=2021, frequency=12)

for (i in 1:length(unique(dat$TIPO_DE_ENTIDAD))) {
    
    tipoEnt <- as.character(unique(dat$TIPO_DE_ENTIDAD)[i])
    colnames(tsDat)[i] <- tipoEnt
    x <- dat[dat$TIPO_DE_ENTIDAD==tipoEnt,][order(dat[dat$TIPO_DE_ENTIDAD==tipoEnt,'FECHA']),'ACTIVO']
    x <- sapply(x, as.numeric)
    tsDat[,i] <- x
}

autoplot(tsDat[,-2])

