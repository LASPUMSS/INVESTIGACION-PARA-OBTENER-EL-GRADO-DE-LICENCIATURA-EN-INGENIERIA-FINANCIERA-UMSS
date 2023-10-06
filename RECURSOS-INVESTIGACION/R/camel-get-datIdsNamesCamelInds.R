getDatIdsNamesCamelIndicadores <- function() {
    
    indicadoresCamelId <- data.frame(
        INDICADOR = c('indCap_CAP',        
                      'indCap_CCCM',
                      'indCap_CACCM',
                      'indCap_CCP',
                      
                      'indAct_CEC',
                      'indAct_CPC',
                      'indAct_CPCM',
                      'indAct_CRC',
                      
                      'indAdm_CCGA',
                      'indAdm_CACGA',
                      
                      'indBenf_ROA',
                      'indBenf_ROE',
                      
                      'indLq_CCPP',
                      'indLq_CACPP',
                      
                      'C',
                      'A',
                      'M',
                      'E',
                      'L',
                      'CAMEL',
                      'CAMEL_FLEXIBLE',
                      'CAMEL_ESTRICTO'
        ),
        NOMBRES = c('Coeficiente de adecuación patrimonial',        
                    'Coeficiente de cobertura de cartera en mora',
                    'Coeficiente acido de cobertura de cartera en mora',
                    'Coeficiente de cobertura patrimonial',

                    'Coeficiente de exposición de cartera',
                    'Coeficiente de previsión de cartera',
                    'Coeficiente de previsión de cartera en mora',
                    'Coeficiente de reposición de cartera',
                      
                    'Coeficiente de cobertura gastos administrativos',
                    'Coeficiente acido de cobertura gastos administrativos',
                      
                    'Coeficiente de rendimiento sobre activos',
                    'Coeficiente de rendimiento sobre patrimonio',
                      
                    'Coeficiente de capacidad de pago frente a pasivos',
                    'Coeficiente acido de capacidad de pago frente a pasivos',
                    
                    'C',
                    'A',
                    'M',
                    'E',
                    'L',
                    'CAMEL',
                    'CAMEL con rangos flexibles',
                    'CAMEL con rangos estrictos'
        ),
        DIRECCION = c('ASCENDENTE',        
                      'DESCENDENTE',
                      'DESCENDENTE',
                      'ASCENDENTE',
                      
                      'DESCENDENTE',
                      'ASCENDENTE',
                      'ASCENDENTE',
                      'DESCENDENTE',
                      
                      'DESCENDENTE',
                      'DESCENDENTE',
                      
                      'ASCENDENTE',
                      'ASCENDENTE',
                      
                      'ASCENDENTE',
                      'ASCENDENTE',
                      
                      'DESCENDENTE',
                      'DESCENDENTE',
                      'DESCENDENTE',
                      'DESCENDENTE',
                      'DESCENDENTE',
                      'DESCENDENTE',
                      'DESCENDENTE',
                      'DESCENDENTE'
        )
    )
    
    indicadoresCamelId$DECRECIENTE <- ifelse(indicadoresCamelId$DIRECCION=='ASCENDENTE', TRUE, FALSE)
    
    
    return(indicadoresCamelId)
    
}