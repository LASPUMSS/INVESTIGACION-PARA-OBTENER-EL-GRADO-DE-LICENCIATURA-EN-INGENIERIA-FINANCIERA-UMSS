

getTableRefenceCamelCalificaciones <- function() {
    
    raiting <- as.character(1:5)
    
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

getTableRefenceCamelCalificaciones2 <- function(calificadorDuro=FALSE) {
    
    raiting <- as.character(1:5)
    
    if (calificadorDuro) {
        rango <- c('Menor a L1', 
                   'De L1 a L2',
                   'De L2 a L3',
                   'De L3 a L4',
                   'Mayor a L4')
        
    } else {
        
        rango <- c('De L1 a L2', 
                   'De L2 a L3',
                   'De L3 a L4',
                   'De L4 a L5',
                   'Mayor a L5')
    }
    
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
                            RANGO=rango,
                            SIGNIFICADO=significado)
    
    return(datResult)
    
}