library(fpp2)

tsDat <- ts(matrix(0, nrow=(2022-2021+1)*12, ncol=length(unique(dat$TIPO_DE_ENTIDAD))), 
            start=2021, frequency=12)

for (i in 1:length(unique(dat$TIPO_DE_ENTIDAD))) {
    
    tipoEnt <- as.character(unique(dat$TIPO_DE_ENTIDAD)[i])
    colnames(tsDat)[i] <- tipoEnt
    x <- dat[dat$TIPO_DE_ENTIDAD==tipoEnt,][order(dat[dat$TIPO_DE_ENTIDAD==tipoEnt,'FECHA']),'ACTIVO']
    x <- sapply(x, as.numeric)
    tsDat[,i] <- x
}

autoplot(tsDat[,-2])