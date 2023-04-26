getTableTrendInd <- function(dat, captionTable='', idsDecreasing=TRUE) {
    
    require(knitr)
    require(kableExtra)
    
    names(dat) <- gsub('_',' ', names(dat))
    
    dat <- dat[order(dat$TENDENCIA, decreasing = idsDecreasing),]
    
    datResult <- data.frame(TIPO_DE_ENTIDAD=dat[,1],
                            TENDENCIA=dat[,2])
    names(datResult) <- gsub('_',' ', names(datResult))
    
    result <- 
        kbl(datResult, 
            longtable = F, 
            booktabs = T, 
            caption = captionTable) %>%
        kable_styling(latex_options = c("repeat_header"), 
                      font_size = 7)
    
    return(result)
    
}