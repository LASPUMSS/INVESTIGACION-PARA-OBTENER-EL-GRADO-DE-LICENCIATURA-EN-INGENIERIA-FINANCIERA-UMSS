getTableCamelRangosLimites <- function(dat) {
    
    require(knitr)
    require(kableExtra)
    
    result <- 
        kbl(dat, 
            longtable = T, 
            booktabs = T, 
            caption = "Rangos y limites para indicadores CAMEL") %>%
        add_header_above(c(" ", " ", "Rangos - Limites" = 5)) %>%
        kable_styling(latex_options = c("repeat_header"), 
                      font_size = 7)
    
    return(result)
    
}