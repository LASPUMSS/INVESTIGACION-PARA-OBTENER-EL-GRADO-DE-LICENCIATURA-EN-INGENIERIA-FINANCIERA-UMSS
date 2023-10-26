getVariablesForCAMEL <- function(x, dat=NULL, by='TIPO_DE_ENTIDAD') {
    
    # Funciones necesarias
    source('RECURSOS-INVESTIGACION/R/get-dat-basic.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-group.R')
    
    # Verificar dat
    if (is.null(dat)) { 
        dat <- getDatEEFF() 
        dat <- getDatEEFFByGroup(dat, by)
    }

    
    if (x=='cap') {
        
        result <- ifelse(dat$COEFICIENTE_DE_ADECUACION_PATRIMONIAL==0, NA, dat$COEFICIENTE_DE_ADECUACION_PATRIMONIAL)
        
    } else if(x=='cartVnc'){
        
        cuentas <- dat[,c('ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL',
                          'ACTIVO_CARTERA_CARTERA_VENCIDA',
                          'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA',
                          'ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VENCIDA',
                          'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VENCIDA')]
        
        cuentas$TOTAL <- 
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_VENCIDA),0,cuentas$ACTIVO_CARTERA_CARTERA_VENCIDA) +
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA),0,cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA) + 
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VENCIDA),0,cuentas$ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VENCIDA) +
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VENCIDA),0,cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VENCIDA)
        
        result <- cuentas$TOTAL
        
    } else if(x=='cartEjc'){
        
        cuentas <- dat[,c('ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL',
                          'ACTIVO_CARTERA_CARTERA_EN_EJECUCION',
                          'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION',
                          'ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_EN_EJECUCION',
                          'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_EN_EJECUCION')]
        cuentas$TOTAL <- 
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_EN_EJECUCION),0,cuentas$ACTIVO_CARTERA_CARTERA_EN_EJECUCION) +
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION),0,cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION) + 
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_EN_EJECUCION),0,cuentas$ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_EN_EJECUCION) +
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_EN_EJECUCION),0,cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_EN_EJECUCION)
        
        result <- cuentas$TOTAL
        
    } else if(x=='cartVgt'){
        
        cuentas <- dat[,c('ACTIVO_CARTERA_CARTERA_VIGENTE_TOTAL',
                          'ACTIVO_CARTERA_CARTERA_VIGENTE',
                          'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE',
                          'ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VIGENTE',
                          'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VIGENTE')]
        cuentas$TOTAL <- 
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_VIGENTE),0,cuentas$ACTIVO_CARTERA_CARTERA_VIGENTE) +
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE),0,cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE) + 
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VIGENTE),0,cuentas$ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VIGENTE) +
            ifelse(is.na(cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VIGENTE),0,cuentas$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VIGENTE)
        
        
        result <- cuentas$TOTAL
        
    } else if(x=='cartVncRep'){
        
        # REVISAR (77 EEFF NO DIFERENCIA ENTRE REPROGRAMA O RESTRUCTURAR)
        result <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA
        
    } else if(x=='cartEjcRep'){
        
        # REVISAR (77 EEFF NO DIFERENCIA ENTRE REPROGRAMA O RESTRUCTURAR)
        result <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION
        
    } else if(x=='cartVgtRep'){
        
        # REVISAR (77 EEFF NO DIFERENCIA ENTRE REPROGRAMA O RESTRUCTURAR)
        result <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE
        
    } else if(x=='prevCart'){
        
        result <- dat$ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA
        
    } else if(x=='patrimonio'){
        
        result <- dat$PATRIMONIO
        
    } else if(x=='realizables'){
        
        result = dat$ACTIVO_BIENES_REALIZABLES
        
    } else if(x=='activo'){
        
        result <- dat$ACTIVO
        
    } else if(x=='contingente'){
        
        # REVISAR (SE DEBE SUMAR O RESTAR)
        result <- dat$CUENTAS_CONTINGENTES_DEUDORAS
        
    } else if(x=='gastAdm'){
        
        result <- dat$EERR_S2_GASTOS_DE_ADMINISTRACION
        
    } else if(x=='impuestos'){
        
        result <- dat$EERR_S2_IMPUESTOS
        
    } else if(x=='resulOp'){
        
        result <- dat$RESULTADO_DE_OPERACION_BRUTO
        
    } else if(x=='ingNeto'){
        
        result <- dat$EERR_S2_RESULTADO_NETO_DE_LA_GESTION
        
    } else if(x=='disponibles'){
        
        result <- dat$ACTIVO_DISPONIBILIDADES
        
    } else if(x=='invTemp'){
        
        result <- dat$ACTIVO_INVERSIONES_TEMPORARIAS
        
    } else if(x=='pasivoCP'){
        
        result <- dat$PASIVO
        
    }
    
    return(result)
    
}