
transformPlotAuxPef <- function(listResultPEF, cuenta, labelCuenta) {
    
    result <- 
        autoplot(listResultPEF[[cuenta]][['tsDatTrain']], 
                       ylab = labelCuenta, 
                       xlab = '',
                       series = 'DATOS ENTRENAMIENTO') + 
        autolayer(listResultPEF[[cuenta]][['tsDatTest']], 
                  series = 'DATOS EFECTIVAMENTE OBSERVADOS') +
        autolayer(forecast(listResultPEF[[cuenta]][['mcoModel']], h = 12), 
                  PI = FALSE,
                  series = 'PROYECIONES MCO') +
        autolayer(forecast(listResultPEF[[cuenta]][['arimaModel']], h = 12), 
                  PI = FALSE,
                  series = 'PROYECIONES ARIMA') +
        autolayer(forecast(listResultPEF[[cuenta]][['nnModel']], h = 12), 
                  PI = FALSE,
                  series = 'PROYECIONES NN') +
        theme(legend.text = element_text(size=24),
              legend.position="bottom",
              legend.key.size = unit(2, 'cm'),
              axis.title.x=element_text(size=24),
              axis.title.y = element_text(size=30),
              axis.text.y=element_text(size=24),
              axis.text.x = element_text(size=24)) + 
        guides(color=guide_legend(ncol=2, title="")) 
    

    
    return(result)
}

