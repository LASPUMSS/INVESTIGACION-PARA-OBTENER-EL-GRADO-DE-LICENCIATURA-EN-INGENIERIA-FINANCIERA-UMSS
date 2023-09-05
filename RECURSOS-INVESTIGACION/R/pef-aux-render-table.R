
transformTableAuxPef <- function(dat) {
    
    converCuentas <- function(nameCuenta) {
        
        result <- nameCuenta
        
        
        if (nameCuenta=='ACTIVO') {result <- 'ACTIVO'}
        if (nameCuenta=='COEFICIENTE_DE_ADECUACION_PATRIMONIAL') {result <- 'COEFICIENTE DE ADECUACION PATRIMONIAL'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL') {result <- 'CARTERA VENCIDA TOTAL'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VENCIDA') {result <- 'CARTERA VENCIDA'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA') {result <- 'CARTERA REPROGRAMADA VENCIDA'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VENCIDA') {result <- 'CARTERA REESTRUCTURADA VENCIDA'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VENCIDA') {result <- 'CARTERA REPROGRAMADA O REESTRUCTURADA VENCIDA'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL') {result <- 'CARTERA EJECUCION TOTAL'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_EN_EJECUCION') {result <- 'CARTERA EN EJECUCION'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION') {result <- 'CARTERA REPROGRAMADA EJECUCION'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_EN_EJECUCION') {result <- 'CARTERA REESTRUCTURADA EN EJECUCION'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_EN_EJECUCION') {result <- 'CARTERA REPROGRAMADA O REESTRUCTURADA EN EJECUCION'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VIGENTE_TOTAL') {result <- 'CARTERA VIGENTE TOTAL'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VIGENTE') {result <- 'CARTERA VIGENTE'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE') {result <- 'CARTERA REPROGRAMADA VIGENTE'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VIGENTE') {result <- 'CARTERA REESTRUCTURADA VIGENTE'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VIGENTE') {result <- 'CARTERA REPROGRAMADA O REESTRUCTURADA VIGENTE'}
        if (nameCuenta=='ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA') {result <- 'CARTERA PREVISION PARA INCOBRABILIDAD DE CARTERA'}
        if (nameCuenta=='PATRIMONIO') {result <- 'PATRIMONIO'}
        if (nameCuenta=='ACTIVO_BIENES_REALIZABLES') {result <- 'BIENES REALIZABLES'}
        if (nameCuenta=='CUENTAS_CONTINGENTES_DEUDORAS') {result <- 'CUENTAS CONTINGENTES DEUDORAS'}
        if (nameCuenta=='EERR_S2_GASTOS_DE_ADMINISTRACION') {result <- 'GASTOS DE ADMINISTRACION'}
        if (nameCuenta=='EERR_S2_IMPUESTOS') {result <- 'IMPUESTOS'}
        if (nameCuenta=='RESULTADO_DE_OPERACION_BRUTO') {result <- 'RESULTADO DE OPERACION BRUTO'}
        if (nameCuenta=='EERR_S2_RESULTADO_NETO_DE_LA_GESTION') {result <- 'RESULTADO NETO DE LA GESTION'}
        if (nameCuenta=='ACTIVO_DISPONIBILIDADES') {result <- 'DISPONIBILIDADES'}
        if (nameCuenta=='ACTIVO_INVERSIONES_TEMPORARIAS') {result <- 'INVERSIONES TEMPORARIAS'}
        if (nameCuenta=='PASIVO') {result <- 'PASIVO'}
        
        
        return(result)
    }
    
    n <- nrow(dat)
    for (i in 1:n) { dat[i,1] <- converCuentas(dat[i,1])}
    
    return(dat)
}







