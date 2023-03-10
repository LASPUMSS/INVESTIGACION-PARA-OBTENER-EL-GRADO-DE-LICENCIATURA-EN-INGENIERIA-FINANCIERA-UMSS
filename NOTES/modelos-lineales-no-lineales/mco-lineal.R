library(dplyr)
library(ggplot2)

x <- -100:100
porceTrain <- 0.7
dataTrain <- data.frame(x_train = x[1:round(length(x)*porceTrain)], 
                        y_train = as.numeric(lapply(x[1:round(length(x)*porceTrain)], noLinealData)))
dataTest <- data.frame(x_test=x[(round(length(x)*porceTrain)+1):length(x)], 
                       y_test=as.numeric(lapply(x[(round(length(x)*porceTrain)+1):length(x)], noLinealData)))
rm(x)

fit <- lm(y_train~x_train, data = dataTrain)

# MODELO LINEAL
colors <- c("Observaciones" = "darkred", 
            "Modelo Ajustado" = "black", 
            "Observaciones Nuevas" = "darkred",
            "Prediciones" ="blue")

# GRAFICO
dataTrain %>% 
    ggplot(aes(x=x_train)) + 
    geom_line(aes(y=y_train, color = 'Observaciones')) + 
    geom_line(aes(y=predict(fit), color='Modelo Ajustado')) +
    geom_line(aes(x=x_test,y=y_test, color='Observaciones Nuevas'), data = dataTest) +
    geom_line(aes(x=x_test,y=predict(fit, data.frame(x_train=x_test)), color='Prediciones'), data = dataTest) +
    ggtitle('Datos No Lineales - MCO') +
    labs(x = "X",
         y = "Y",
         color = "Legend") +
    scale_color_manual(values = colors)
