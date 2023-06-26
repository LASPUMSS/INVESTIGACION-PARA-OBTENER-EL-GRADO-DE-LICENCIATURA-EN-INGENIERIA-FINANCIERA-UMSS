fittedTsModels <- function(model, tsDatTrain) {
    
    x <- fitted(model)
    y <- tsDatTrain
    
    result <- (cor(x, y, use="complete.obs"))^2
    
    return(result)
}
