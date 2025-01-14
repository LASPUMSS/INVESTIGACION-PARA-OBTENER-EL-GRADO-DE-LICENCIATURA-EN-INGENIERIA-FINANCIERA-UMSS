getVariablesForModelsForecast <- function() {
    ids <- c('ACTIVO',
             
             'ACTIVO_DISPONIBILIDADES',
             'ACTIVO_INVERSIONES_TEMPORARIAS',
             
             'ACTIVO_CARTERA',
             
             'ACTIVO_CARTERA_CARTERA_VENCIDA_TOTAL',
             'ACTIVO_CARTERA_CARTERA_VENCIDA',
             'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VENCIDA',
             'ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VENCIDA',
             'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VENCIDA',
             
             'ACTIVO_CARTERA_CARTERA_EJECUCION_TOTAL',
             'ACTIVO_CARTERA_CARTERA_EN_EJECUCION',
             'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_EJECUCION',
             'ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_EN_EJECUCION',
             'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_EN_EJECUCION',
             
             'ACTIVO_CARTERA_CARTERA_VIGENTE_TOTAL',
             'ACTIVO_CARTERA_CARTERA_VIGENTE',
             'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_VIGENTE',
             'ACTIVO_CARTERA_CARTERA_REESTRUCTURADA_VIGENTE',
             'ACTIVO_CARTERA_CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VIGENTE',
             
             'ACTIVO_CARTERA_PREVISION_PARA_INCOBRABILIDAD_DE_CARTERA',
             
             'ACTIVO_OTRAS_CUENTAS_POR_COBRAR',
             'ACTIVO_BIENES_REALIZABLES',
             'ACTIVO_INVERSIONES_PERMANENTES',
             'ACTIVO_BIENES_DE_USO',
             'ACTIVO_OTROS_ACTIVOS',
             'ACTIVO_FIDEICOMISOS_CONSTITUIDOS',
             
             'PASIVO',
             
             'PASIVO_OBLIGACIONES_CON_EL_PUBLICO',
             'PASIVO_OBLIGACIONES_CON_INSTITUCIONES_FISCALES',
             'PASIVO_OBLIGACIONES_CON_EMPRESAS_PUBLICAS',
             'PASIVO_OBLIGACIONES_CON_BANCOS_Y_ENTIDADES_DE_FINANCIAMIENTO',
             'PASIVO_OTRAS_CUENTAS_POR_PAGAR',
             'PASIVO_PREVISIONES',
             'PASIVO_VALORES_EN_CIRCULACION',
             'PASIVO_OBLIGACIONES_SUBORDINADAS',
             
             'PATRIMONIO',
             'PATRIMONIO_CAPITAL_SOCIAL',
             'PATRIMONIO_APORTES_NO_CAPITALIZADOS',
             'PATRIMONIO_AJUSTES_AL_PATRIMONIO',
             'PATRIMONIO_RESERVAS',
             'PATRIMONIO_RESULTADOS_ACUMULADOS',
             
             'CUENTAS_CONTINGENTES_DEUDORAS',
             'CUENTAS_CONTINGENTES_DEUDORAS_CUENTAS_DE_ORDEN_DEUDORAS',
             
             # ESTADO DE RESULTADOS
             'INGRESOS_FINANCIEROS',
             'GASTOS_FINANCIEROS',
             'RESULTADO_FINANCIERO_BRUTO',
             
             'OTROS_INGRESOS_OPERATIVOS',
             'OTROS_GASTOS_OPERATIVOS',
             'RESULTADO_DE_OPERACION_BRUTO',
             
             'EERR_S2_RESULTADO_DE_OPERACION_DESPUES_DE_INCOBRABLES',
             
             'EERR_S2_GASTOS_DE_ADMINISTRACION',
             'EERR_S2_GASTOS_DE_PERSONAL',
             'EERR_S2_SERVICIOS_CONTRATADOS',
             'EERR_S2_SEGUROS',
             'EERR_S2_COMUNICACIONES_Y_TRASLADOS',
             'EERR_S2_IMPUESTOS',
             'EERR_S2_MANTENIMIENTO_Y_REPARACIONES',
             'EERR_S2_DEPRECIACION_Y_DESVALORIZACION_DE_BIENES_DE_USO',
             'EERR_S2_AMORTIZACION_DE_CARGOS_DIFERIDOS_Y_ACTIVOS_INTANGIBLES',
             'EERR_S2_OTROS_GASTOS_DE_ADMINISTRACION',
             
             'EERR_S2_RESULTADO_DE_OPERACION_NETO',
             
             'EERR_S2_RESULTADO_DESPUES_DE_AJUSTE_POR_DIFERENCIA_DE_CAMBIO_Y_MANTENIMIENTO_DE_VALOR',
             'EERR_S2_RESPECTO_INGRESOS_GASTOS_EXTRAORDINARIOS',
             'EERR_S2_RESULTADO_NETO_DEL_EJERCICIO_ANTES_DE_AJUSTES_DE_GESTIONES_ANTERIORES',
             'EERR_S2_RESPECTO_INGRESOS_GASTOS_DE_GESTIONES_ANTERIORES',
             'EERR_S2_RESULTADO_ANTES_DE_IMPUESTOS_Y_AJUSTE_CONTABLE_POR_EFECTO_DE_INFLACION',
             'EERR_S2_RESPECTO_AJUSTE_CONTABLE_POR_EFECTO_DE_LA_INFLACION',
             'EERR_S2_RESULTADO_ANTES_DE_IMPUESTOS',
             'EERR_S2_IMPUESTO_SOBRE_LAS_UTILIDADES_DE_LAS_EMPRESAS',
             
             'EERR_S2_RESULTADO_NETO_DE_LA_GESTION',
             
             # OTROS
             'COEFICIENTE_DE_ADECUACION_PATRIMONIAL'
             
             )
    
    return(ids)
}