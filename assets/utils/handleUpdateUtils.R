if (!('utils' %in% ls())) { utils <- list() }

# ACTUALIZAR UTILS LIST

utils$handleUpdateUtils <- function(){
    
    rm(list = c('utils'), pos = ".GlobalEnv")
    c <- 1
    if (c==1) {
        sapply( list.files('assets/utils', full.names=TRUE, pattern='\\.[rR]$'), source )
        print('Update my utils function')
        c <- 2
    }
    
}
