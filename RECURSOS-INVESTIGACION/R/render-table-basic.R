
renderTableBasic <- function(dat, captionTable='tabla') {
    
    require(knitr)
    require(kableExtra)
    require(dplyr)
    
    names(dat) <- gsub('_',' ', names(dat))
    names(dat) <- gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(names(dat)), perl=TRUE)
    
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