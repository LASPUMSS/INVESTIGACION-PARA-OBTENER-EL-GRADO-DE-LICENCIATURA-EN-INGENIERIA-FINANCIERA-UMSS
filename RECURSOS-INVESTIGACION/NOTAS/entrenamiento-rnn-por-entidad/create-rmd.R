siglasEntidades <- c('BCR','BEC','BFO','BFS','BGA','BIE','BIS','BME','BNA','BNB','BPR','BSO','BUN')


all_dirs <-
    rep('RECURSOS-INVESTIGACION/NOTAS/entrenamiento-rnn-por-entidad/BASE.Rmd', 
        length(siglasEntidades))

new_dirs <- 
    paste0('RECURSOS-INVESTIGACION/NOTAS/entrenamiento-rnn-por-entidad/entidades/',
           siglasEntidades,
           '.Rmd')

file.copy(all_dirs, new_dirs)

