if (!('utils' %in% ls())) { utils <- list() }

utils$handleRenderInvestigacion<- function(){
    
    ruta <- paste0(getwd(), '/PRINCIPAL-INVESTIGACION.Rmd')
    rmarkdown::render(ruta, clean = TRUE)
    
}
