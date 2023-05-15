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
        
        result <- dat$COEFICIENTE_DE_ADECUACION_PATRIMONIAL
        
    } else if(x=='cartVnc'){
        
        result <- dat$ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL
        
    } else if(x=='cartEjc'){
        
        result <- dat$ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL
        
    } else if(x=='cartVgt'){
        
        result <- dat$ACTIVO_CARTERA_CARTERA_VIGENTE_TOTAL
        
    } else if(x=='cartVncRep'){
        
        result <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA
        
    } else if(x=='cartEjcRep'){
        
        result <- dat$ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION
        
    } else if(x=='cartVgtRep'){
        
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