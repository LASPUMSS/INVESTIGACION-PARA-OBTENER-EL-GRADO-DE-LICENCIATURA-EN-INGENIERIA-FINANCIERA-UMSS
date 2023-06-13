if (!('utils' %in% ls())) { utils <- list() }

# LIMPIAR MEMORIA

noVar <- c('utils')
rm(list =ls()[!(ls() %in% noVar)])

utils$handleCleanEnv <- function(){
    source('assets/utils/handleCleanEnv.R')
    print('Claer Env')
}