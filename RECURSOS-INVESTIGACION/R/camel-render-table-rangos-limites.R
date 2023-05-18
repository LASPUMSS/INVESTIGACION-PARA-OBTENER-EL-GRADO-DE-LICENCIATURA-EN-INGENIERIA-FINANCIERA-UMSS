renderTableCamelRangosLimites <- function(dat) {
    
    dat$INDICADOR <- gsub('indCap ', '',
                          gsub('indAct ', '',
                               gsub('indAdm ', '',
                                    gsub('indBenf ', '',
                                         gsub('indLq ', '',
                                              gsub('_',' ', dat$INDICADOR))))))
    
    require(knitr)
    require(kableExtra)
    
    result <- 
        kbl(dat, 
            longtable = T, 
            booktabs = T, 
            caption = "Limites para indicadores CAMEL") %>%
        add_header_above(c(" ", " ", "LIMITES (L)" = 5)) %>%
        kable_styling(latex_options = c("repeat_header"), 
                      font_size = 8)
    
    return(result)
    
}