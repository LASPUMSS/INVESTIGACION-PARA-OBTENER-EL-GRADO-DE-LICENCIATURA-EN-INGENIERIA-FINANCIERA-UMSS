getDatCamelIndicadores <- function(dat=NULL, by='TIPO_DE_ENTIDAD') {
    
    dat <- NULL
    by <- 'TIPO_DE_ENTIDAD'
    
    # Funciones necesarias
    source('RECURSOS-INVESTIGACION/R/camel-indicadores-functions.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-basic.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-group.R')
    require(dplyr)
    
    # Verificar dat
    if (is.null(dat) ) { dat <- getDatEEFF() }
    
    dat <- getDatEEFFByGroup(dat, by)
    
    if (by=='TIPO_DE_ENTIDAD') {
        datCamelInd <- data.frame(ID=dat$ID,
                                  TIPO_DE_ENTIDAD=dat$TIPO_DE_ENTIDAD,
                                  FECHA=dat$FECHA)   
    }
    
    if (by=='ENTIDAD') {
        datCamelInd <- data.frame(ID=dat$ID,
                                  TIPO_DE_ENTIDAD=dat$TIPO_DE_ENTIDAD,
                                  FECHA=dat$FECHA)   
    }
    
    # Variables
    # Revisar
    cap <- dat$COEFICIENTE_DE_ADECUACION_PATRIMONIAL
    cartVnc <- dat$ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL
    cartEjc <- dat$ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL
    cartVgt <- dat$ACTIVO_CARTERA_CARTERA_VIGENTE_TOTAL
    cartVncRep <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA
    cartEjcRep <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION
    cartVgtRep <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE
    
    prevCart <- dat$ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA
    patrimonio <- dat$PATRIMONIO
    
    realizables = dat$ACTIVO_BIENES_REALIZABLES
    activo <- dat$ACTIVO
    contingente <- dat$CUENTAS_CONTINGENTES_DEUDORAS
    
    gastAdm <- dat$EERR_S2_GASTOS_DE_ADMINISTRACION
    impuestos <- dat$EERR_S2_IMPUESTOS
    resulOp <- dat$RESULTADO_DE_OPERACION_BRUTO
    
    ingNeto <- dat$EERR_S2_RESULTADO_NETO_DE_LA_GESTION
    
    disponibles <- dat$ACTIVO_DISPONIBILIDADES
    invTemp <- dat$ACTIVO_INVERSIONES_TEMPORARIAS
    
    pasivoCP <- dat$PASIVO
    
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