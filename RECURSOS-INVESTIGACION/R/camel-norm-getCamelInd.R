
datCamelInd <- getDatCamelInd()
datCamelInd$ID <- paste0(datCamelInd$TIPO_DE_ENTIDAD,
                         format(datCamelInd$FECHA, format='%Y'),
                         format(datCamelInd$FECHA, format='%m'))

gestionInc <- 2019
gestionFn <- 2022

# Numero de filas que debera tener el data.frame 
nGestiones <- (gestionFn-gestionInc+1)
nMeses <- 12
nEntidades <- 6
n <- nGestiones*nMeses*nEntidades

datCamelIndNorm <- data.frame(
    
    ID=rep(NA,n),
    FECHA=rep(NA,n),
    TIPO_DE_ENTIDAD=rep(NA,n),
    
    indCap_CCCM=rep(NA,n),
    indCap_CACCM=rep(NA,n),
    indCap_CCP=rep(NA,n),
    
    indAct_CEC=rep(NA,n),
    indAct_CPC=rep(NA,n),
    indAct_CPCM=rep(NA,n),
    indAct_CRC=rep(NA,n),
    
    indAdm_CCGA=rep(NA,n),
    indAdm_CACGA=rep(NA,n),
    
    indBenf_ROA=rep(NA,n),
    indBenf_ROE=rep(NA,n),
    
    indLq_CCPP=rep(NA,n),
    indLq_CACPP=rep(NA,n)
    
)

entidades <- c(
    "BANCOS_DE_DESARROLLO_PRODUCTIVO",
    "BANCOS_MULTIPLES",
    "BANCOS_PYME" ,
    "COPERATIVAS_DE_AHORRO_Y_CREDITO",
    "ENTIDADES_FINANCIERAS_DE_VIVIENDA",
    "INSTITUCIONES_FINANCIERAS_DE_DESARROLLO"
       )

datCamelIndNorm$TIPO_DE_ENTIDAD <- sort(rep(entidades,nMeses*nGestiones))

mesesId <- c('01','02','03','04','05','06','07','08','09','10','11','12')
fechas <- vector()

for (i in seq(gestionInc, gestionFn)) {
    
    for (i2 in mesesId) {
        
        fechas <- append(fechas, paste0(i,'-',i2,'-28'))
        
    }
    
}

datCamelIndNorm$FECHA <- as.Date(rep(fechas,nEntidades))
datCamelIndNorm$ID <- paste0(datCamelIndNorm$TIPO_DE_ENTIDAD,
                         format(datCamelIndNorm$FECHA, format='%Y'),
                         format(datCamelIndNorm$FECHA, format='%m'))


datResult <- datCamelIndNorm[!(datCamelIndNorm$ID %in% datCamelInd$ID),]
datResult <- merge(datResult, datCamelInd, all = T)

