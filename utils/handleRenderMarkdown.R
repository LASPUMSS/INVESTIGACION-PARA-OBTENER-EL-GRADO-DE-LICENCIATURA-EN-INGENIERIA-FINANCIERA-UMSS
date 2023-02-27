if (!('utils' %in% ls())) { utils <- list() }

utils$handleRenderMardown <- function(){
  
  ruta <- file.choose()
  rmarkdown::render(ruta)
  
}
