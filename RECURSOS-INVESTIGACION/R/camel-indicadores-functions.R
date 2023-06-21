INDICADORES_CAMEL <- list()
######################################################
#### INDICADORES DE CAPITAL
######################################################

# Coeficiente De Cobertura De Cartera En Mora 
INDICADORES_CAMEL$indCap_CCCM <- function(cartVnc=NA, cartEjc=NA, prevCart=NA, patrimonio=NA) {
    result <- ((cartVnc+cartEjc)-abs(prevCart))/patrimonio
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

# Coeficiente Ácido De Cobertura De Cartera En Mora
INDICADORES_CAMEL$indCap_CACCM <- function(cartVnc=NA, cartEjc=NA, prevCart=NA, realizables=NA, patrimonio=NA) {
    result <- ((cartVnc+cartEjc)-abs(prevCart)+realizables)/patrimonio
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

# Coeficiente de cobertura patrimonial
INDICADORES_CAMEL$indCap_CCP <- function(activo=NA,  contingente=NA, patrimonio=NA) {
    result <- patrimonio/(activo-contingente)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

######################################################
#### INDICADORES DE ACTIVO
######################################################

# Coeficiente de exposición de cartera
INDICADORES_CAMEL$indAct_CEC <- function(cartVnc=NA, cartEjc=NA, cartVgt=NA) {
    result <- (cartEjc+cartVnc)/(cartEjc+cartVnc+cartVgt)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

# Coeficiente de previsión de cartera 
INDICADORES_CAMEL$indAct_CPC <- function(cartVnc=NA, cartEjc=NA, cartVgt=NA, prevCart=NA) {
    result <- (abs(prevCart))/(cartEjc+cartVnc+cartVgt)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}


# Coeficiente de previsión de cartera en mora
INDICADORES_CAMEL$indAct_CPCM <- function(cartVnc=NA, cartEjc=NA, prevCart=NA) {
    result <- (abs(prevCart))/(cartEjc+cartVnc)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

# Coeficiente de reposición de cartera
INDICADORES_CAMEL$indAct_CRC <- function(cartVnc=NA, cartEjc=NA, cartVgt=NA, cartVncRep=NA, cartEjcRep=NA, cartVgtRep=NA) {
    result <- (cartEjcRep+cartVncRep+cartVgtRep)/(cartEjc+cartVnc+cartVgt)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

######################################################
#### INDICADORES DE ADMINISTRACION
######################################################

# Coeficiente de cobertura gastos administrativos 
INDICADORES_CAMEL$indAdm_CCGA <- function(gastAdm=NA, activo=NA, contingente=NA) {
    result <- (abs(gastAdm))/(activo+contingente)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

# Coeficiente ácido de cobertura patrimonial
INDICADORES_CAMEL$indAdm_CACGA <- function(gastAdm=NA, impuestos=NA, resulOp=NA) {
    result <- (abs(gastAdm) - abs(impuestos))/(resulOp)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

######################################################
#### INDICADORES DE BENEFICIOS
######################################################

# Coeficiente de rendimiento sobre activos
INDICADORES_CAMEL$indBenf_ROA <- function(ingNeto=NA, activo=NA, contingente=NA) {
    result <- (ingNeto)/(activo+contingente)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

# Coeficiente de rendimiento sobre patrimonio
INDICADORES_CAMEL$indBenf_ROE <- function(ingNeto=NA, patrimonio=NA) {
    result <- (ingNeto)/(patrimonio)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

######################################################
#### INDICADORES DE LIQUIDEZ
######################################################

# Coeficiente de capacidad de pago frente a pasivos
INDICADORES_CAMEL$indLq_CCPP <- function(disponibles=NA, invTemp=NA, pasivoCP=NA) {
    result <- (disponibles+invTemp)/(pasivoCP)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}

# Coeficiente ácido de capacidad de pago frente a pasivos
INDICADORES_CAMEL$indLq_CACPP <- function(disponibles=NA, pasivoCP=NA) {
    result <- (disponibles)/(pasivoCP)
    
    result <- ifelse(is.infinite(result),NA,result)
    result <- ifelse(is.nan(result),NA,result)
    return(result)
}


