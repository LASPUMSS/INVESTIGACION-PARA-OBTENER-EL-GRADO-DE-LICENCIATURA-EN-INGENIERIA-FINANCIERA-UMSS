if (!('utils' %in% ls())) { utils <- list() }

utils$handleRenderMardown <- function(ruta=''){
    
    if(ruta=='') ruta <- file.choose()
    print(paste("RUTA:", ruta))
    rmarkdown::render(ruta)
  
}
