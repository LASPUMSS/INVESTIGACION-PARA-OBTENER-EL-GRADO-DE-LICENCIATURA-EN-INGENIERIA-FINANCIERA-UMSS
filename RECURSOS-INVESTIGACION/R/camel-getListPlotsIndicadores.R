getListPlotsInd <- function(listResult) {
    
    require(ggplot2)
    
    listPlots <- list()
    n <- length(listResult)
    
    for (i in seq(n)) {
        
        id <- listResult[[i]][['id']]
        p <- listResult[[i]][['p']]
        
        if (i==n) {
            
            p <- p + 
                theme(legend.text = element_text(size=24),
                      axis.title.x=element_text(size=24),
                      axis.title.y = element_text(size=30),
                      axis.text.y=element_text(size=15),
                      axis.text.x = element_text(size=24))
            
        } else {
            p <- p +
                theme(legend.position = "none",
                      axis.title.x=element_blank(),
                      axis.title.y = element_text(size=30),
                      axis.text.y=element_text(size=15),
                      axis.text.x=element_blank())
        }
        
        listPlots[[id]] <- p
    }
    
    return(listPlots)
}
