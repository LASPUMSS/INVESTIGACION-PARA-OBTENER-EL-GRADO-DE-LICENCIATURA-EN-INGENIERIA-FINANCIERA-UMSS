if (!('utils' %in% ls())) { utils <- list() }

utils$handleRenderPerfil <- function(){
  
  ruta <- paste0(getwd(), '/PRINCIPAL-PERFIL-DE-INVESTIGACION.Rmd')
  rmarkdown::render(ruta)
  
}
