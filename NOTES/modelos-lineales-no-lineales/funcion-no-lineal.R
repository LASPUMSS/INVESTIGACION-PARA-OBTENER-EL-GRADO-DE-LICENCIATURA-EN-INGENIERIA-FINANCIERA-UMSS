library(dplyr)
library(ggplot2)

noLinealData <- function(x) {
    
    if (x>=(-Inf) && x<(-2)) {
        resultado <- -2.186*x-12.864
        return(resultado)
    }
    
    if (x>=(-2) && x<0) {
        resultado <- -4.246*x
        return(resultado)
    }
    
    if (x>=0 && x<Inf) {
        resultado <- (10*exp(-0.05*x-0.5)) * sin((0.03*x+0.7)*x)
        return(resultado)
    }
}

x <- -10:10
data <- data.frame(x=x, y=as.numeric(lapply(x, noLinealData)))

# Modelo Lineal
data %>% 
    ggplot(aes(x=x,y=y)) + 
    geom_line() + 
    geom_smooth(method = 'lm', formula = data$y~data$y )

