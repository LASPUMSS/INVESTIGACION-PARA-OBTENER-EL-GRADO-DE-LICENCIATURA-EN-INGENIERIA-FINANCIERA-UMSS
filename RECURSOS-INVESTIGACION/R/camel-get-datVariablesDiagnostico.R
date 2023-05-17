# VARIABLES PARA DIAGNOSTICO CAMEL

getDatVariablesDiagnostico <- function(by = 'TIPO_DE_ENTIDAD', gestionInc=2022) {

    # Funciones necesarias
    source('RECURSOS-INVESTIGACION/R/camel-indicadores-functions.R')
    source('RECURSOS-INVESTIGACION/R/camel-getVariablesForCamel.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-basic.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-group.R')
    require(dplyr)
    
    # Verificar dat
    
    dat <- getDatEEFF()
    dat <- getDatEEFFByGroup(dat, by)
    
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
    
    datResult <- data.frame(FECHA=dat$FECHA,TIPO_DE_ENTIDAD=dat$TIPO_DE_ENTIDAD)
    
    datResult$CAP <- cap
    datResult$CARTERA_VENCIDA=cartVnc
    datResult$CARTERA_EN_EJECUCION <- cartEjc
    datResult$CARTERA_VIGENTE <- cartVgt
    datResult$CARTERA_VENCIDA_REPROGRAMADA <- cartEjcRep
    datResult$CARTERA_EN_EJECUCION_REPROGRAMADA <- cartVgtRep
    datResult$CARTERA_VIGENTE_REPROGRAMADA <- cartEjcRep
    datResult$PREVISION_INCOBRABILIDAD_CARTERA <- prevCart
    datResult$PATRIMONIO <- patrimonio
    datResult$ACTIVOS_REALIZABLES <- realizables
    datResult$ACTIVO <- activo
    datResult$ACTIVO_CONTINGENTE <- contingente
    datResult$ACTIVO_DISPONIBLE <- disponibles
    datResult$ACTIVO_INVERSIONES_TEMPORARIAS <- invTemp
    datResult$PASIVO <- pasivoCP
    datResult$GASTOS_ADMINISTRATIVOS <- gastAdm
    datResult$IMPUESTOS <- impuestos
    datResult$RESULTADO_OPERATIVO <- resulOp
    datResult$INGRESO_NETO <- ingNeto
    
    fechaIncio <- as.Date(paste0(gestionInc,'-01-01'))
    datResult <- datResult %>% filter(FECHA>=fechaIncio)
    
    return(datResult)
        
}


