if (!('utils' %in% ls())) { utils <- list() }

utils$handleRenderPresentacion<- function(){
    
    ruta <- paste0(getwd(), '/RECURSOS-INVESTIGACION/PRESENTACION/PRESENTACION.Rmd')
    rmarkdown::render(ruta, knit_root_dir = getwd())
    
}
