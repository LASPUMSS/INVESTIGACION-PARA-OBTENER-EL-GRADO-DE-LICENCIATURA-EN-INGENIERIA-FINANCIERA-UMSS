library(fpp2)

fitLn <- tslm(sunspotarea~trend)

fitNnear <- nnetar(sunspotarea, lambda=0)


autoplot(sunspotarea) + 
    autolayer(fitted(fitLn), series = 'Datos Ajustados') +
    autolayer(forecast(fitLn, h = 20), series = 'Proyeciones', PI = T)

autoplot(sunspotarea) + 
    autolayer(fitted(fitNnear), series = 'Datos Ajustados') +
    autolayer(forecast(fitNnear, h = 20), series = 'Proyeciones', PI = T)

autoplot(sunspotarea) + 
    autolayer(simulate(fitNnear, nsim = 20)) + 
    autolayer(simulate(fitNnear, nsim = 20)) + 
    autolayer(simulate(fitNnear, nsim = 20))

