getTableTrendInd <- function(dat, captionTable='') {
    
    require(knitr)
    require(kableExtra)
    
    result <- 
        kbl(dat, 
            longtable = T, 
            booktabs = T, 
            caption = captionTable) %>%
        kable_styling(latex_options = c("repeat_header"), 
                      font_size = 7)
    
    return(result)
    
}