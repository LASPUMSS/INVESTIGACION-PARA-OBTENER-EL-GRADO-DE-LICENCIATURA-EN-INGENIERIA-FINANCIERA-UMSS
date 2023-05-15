
renderTableCamelIndNorm <- function(id='indCap', datCamelIndNorm, captionTable='Indicadores de capital CAMEL') {
    
    require(knitr)
    require(kableExtra)
    require(dplyr)
    
    cols <- 
        grepl(id, names(datCamelIndNorm)) + 
        grepl('FECHA', names(datCamelIndNorm)) + 
        grepl('TIPO_DE_ENTIDAD', names(datCamelIndNorm))
    
    dat <- datCamelIndNorm[,as.logical(cols)]
    
    dat$TIPO_DE_ENTIDAD <- gsub('_',' ', dat$TIPO_DE_ENTIDAD)
    namesDat <- gsub('indCap ', '',
                     gsub('indAct ', '',
                          gsub('indAdm ', '',
                               gsub('indBenf ', '',
                                    gsub('indLq ', '',
                                         gsub('_',' ', names(dat)))))))
    names(dat) <- namesDat
    
    
    result <- 
        kable(dat, "latex", 
                    booktabs = TRUE, 
                    longtable = TRUE, 
                    caption = captionTable, 
                    digits = 6) %>%
        kable_styling(latex_options = c("hold_position", "repeat_header"),
                      font_size = 7,
                      repeat_header_text = "(Continuación)")
    
    return(result)
}



renderTableCamelIndNorm2 <- function(id1='indAdm', id2='indBenf',datCamelIndNorm, captionTable='Indicadores de id1 y id2 CAMEL') {
    
    require(knitr)
    require(kableExtra)
    require(dplyr)
    
    cols <- 
        grepl(id1, names(datCamelIndNorm)) + 
        grepl(id2, names(datCamelIndNorm)) + 
        grepl('FECHA', names(datCamelIndNorm)) + 
        grepl('TIPO_DE_ENTIDAD', names(datCamelIndNorm))
    
    dat <- datCamelIndNorm[,as.logical(cols)]
    
    dat$TIPO_DE_ENTIDAD <- gsub('_',' ', dat$TIPO_DE_ENTIDAD)
    namesDat <- gsub('indCap ', '',
                     gsub('indAct ', '',
                          gsub('indAdm ', '',
                               gsub('indBenf ', '',
                                    gsub('indLq ', '',
                                         gsub('_',' ', names(dat)))))))
    names(dat) <- namesDat
    
    
    result <- 
        kable(dat, "latex", 
              booktabs = TRUE, 
              longtable = TRUE, 
              caption = captionTable, 
              digits = 6) %>%
        kable_styling(latex_options = c("hold_position", "repeat_header"),
                      font_size = 7,
                      repeat_header_text = "Continuación")
    
    return(result)
}
