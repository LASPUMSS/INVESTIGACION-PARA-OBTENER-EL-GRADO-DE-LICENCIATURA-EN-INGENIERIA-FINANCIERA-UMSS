if (!('hanlde' %in% ls())) { handle <- list() }

handle$toProperText <- function(x) {
    require(stringr)
    
    x <- str_trim(x)
    x <- str_to_title(x)
    return(x)
}

handle$toUpperFirstText <- function(x) {
    require(stringr)
    
    x <- str_trim(x)
    x <- str_to_sentence(x)
    return(x)
}


