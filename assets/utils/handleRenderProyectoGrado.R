if (!('utils' %in% ls())) { utils <- list() }

utils$handleRenderProyectoGrado <- function(){
    
    ruta <- paste0(getwd(), '/PRINCIPAL-PROYECTO-DE-GRADO.Rmd')
    rmarkdown::render(ruta)
    
}
