
renderTableBasic <- function(dat, captionTable='tabla', headerUpper=TRUE, fontSize=8) {
    
    require(knitr)
    require(kableExtra)
    require(dplyr)
    
    # Formato Titulos
    names(dat) <- gsub('_',' ', names(dat))
    
    if (headerUpper ) {
        names(dat) <- toupper(names(dat))
    } else{
        names(dat) <- gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(names(dat)), perl=TRUE)    
    }
    
    if ('TIPO DE ENTIDAD' %in% names(dat)) {
        dat[,'TIPO DE ENTIDAD'] <- gsub('_',' ', dat[,'TIPO DE ENTIDAD'])
    }
    
    
    result <- 
        kable(dat, "latex", 
              booktabs = TRUE, 
              longtable = TRUE, 
              caption = captionTable, 
              digits = 6,
              format.args = list(big.mark = " ") ) %>%
        kable_styling(latex_options = c("hold_position", "repeat_header"),
                      font_size = fontSize,
                      repeat_header_text = "(Continuación)")
    
    return(result)
}

renderTableBasic2 <- function(dat, captionTable='tabla', headerUpper=TRUE, fontSize=8) {
    
    require(knitr)
    require(kableExtra)
    require(dplyr)
    
    # Formato Titulos
    names(dat) <- gsub('_',' ', names(dat))
    
    if (headerUpper ) {
        names(dat) <- toupper(names(dat))
    } else{
        names(dat) <- gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(names(dat)), perl=TRUE)    
    }
    
    if ('TIPO DE ENTIDAD' %in% names(dat)) {
        dat[,'TIPO DE ENTIDAD'] <- gsub('_',' ', dat[,'TIPO DE ENTIDAD'])
    }
    
    
    result <- 
        kbl(dat, 
            longtable = T, 
            booktabs = T, 
            caption = "Limites para indicadores CAMEL") %>%
        kable_styling(latex_options = c("hold_position", "repeat_header"),
                      font_size = fontSize,
                      repeat_header_text = "(Continuación)")
    
    return(result)
}


renderTableBasicSinCaption <- function(dat, titulo='titulo' ,headerUpper=TRUE, fontSize=8) {
    
    require(knitr)
    require(kableExtra)
    require(dplyr)
    
    # Formato Titulos
    names(dat) <- gsub('_',' ', names(dat))
    
    if (headerUpper ) {
        names(dat) <- toupper(names(dat))
    } else{
        names(dat) <- gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(names(dat)), perl=TRUE)    
    }
    
    if ('TIPO DE ENTIDAD' %in% names(dat)) {
        dat[,'TIPO DE ENTIDAD'] <- gsub('_',' ', dat[,'TIPO DE ENTIDAD'])
    }
    
    myHeader <- c(titulo = ncol(dat))
    names(myHeader) <- titulo
    
    result <- 
        kable(dat, "latex", 
              booktabs = TRUE, 
              longtable = TRUE, 
              digits = 6,
              format.args = list(big.mark = " ") ) %>%
        add_header_above(header = myHeader) %>%
        kable_styling(latex_options = c("hold_position", "repeat_header"),
                      font_size = fontSize,
                      repeat_header_text = "(Continuación)")
    
    return(result)
}