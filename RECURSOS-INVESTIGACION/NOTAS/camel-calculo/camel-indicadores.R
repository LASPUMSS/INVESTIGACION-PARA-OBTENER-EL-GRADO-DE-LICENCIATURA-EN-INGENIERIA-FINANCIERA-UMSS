library(openxlsx)
library(dplyr)

dat <- read.xlsx('FUENTES-DE-DATOS\\ASFI\\ConsoleAppPrepararDatos\\bin\\Debug\\DATOS_ASFI\\BBDD_ESTADOS_FINANCIEROS.xlsx')

dat$FECHA <- convertToDate(dat$FECHA)
names(dat)

dat <- dat %>% group_by(TIPO_DE_ENTIDAD, FECHA) %>% summarise_if(is.numeric, sum)
dat <- dat[ , !(names(dat) %in% c('GESTION','MES','DIA'))]


datCamelInd <- data.frame(TIPO_DE_ENTIDAD=dat$TIPO_DE_ENTIDAD,FECHA=dat$FECHA)
#### INDICADORES DE CAPITAL

datCamelInd$indCap_CCCM <- INDICADORES_CAMEL$indCap_CCCM(cartVnc = dat$ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL,
                                                 cartEjc = dat$ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL,
                                                 prevCart = dat$ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA,
                                                 patrimonio = dat$PATRIMONIO)

datCamelInd$indCap_CACCM <- INDICADORES_CAMEL$indCap_CACCM(cartVnc = dat$ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL,
                                                   cartEjc = dat$ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL,
                                                   prevCart = dat$ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA,
                                                   realizables = dat$ACTIVO_BIENES_REALIZABLES,
                                                   patrimonio = dat$PATRIMONIO)

datCamelInd$indCap_CCP <- INDICADORES_CAMEL$indCap_CCP(activo = NA, 
                                                       contigente = NA,
                                                       patrimonio = NA)

#### INDICADORES DE ACTIVO

datCamelInd$indAct_CEC <- INDICADORES_CAMEL$indAct_CEC(cartVnc = NA,
                                                   cartEjc = NA,
                                                   cartVgt = NA)

datCamelInd$indAct_CPC <- INDICADORES_CAMEL$indAct_CPC(cartVnc = NA,
                                              cartEjc = NA,
                                              cartVgt = NA,
                                              prevCart = NA)

datCamelInd$indAct_CPCM <- INDICADORES_CAMEL$indAct_CPCM(cartVnc = NA,
                                               cartEjc = NA,
                                               prevCart = NA)

datCamelInd$indAct_CRC <- INDICADORES_CAMEL$indAct_CRC(cartVnc = NA,
                                              cartEjc = NA,
                                              cartVgt = NA,
                                              cartVncRep = NA,
                                              cartEjcRep = NA,
                                              cartVgtRep = NA)

#### INDICADORES DE ADMINISTRACION

datCamelInd$indAdm_CCGA <- INDICADORES_CAMEL$indAdm_CCGA(gastAdm = NA,
                                               activo = NA,
                                               contigente = NA)

datCamelInd$indAdm_CACGA <- INDICADORES_CAMEL$indAdm_CACGA(gastAdm = NA,
                                                impuestos = NA,
                                                resulOp = NA)

#### INDICADORES DE BENEFICIOS

datCamelInd$indBenf_ROA <- INDICADORES_CAMEL$indBenf_ROA(ingNeto = NA,
                                               activo = NA,
                                               contigente = NA)

datCamelInd$indBenf_ROE <- INDICADORES_CAMEL$indBenf_ROE(ingNeto = NA,
                                               patrimonio = NA)

#### INDICADORES DE LIQUIDEZ

datCamelInd$indLq_CCPCP <- INDICADORES_CAMEL$indLq_CCPCP(disponibles = NA,
                                               invTemp = NA,
                                               pasivoCP = NA)

datCamelInd$indLq_CACPCP <- INDICADORES_CAMEL$indLq_CACPCP(disponibles = NA,
                                                pasivoCP = NA)


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

# Coeficiente de cobertura patrimonial
INDICADORES_CAMEL$indCap_CCP <- function(activo=NA,  contigente=NA, patrimonio=NA) {
    result <- patrimonio/(activo-contigente)
    return(result)
}

######################################################
#### INDICADORES DE ACTIVO
######################################################

# Coeficiente de exposición de cartera
INDICADORES_CAMEL$indAct_CEC <- function(cartVnc=NA, cartEjc=NA, cartVgt=NA) {
    result <- (cartEjc+cartVnc)/(cartEjc+cartVnc+cartVgt)
    return(result)
}

# Coeficiente de previsión de cartera 
INDICADORES_CAMEL$indAct_CPC <- function(cartVnc=NA, cartEjc=NA, cartVgt=NA, prevCart=NA) {
    result <- (prevCart)/(cartEjc+cartVnc+cartVgt)
    return(result)
}


# Coeficiente de previsión de cartera en mora
INDICADORES_CAMEL$indAct_CPCM <- function(cartVnc=NA, cartEjc=NA, prevCart=NA) {
    result <- (prevCart)/(cartEjc+cartVnc)
    return(result)
}

# Coeficiente de reposición de cartera
INDICADORES_CAMEL$indAct_CRC <- function(cartVnc=NA, cartEjc=NA, cartVgt=NA, cartVncRep=NA, cartEjcRep=NA, cartVgtRep=NA) {
    result <- (cartEjcRep+cartVncRep+cartVgtRep)/(cartEjc+cartVnc+cartVgt)
    return(result)
}

######################################################
#### INDICADORES DE ADMINISTRACION
######################################################

# Coeficiente de cobertura gastos administrativos 
INDICADORES_CAMEL$indAdm_CCGA <- function(gastAdm=NA, activo=NA, contigente=NA) {
    result <- (gastAdm)/(activo+contigente)
    return(result)
}

# Coeficiente ácido de cobertura patrimonial
INDICADORES_CAMEL$indAdm_CACGA <- function(gastAdm=NA, impuestos=NA, resulOp=NA) {
    result <- (gastAdm - impuestos)/(resulOp)
    return(result)
}

######################################################
#### INDICADORES DE BENEFICIOS
######################################################

# Coeficiente de rendimiento sobre activos
INDICADORES_CAMEL$indBenf_ROA <- function(ingNeto=NA, activo=NA, contigente=NA) {
    result <- (ingNeto)/(activo+contigente)
    return(result)
}

# Coeficiente de rendimiento sobre patrimonio
INDICADORES_CAMEL$indBenf_ROE <- function(ingNeto=NA, patrimonio=NA) {
    result <- (ingNeto)/(patrimonio)
    return(result)
}

######################################################
#### INDICADORES DE LIQUIDEZ
######################################################

# Coeficiente de capacidad de pago frente obligaciones a corto plazo
INDICADORES_CAMEL$indLq_CCPCP <- function(disponibles=NA, invTemp=NA, pasivoCP=NA) {
    result <- (disponibles+invTemp)/(pasivoCP)
    return(result)
}

# Coeficiente ácido de capacidad de pago frente obligaciones a corto
INDICADORES_CAMEL$indLq_CACPCP <- function(disponibles=NA, pasivoCP=NA) {
    result <- (disponibles)/(pasivoCP)
    return(result)
}


