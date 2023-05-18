
getDatCamelRangosLimites <- function(datCamelIndNorm){
    
    require(dplyr)
    
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
                      'indLq_CACPP'
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
                      'ASCENDENTE'
        )
    )
    
    camel_l1 <- function(x) {mean(x, na.rm = TRUE)-2*sd(x, na.rm = TRUE)}
    camel_l2 <- function(x) {mean(x, na.rm = TRUE)-sd(x, na.rm = TRUE)}
    camel_l3 <- function(x) {mean(x, na.rm = TRUE)}
    camel_l4 <- function(x) {mean(x, na.rm = TRUE)+sd(x, na.rm = TRUE)}
    camel_l5 <- function(x) {mean(x, na.rm = TRUE)+2*sd(x, na.rm = TRUE)}
    
    dat <- datCamelIndNorm
    dat <- dat[,!(names(dat) %in% c('ID','FECHA','TIPO_DE_ENTIDAD'))]
    
    l1 <-  t(dat %>% summarise_all(camel_l1))
    l1 <- data.frame(INDICADOR=row.names(l1), L1=l1)
    
    l2 <-  t(dat %>% summarise_all(camel_l2))
    l2 <- data.frame(INDICADOR=row.names(l2), L2=l2)
    
    l3 <-  t(dat %>% summarise_all(camel_l3))
    l3 <- data.frame(INDICADOR=row.names(l3), L3=l3)
    
    l4 <-  t(dat %>% summarise_all(camel_l4))
    l4 <- data.frame(INDICADOR=row.names(l4), L4=l4)
    
    l5 <-  t(dat %>% summarise_all(camel_l5))
    l5 <- data.frame(INDICADOR=row.names(l5), L5=l5)
    
    
    camel_limites <- l1 %>% 
        left_join(l2, by = join_by(INDICADOR == INDICADOR), relationship = 'one-to-one') %>% 
        left_join(l3, by = join_by(INDICADOR == INDICADOR), relationship = 'one-to-one') %>% 
        left_join(l4, by = join_by(INDICADOR == INDICADOR), relationship = 'one-to-one') %>% 
        left_join(l5, by = join_by(INDICADOR == INDICADOR), relationship = 'one-to-one') %>% 
        left_join(indicadoresCamelId, by = join_by(INDICADOR == INDICADOR), relationship = 'one-to-one') %>% 
        relocate(DIRECCION, .after = INDICADOR)
    
    
    for (i in 1:nrow(camel_limites)) {
        
        valor <- camel_limites[i,2]
        
        if (valor=='DESCENDENTE') {
            camel_limites[i,-(1:2)] <- sort(t(camel_limites[i,-(1:2)]))
        }
        
        if (valor=='ASCENDENTE') {
            camel_limites[i,-(1:2)] <- sort(t(camel_limites[i,-(1:2)]), decreasing = T)
        }
    }
    
    return(camel_limites)
}





