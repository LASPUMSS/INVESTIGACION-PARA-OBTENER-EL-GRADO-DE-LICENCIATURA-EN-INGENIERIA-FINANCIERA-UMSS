renderListTablesInd <- function(listResult ,captionTable, c, fontSize=8) {
    
    
    require(dplyr)
    require(knitr)
    require(kableExtra)
    
    listTables <- list()
    n <- length(listResult)
    datTrendIndTotal <- data.frame()
    
    for (i in seq(n)) {
        
        id <- listResult[[i]][['id']]
        datTrendInd <- listResult[[i]][['datTrendInd']]
        datTrendInd <- datTrendInd %>% select(-c(MINIMO, MAXIMO))
        
        datTrendIndTotal <-  bind_rows(datTrendIndTotal,datTrendInd)
    }
    
    names(datTrendIndTotal) <- gsub('_',' ', names(datTrendIndTotal))
    
    tableResult <- 
        kbl(datTrendIndTotal,
            longtable = T,
            booktabs = T, 
            digits = 6,
            caption =captionTable) %>% 
        row_spec(0,bold=TRUE) %>% 
        kable_styling(latex_options = c("hold_position", "repeat_header"),
                      font_size = fontSize,
                      repeat_header_text = "(Continuación)")
    
    
    nIn <- 1
    nFn <- c
    
    for (i in seq(n)) {
        
        nameIndById <- listResult[[i]][['nameIndById']]
        nameIndById <- str_to_upper(nameIndById)
        
        if (i!=1) {
            nIn <- nIn + c
            nFn <- nFn + c
        }
        
        tableResult <-  
            tableResult %>% 
            pack_rows(nameIndById, nIn, nFn, latex_gap_space = "1em") 
    }
    
    return(tableResult)
}
