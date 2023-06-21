getDatCamelIndicadores <- function(dat=NULL, by='TIPO_DE_ENTIDAD') {
    
    # Funciones necesarias
    source('RECURSOS-INVESTIGACION/R/camel-indicadores-functions.R')
    source('RECURSOS-INVESTIGACION/R/camel-getVariablesForCamel.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-group.R')
    require(dplyr)
    
    # Verificar dat
    if (is.null(dat) ) { 
        dat <- getDatEEFFNormalizada(by = by) 
    }
    

    datCamelInd <- data.frame(ID=dat$ID,
                              TIPO_DE_ENTIDAD=dat$TIPO_DE_ENTIDAD,
                              FECHA=dat$FECHA)   
    
    # Variables
    
    cap <- getVariablesForCAMEL('cap',dat)
    cartVnc <- getVariablesForCAMEL('cartVnc',dat,by)
    cartEjc <- getVariablesForCAMEL('cartEjc',dat,by)
    cartVgt <- getVariablesForCAMEL('cartVgt',dat,by)
    cartVncRep <- getVariablesForCAMEL('cartVncRep',dat,by)
    cartEjcRep <- getVariablesForCAMEL('cartEjcRep',dat,by)
    cartVgtRep <- getVariablesForCAMEL('cartVgtRep',dat,by)
    prevCart <- getVariablesForCAMEL('prevCart',dat,by)
    patrimonio <- getVariablesForCAMEL('patrimonio',dat,by)
    realizables = getVariablesForCAMEL('realizables',dat,by)
    activo <- getVariablesForCAMEL('activo',dat,by)
    contingente <- getVariablesForCAMEL('contingente',dat,by)
    gastAdm <- getVariablesForCAMEL('gastAdm',dat,by)
    impuestos <- getVariablesForCAMEL('impuestos',dat,by)
    resulOp <- getVariablesForCAMEL('resulOp',dat,by)
    ingNeto <- getVariablesForCAMEL('ingNeto',dat,by)
    disponibles <- getVariablesForCAMEL('disponibles',dat,by)
    invTemp <- getVariablesForCAMEL('invTemp',dat,by)
    pasivoCP <- getVariablesForCAMEL('pasivoCP',dat,by)
    
    #### INDICADORES DE CAPITAL
    
    datCamelInd$indCap_CAP <- cap
    
    datCamelInd$indCap_CCCM <- INDICADORES_CAMEL$indCap_CCCM(cartVnc = cartVnc,
                                                             cartEjc = cartEjc,
                                                             prevCart = prevCart,
                                                             patrimonio = patrimonio)
    
    datCamelInd$indCap_CACCM <- INDICADORES_CAMEL$indCap_CACCM(cartVnc = cartVnc,
                                                               cartEjc = cartEjc,
                                                               prevCart = prevCart,
                                                               realizables = realizables,
                                                               patrimonio = patrimonio)
    
    datCamelInd$indCap_CCP <- INDICADORES_CAMEL$indCap_CCP(activo = activo, 
                                                           contingente = contingente,
                                                           patrimonio = patrimonio)
    
    #### INDICADORES DE ACTIVO
    
    datCamelInd$indAct_CEC <- INDICADORES_CAMEL$indAct_CEC(cartVnc = cartVnc,
                                                           cartEjc = cartVnc,
                                                           cartVgt = cartVgt)
    
    datCamelInd$indAct_CPC <- INDICADORES_CAMEL$indAct_CPC(cartVnc = cartVnc,
                                                           cartEjc = cartEjc,
                                                           cartVgt = cartVgt,
                                                           prevCart = prevCart)
    
    datCamelInd$indAct_CPCM <- INDICADORES_CAMEL$indAct_CPCM(cartVnc = cartVnc,
                                                             cartEjc = cartEjc,
                                                             prevCart = prevCart)
    
    datCamelInd$indAct_CRC <- INDICADORES_CAMEL$indAct_CRC(cartVnc = cartVnc,
                                                           cartEjc = cartEjc,
                                                           cartVgt = cartVgt,
                                                           cartVncRep = cartVncRep,
                                                           cartEjcRep = cartEjcRep,
                                                           cartVgtRep = cartVgtRep)
    
    #### INDICADORES DE ADMINISTRACION
    
    datCamelInd$indAdm_CCGA <- INDICADORES_CAMEL$indAdm_CCGA(gastAdm = gastAdm,
                                                             activo = activo,
                                                             contingente = contingente)
    
    datCamelInd$indAdm_CACGA <- INDICADORES_CAMEL$indAdm_CACGA(gastAdm = gastAdm ,
                                                               impuestos = impuestos,
                                                               resulOp = resulOp)
    
    #### INDICADORES DE BENEFICIOS
    
    datCamelInd$indBenf_ROA <- INDICADORES_CAMEL$indBenf_ROA(ingNeto = ingNeto,
                                                             activo = activo,
                                                             contingente = contingente)
    
    datCamelInd$indBenf_ROE <- INDICADORES_CAMEL$indBenf_ROE(ingNeto = ingNeto,
                                                             patrimonio = patrimonio)
    
    #### INDICADORES DE LIQUIDEZ
    
    datCamelInd$indLq_CCPP <- INDICADORES_CAMEL$indLq_CCPP(disponibles = disponibles,
                                                           invTemp = invTemp,
                                                           pasivoCP = pasivoCP)
    
    datCamelInd$indLq_CACPP <- INDICADORES_CAMEL$indLq_CACPP(disponibles = disponibles,
                                                             pasivoCP = pasivoCP)
    
    
    return(datCamelInd)
}




