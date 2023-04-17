library(fpp2)

source('RECURSOS-INVESTIGACION\\NOTAS\\camel-calculo\\camel-indicadores-calculo.R')


id <- 'indAdm_CCGA'
dat <- dat
dat <- datCamelInd
gestInc <- min(as.numeric(format(dat$FECHA, format='%Y')))
gestFn <- max(as.numeric(format(dat$FECHA, format='%Y')))

tsDat <- ts(matrix(0, nrow=(gestFn-gestInc+1)*12, ncol=length(unique(dat$TIPO_DE_ENTIDAD))), 
            start=gestInc, frequency=12)

for (i in 1:length(unique(dat$TIPO_DE_ENTIDAD))) {
    
    tipoEnt <- as.character(unique(dat$TIPO_DE_ENTIDAD)[i])
    colnames(tsDat)[i] <- tipoEnt
    x <- dat[dat$TIPO_DE_ENTIDAD==tipoEnt,][order(dat[dat$TIPO_DE_ENTIDAD==tipoEnt,'FECHA']),id]
    x <- sapply(x, as.numeric)
    tsDat[,i] <- x
}

autoplot(tsDat)
