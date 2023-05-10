

toProperText <- function(x) {
    gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(x), perl=TRUE)
}