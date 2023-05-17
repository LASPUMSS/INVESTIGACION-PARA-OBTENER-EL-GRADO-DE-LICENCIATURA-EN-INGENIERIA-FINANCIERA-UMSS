

getTableRefenceCamelCalificaciones <- function() {
    
    raiting <- 1:5
    
    descripcion <- c('Robusto', 
                     'Satisfactorio',
                     'Nomal',
                     'Marginal',
                     'Insatisfactorio')
    
    significado <- c('Solvente en todos aspectos',
                     'Generalmente solvente',
                     'Cierto nivel de vulnerabilidad',
                     'Problemas financieros serios',
                     'Serios problemas de solidez')
    
    datResult <- data.frame(RAITING =raiting,
                            DESCRIPCION=descripcion,
                            SIGNIFICADO=significado)
    
    return(datResult)
    
}