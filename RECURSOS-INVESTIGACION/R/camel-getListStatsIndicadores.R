getListStatsOverviewInd <- function(ids, datCamelIndNorm, datIdsNamesCamelInds,roundInd=FALSE) {
    
    source('RECURSOS-INVESTIGACION/R/camel-tendencia-stats-overview.R')
    source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
    
    require(dplyr)
    
    listResult <- list()
    
    for (i in 1:length(ids)) {
        
        id <- ids[i]
        nameIndById <- 
            datIdsNamesCamelInds %>% 
            filter(INDICADOR==id) %>% 
            select(NOMBRES) %>% 
            pull()
        idsDecreasing <- 
            datIdsNamesCamelInds %>% 
            filter(INDICADOR==id) %>% 
            select(DECRECIENTE) %>% 
            pull()
        datTrendInd <- 
            getDatTrendStatsOverviewInd(id, datCamelIndNorm, roundInd ,idsDecreasing)
        nameEntBestPromedio <- 
            datTrendInd %>% 
            select(TIPO_DE_ENTIDAD) %>% 
            slice(1) %>% 
            pull()
        bestPromedio <- 
            datTrendInd %>% 
            select(PROMEDIO) %>% 
            slice(1) %>% 
            pull()
        p <- plotIndCamel(id, datCamelIndNorm)
        
        listResult[[id]] <- 
            list(id=id,
                 nameIndById=nameIndById,
                 idsDecreasing=idsDecreasing,
                 datTrendInd=datTrendInd,
                 nameEntBestPromedio=nameEntBestPromedio,
                 bestPromedio=bestPromedio,
                 p=p)
    }
    
    
    return(listResult)
}
