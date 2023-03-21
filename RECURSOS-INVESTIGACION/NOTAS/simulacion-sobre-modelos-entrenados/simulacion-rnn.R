library(fpp2)

fit <- nnetar(sunspotarea,lambda=0)

nSim <- 3L
h <- 20L

sim <- ts(matrix(0, nrow=h, ncol=nSim),
          start=end(sunspotarea)[1L]+1L)

for(i in seq(nSim)){
    sim[,i] <- simulate(fit, nsim=h)
}

autoplot(sunspotarea) + 
    autolayer(forecast(fit,h=h), series = 'proyeccion') +
    autolayer(sim)
