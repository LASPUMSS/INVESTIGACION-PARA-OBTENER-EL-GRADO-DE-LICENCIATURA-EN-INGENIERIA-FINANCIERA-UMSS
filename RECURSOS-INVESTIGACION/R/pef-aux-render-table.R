
transformTableAuxPef <- function(dat) {
    
    converCuentas <- function(nameCuenta) {
        
        result <- nameCuenta
        if (nameCuenta=='ACTIVO') {result <- 'ACTIVO'}
        
        if (nameCuenta=='ACTIVO_DISPONIBILIDADES') {result <- 'DISPONIBILIDADES'}
        if (nameCuenta=='ACTIVO_INVERSIONES_TEMPORARIAS') {result <- 'INVERSIONES TEMPORARIAS'}
        
        if (nameCuenta=='ACTIVO_CARTERA') {result <- 'CARTERA'}
        
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
        
        if (nameCuenta=='ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA') {result <- 'PREVISION PARA INCOBRABILIDAD DE CARTERA'}
        
        if (nameCuenta=='ACTIVO_OTRAS_CUENTAS_POR_COBRAR') {result <- 'OTRAS CUENTAS POR COBRAR'}
        if (nameCuenta=='ACTIVO_BIENES_REALIZABLES') {result <- 'BIENES REALIZABLES'}
        if (nameCuenta=='ACTIVO_INVERSIONES_PERMANENTES') {result <- 'INVERSIONES PERMANENTES'}
        if (nameCuenta=='ACTIVO_BIENES_DE_USO') {result <- 'BIENES DE USO'}
        if (nameCuenta=='ACTIVO_OTROS_ACTIVOS') {result <- 'OTROS ACTIVOS'}
        if (nameCuenta=='ACTIVO_FIDEICOMISOS_CONSTITUIDOS') {result <- 'FIDEICOMISOS CONSTITUIDOS'}
        
        if (nameCuenta=='PASIVO') {result <- 'PASIVO'}
        
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_EL_PUBLICO') {result <- 'OBLIGACIONES CON EL PUBLICO'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_INSTITUCIONES_FISCALES') {result <- 'OBLIGACIONES CON INSTITUCIONES FISCALES'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_EMPRESAS_PUBLICAS') {result <- 'OBLIGACIONES CON EMPRESAS PUBLICAS'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_BANCOS_Y_ENTIDADES_DE_FINANCIAMIENTO') {result <- 'OBLIGACIONES CON BANCOS Y ENTIDADES DE FINANCIAMIENTO'}
        if (nameCuenta=='PASIVO_OTRAS_CUENTAS_POR_PAGAR') {result <- 'OTRAS CUENTAS POR PAGAR'}
        if (nameCuenta=='PASIVO_PREVISIONES') {result <- 'PREVISIONES'}
        if (nameCuenta=='PASIVO_VALORES_EN_CIRCULACION') {result <- 'VALORES EN CIRCULACION'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_SUBORDINADAS') {result <- 'OBLIGACIONES SUBORDINADAS'}
        
        if (nameCuenta=='PATRIMONIO') {result <- 'PATRIMONIO'}
        if (nameCuenta=='PATRIMONIO_CAPITAL_SOCIAL') {result <- 'CAPITAL SOCIAL'}
        if (nameCuenta=='PATRIMONIO_APORTES_NO_CAPITALIZADOS') {result <- 'APORTES NO CAPITALIZADOS'}
        if (nameCuenta=='PATRIMONIO_AJUSTES_AL_PATRIMONIO') {result <- 'AJUSTES AL PATRIMONIO'}
        if (nameCuenta=='PATRIMONIO_RESERVAS') {result <- 'RESERVAS'}
        if (nameCuenta=='PATRIMONIO_RESULTADOS_ACUMULADOS') {result <- 'RESULTADOS ACUMULADOS'}
        
        if (nameCuenta=='PATRIMONIO_PASIVO_PATRIMONIO') {result <- 'TOTAL PASIVO PATRIMONIO'}
        
        if (nameCuenta=='CUENTAS_CONTINGENTES_DEUDORAS') {result <- 'CONTINGENTES DEUDORAS'}
        if (nameCuenta=='CUENTAS_CONTINGENTES_DEUDORAS_CUENTAS_DE_ORDEN_DEUDORAS') {result <- 'CUENTAS DE ORDEN DEUDORAS'}
        
        #ESTADODERESULTADOS
        if (nameCuenta=='INGRESOS_FINANCIEROS') {result <- 'INGRESOS FINANCIEROS'}
        if (nameCuenta=='GASTOS_FINANCIEROS') {result <- 'GASTOS FINANCIEROS'}
        if (nameCuenta=='RESULTADO_FINANCIERO_BRUTO') {result <- 'RESULTADO FINANCIERO BRUTO'}
        
        if (nameCuenta=='OTROS_INGRESOS_OPERATIVOS') {result <- 'OTROS INGRESOS OPERATIVOS'}
        if (nameCuenta=='OTROS_GASTOS_OPERATIVOS') {result <- 'OTROS GASTOS OPERATIVOS'}
        if (nameCuenta=='RESULTADO_DE_OPERACION_BRUTO') {result <- 'RESULTADO DE OPERACION BRUTO'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_DE_OPERACION_DESPUES_DE_INCOBRABLES') {result <- 'RESULTADO DE OPERACION DESPUES DE INCOBRABLES'}
        
        if (nameCuenta=='EERR_S2_GASTOS_DE_ADMINISTRACION') {result <- 'GASTOS DE ADMINISTRACION'}
        if (nameCuenta=='EERR_S2_GASTOS_DE_PERSONAL') {result <- 'GASTOS DE PERSONAL'}
        if (nameCuenta=='EERR_S2_SERVICIOS_CONTRATADOS') {result <- 'SERVICIOS CONTRATADOS'}
        if (nameCuenta=='EERR_S2_SEGUROS') {result <- 'SEGUROS'}
        if (nameCuenta=='EERR_S2_COMUNICACIONES_Y_TRASLADOS') {result <- 'COMUNICACIONES Y TRASLADOS'}
        if (nameCuenta=='EERR_S2_IMPUESTOS') {result <- 'IMPUESTOS'}
        if (nameCuenta=='EERR_S2_MANTENIMIENTO_Y_REPARACIONES') {result <- 'MANTENIMIENTO Y REPARACIONES'}
        if (nameCuenta=='EERR_S2_DEPRECIACION_Y_DESVALORIZACION_DE_BIENES_DE_USO') {result <- 'DEPRECIACION Y DESVALORIZACION DE BIENES DE USO'}
        if (nameCuenta=='EERR_S2_AMORTIZACION_DE_CARGOS_DIFERIDOS_Y_ACTIVOS_INTANGIBLES') {result <- 'AMORTIZACION DE CARGOS DIFERIDOS Y ACTIVOS INTANGIBLES'}
        if (nameCuenta=='EERR_S2_OTROS_GASTOS_DE_ADMINISTRACION') {result <- 'OTROS GASTOS DE ADMINISTRACION'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_DE_OPERACION_NETO') {result <- 'RESULTADO DE OPERACION NETO'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_DESPUES_DE_AJUSTE_POR_DIFERENCIA_DE_CAMBIO_Y_MANTENIMIENTO_DE_VALOR') {result <- 'RESULTADO DESPUES DE AJUSTE POR DIFE. DE CAMB. Y MANT. DE VALOR'}
        if (nameCuenta=='EERR_S2_RESPECTO_INGRESOS_GASTOS_EXTRAORDINARIOS') {result <- 'RESPECTO INGRESOS GASTOS EXTRAORDINARIOS'}
        if (nameCuenta=='EERR_S2_RESULTADO_NETO_DEL_EJERCICIO_ANTES_DE_AJUSTES_DE_GESTIONES_ANTERIORES') {result <- 'RESULTADO NETO DEL EJERCICIO ANTES DE AJUSTES DE GESTIONES ANTERIORES'}
        if (nameCuenta=='EERR_S2_RESPECTO_INGRESOS_GASTOS_DE_GESTIONES_ANTERIORES') {result <- 'RESPECTO INGRESOS GASTOS DE GESTIONES ANTERIORES'}
        if (nameCuenta=='EERR_S2_RESULTADO_ANTES_DE_IMPUESTOS_Y_AJUSTE_CONTABLE_POR_EFECTO_DE_INFLACION') {result <- 'RESULTADO ANTES DE IMPUESTOS Y AJUSTE CONTABLE POR EFECTO DE INFLACION'}
        if (nameCuenta=='EERR_S2_RESPECTO_AJUSTE_CONTABLE_POR_EFECTO_DE_LA_INFLACION') {result <- 'RESPECTO AJUSTE CONTABLE POR EFECTO DE LA INFLACION'}
        if (nameCuenta=='EERR_S2_RESULTADO_ANTES_DE_IMPUESTOS') {result <- 'RESULTADO ANTES DE IMPUESTOS'}
        if (nameCuenta=='EERR_S2_IMPUESTO_SOBRE_LAS_UTILIDADES_DE_LAS_EMPRESAS') {result <- 'IMPUESTO SOBRE LAS UTILIDADES DE LAS EMPRESAS'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_NETO_DE_LA_GESTION') {result <- 'RESULTADO NETO DE LA GESTION'}
        
        #OTROS
        if (nameCuenta=='COEFICIENTE_DE_ADECUACION_PATRIMONIAL') {result <- 'COEFICIENTE DE ADECUACION PATRIMONIAL'}
        

        
        return(result)
    }
    
    n <- nrow(dat)
    for (i in 1:n) { dat[i,1] <- converCuentas(dat[i,1])}
    
    return(dat)
}


transformTableAuxPef2 <- function(dat) {
    
    converCuentas <- function(nameCuenta) {
        
        result <- nameCuenta
        
        if (nameCuenta=='ACTIVO') {result <- 'ACTIVO'}
        
        if (nameCuenta=='ACTIVO_DISPONIBILIDADES') {result <- 'Disponibilidades'}
        if (nameCuenta=='ACTIVO_INVERSIONES_TEMPORARIAS') {result <- 'Inversiones Temporarias'}
        
        if (nameCuenta=='ACTIVO_CARTERA') {result <- 'CARTERA'}
        
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL') {result <- 'Cartera Vencida Total'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VENCIDA') {result <- 'Cartera Vencida'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA') {result <- 'Cartera Reprogramada Vencida'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VENCIDA') {result <- 'Cartera Reestructurada Vencida'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VENCIDA') {result <- 'Cartera Reprogramada O Reestructurada Vencida'}
        
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL') {result <- 'Cartera Ejecucion Total'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_EN_EJECUCION') {result <- 'Cartera En Ejecucion'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION') {result <- 'Cartera Reprogramada Ejecucion'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_EN_EJECUCION') {result <- 'Cartera Reestructurada En Ejecucion'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_EN_EJECUCION') {result <- 'Cartera Reprogramada O Reestructurada En Ejecucion'}
        
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VIGENTE_TOTAL') {result <- 'Cartera Vigente Total'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_VIGENTE') {result <- 'Cartera Vigente'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE') {result <- 'Cartera Reprogramada Vigente'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VIGENTE') {result <- 'Cartera Reestructurada Vigente'}
        if (nameCuenta=='ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VIGENTE') {result <- 'Cartera Reprogramada O Reestructurada Vigente'}
        
        if (nameCuenta=='ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA') {result <- 'Prevision Para Incobrabilidad De Cartera'}
        
        if (nameCuenta=='ACTIVO_OTRAS_CUENTAS_POR_COBRAR') {result <- 'Otras Cuentas Por Cobrar'}
        if (nameCuenta=='ACTIVO_BIENES_REALIZABLES') {result <- 'Bienes Realizables'}
        if (nameCuenta=='ACTIVO_INVERSIONES_PERMANENTES') {result <- 'Inversiones Permanentes'}
        if (nameCuenta=='ACTIVO_BIENES_DE_USO') {result <- 'Bienes De Uso'}
        if (nameCuenta=='ACTIVO_OTROS_ACTIVOS') {result <- 'Otros Activos'}
        if (nameCuenta=='ACTIVO_FIDEICOMISOS_CONSTITUIDOS') {result <- 'Fideicomisos Constituidos'}
        
        if (nameCuenta=='PASIVO') {result <- 'PASIVO'}
        
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_EL_PUBLICO') {result <- 'Obligaciones Con El Publico'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_INSTITUCIONES_FISCALES') {result <- 'Obligaciones Con Instituciones Fiscales'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_EMPRESAS_PUBLICAS') {result <- 'Obligaciones Con Empresas Publicas'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_CON_BANCOS_Y_ENTIDADES_DE_FINANCIAMIENTO') {result <- 'Obligaciones Con Bancos Y Entidades De Financiamiento'}
        if (nameCuenta=='PASIVO_OTRAS_CUENTAS_POR_PAGAR') {result <- 'Otras Cuentas Por Pagar'}
        if (nameCuenta=='PASIVO_PREVISIONES') {result <- 'Previsiones'}
        if (nameCuenta=='PASIVO_VALORES_EN_CIRCULACION') {result <- 'Valores En Circulacion'}
        if (nameCuenta=='PASIVO_OBLIGACIONES_SUBORDINADAS') {result <- 'Obligaciones Subordinadas'}
        
        if (nameCuenta=='PATRIMONIO') {result <- 'PATRIMONIO'}
        if (nameCuenta=='PATRIMONIO_CAPITAL_SOCIAL') {result <- 'Capital Social'}
        if (nameCuenta=='PATRIMONIO_APORTES_NO_CAPITALIZADOS') {result <- 'Aportes No Capitalizados'}
        if (nameCuenta=='PATRIMONIO_AJUSTES_AL_PATRIMONIO') {result <- 'Ajustes Al Patrimonio'}
        if (nameCuenta=='PATRIMONIO_RESERVAS') {result <- 'Reservas'}
        if (nameCuenta=='PATRIMONIO_RESULTADOS_ACUMULADOS') {result <- 'Resultados Acumulados'}
        
        if (nameCuenta=='PATRIMONIO_PASIVO_PATRIMONIO') {result <- 'TOTAL PASIVO PATRIMONIO'}
        
        if (nameCuenta=='CUENTAS_CONTINGENTES_DEUDORAS') {result <- 'CONTINGENTES DEUDORAS'}
        if (nameCuenta=='CUENTAS_CONTINGENTES_DEUDORAS_CUENTAS_DE_ORDEN_DEUDORAS') {result <- 'CUENTAS DE ORDEN DEUDORAS'}
        
        #ESTADODERESULTADOS
        if (nameCuenta=='INGRESOS_FINANCIEROS') {result <- 'Ingresos Financieros'}
        if (nameCuenta=='GASTOS_FINANCIEROS') {result <- 'Gastos Financieros'}
        if (nameCuenta=='RESULTADO_FINANCIERO_BRUTO') {result <- 'RESULTADO FINANCIERO BRUTO'}
        
        if (nameCuenta=='OTROS_INGRESOS_OPERATIVOS') {result <- 'Otros Ingresos Operativos'}
        if (nameCuenta=='OTROS_GASTOS_OPERATIVOS') {result <- 'Otros Gastos Operativos'}
        if (nameCuenta=='RESULTADO_DE_OPERACION_BRUTO') {result <- 'RESULTADO DE OPERACION BRUTO'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_DE_OPERACION_DESPUES_DE_INCOBRABLES') {result <- 'RESULTADO DE OPERACION DESPUES DE INCOBRABLES'}
        
        if (nameCuenta=='EERR_S2_GASTOS_DE_ADMINISTRACION') {result <- 'Gastos De Administracion'}
        if (nameCuenta=='EERR_S2_GASTOS_DE_PERSONAL') {result <- 'Gastos De Personal'}
        if (nameCuenta=='EERR_S2_SERVICIOS_CONTRATADOS') {result <- 'Servicios Contratados'}
        if (nameCuenta=='EERR_S2_SEGUROS') {result <- 'Seguros'}
        if (nameCuenta=='EERR_S2_COMUNICACIONES_Y_TRASLADOS') {result <- 'Comunicaciones Y Traslados'}
        if (nameCuenta=='EERR_S2_IMPUESTOS') {result <- 'Impuestos'}
        if (nameCuenta=='EERR_S2_MANTENIMIENTO_Y_REPARACIONES') {result <- 'Mantenimiento Y Reparaciones'}
        if (nameCuenta=='EERR_S2_DEPRECIACION_Y_DESVALORIZACION_DE_BIENES_DE_USO') {result <- 'Depreciacion Y Desvalorizacion De Bienes De Uso'}
        if (nameCuenta=='EERR_S2_AMORTIZACION_DE_CARGOS_DIFERIDOS_Y_ACTIVOS_INTANGIBLES') {result <- 'Amortizacion De Cargos Diferidos Y Activos Intangibles'}
        if (nameCuenta=='EERR_S2_OTROS_GASTOS_DE_ADMINISTRACION') {result <- 'Otros Gastos De Administracion'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_DE_OPERACION_NETO') {result <- 'RESULTADO DE OPERACION NETO'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_DESPUES_DE_AJUSTE_POR_DIFERENCIA_DE_CAMBIO_Y_MANTENIMIENTO_DE_VALOR') {result <- 'RESULT. DESP. DE AJT. POR DIF. DE CAMB. Y MANT. DE VALOR'}
        if (nameCuenta=='EERR_S2_RESPECTO_INGRESOS_GASTOS_EXTRAORDINARIOS') {result <- 'Respecto Ingresos Gastos Extraordinarios'}
        if (nameCuenta=='EERR_S2_RESULTADO_NETO_DEL_EJERCICIO_ANTES_DE_AJUSTES_DE_GESTIONES_ANTERIORES') {result <- 'RESULT. NETO DEL EJERCI. ANTES DE AJUST. DE GEST. ANTE.'}
        if (nameCuenta=='EERR_S2_RESPECTO_INGRESOS_GASTOS_DE_GESTIONES_ANTERIORES') {result <- 'Respecto Ingresos Gastos De Gestiones Anteriores'}
        if (nameCuenta=='EERR_S2_RESULTADO_ANTES_DE_IMPUESTOS_Y_AJUSTE_CONTABLE_POR_EFECTO_DE_INFLACION') {result <- 'RESULT. ANT. DE IMP. Y AJUSTE CONT. POR EFECTO DE INFL.'}
        if (nameCuenta=='EERR_S2_RESPECTO_AJUSTE_CONTABLE_POR_EFECTO_DE_LA_INFLACION') {result <- 'Respecto Ajuste Contable Por Efecto De La Inflacion'}
        if (nameCuenta=='EERR_S2_RESULTADO_ANTES_DE_IMPUESTOS') {result <- 'RESULTADO ANTES DE IMPUESTOS'}
        if (nameCuenta=='EERR_S2_IMPUESTO_SOBRE_LAS_UTILIDADES_DE_LAS_EMPRESAS') {result <- 'Impuesto Sobre Las Utilidades De Las Empresas'}
        
        if (nameCuenta=='EERR_S2_RESULTADO_NETO_DE_LA_GESTION') {result <- 'RESULTADO NETO DE LA GESTION'}
        
        #OTROS
        if (nameCuenta=='COEFICIENTE_DE_ADECUACION_PATRIMONIAL') {result <- 'COEFICIENTE DE ADECUACION PATRIMONIAL'}
        
        
        
        return(result)
    }
    
    n <- nrow(dat)
    for (i in 1:n) { dat[i,1] <- converCuentas(dat[i,1])}
    
    return(dat)
}






