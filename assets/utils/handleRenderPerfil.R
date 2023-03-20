if (!('utils' %in% ls())) { utils <- list() }

utils$handleRenderPerfil <- function(){
  
  ruta <- paste0(getwd(), '/PRINCIPAL-PLAN-DE-INVESTIGACION.Rmd')
  rmarkdown::render(ruta, clean = TRUE)
  
}
