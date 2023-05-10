if (!('hanlde' %in% ls())) { handle <- list() }

handle$toProperText <- function(x) {
    return(gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(x), perl=TRUE))
}

handle$toUpperFirstText <- function(x) {
    x <- tolower(x)
    substr(x, 1, 1) <- toupper(substr(x, 1, 1))
    return(x)
}
