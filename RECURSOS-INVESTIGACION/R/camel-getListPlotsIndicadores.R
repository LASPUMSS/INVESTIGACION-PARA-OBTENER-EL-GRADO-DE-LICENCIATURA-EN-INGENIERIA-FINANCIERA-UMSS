getListPlotsInd <- function(listResult, scaleOne=FALSE, numDigScale=NULL) {
    
    require(ggplot2)
    require(scales)
    
    listPlots <- list()
    n <- length(listResult)
    
    for (i in seq(n)) {
        
        id <- listResult[[i]][['id']]
        p <- listResult[[i]][['p']]
        
        if (i==n) {
            
            p <- p + 
                theme(legend.text = element_text(size=24),
                      legend.key.size = unit(2, 'cm'),
                      axis.title.x=element_text(size=24),
                      axis.title.y = element_text(size=30),
                      axis.text.y=element_text(size=24),
                      axis.text.x = element_text(size=24))
            
        } else {
            p <- p +
                theme(legend.position = "none",
                      axis.title.x=element_blank(),
                      axis.title.y = element_text(size=30),
                      axis.text.y=element_text(size=24),
                      axis.text.x=element_blank())
        }
        
        if (scaleOne) {
            p <- p + scale_y_continuous(labels = label_number(accuracy = 1))
        }
        
        if (!is.null(numDigScale)) {
            p <- p + scale_y_continuous(labels = label_number(accuracy = numDigScale))
        }
        
        listPlots[[id]] <- p
    }
    
    return(listPlots)
}

