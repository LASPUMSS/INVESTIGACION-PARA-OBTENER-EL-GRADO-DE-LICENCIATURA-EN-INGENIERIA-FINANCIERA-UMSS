getListFittedAndSimulateModels <- function(dat=NULL, ids=NULL, n_simulaicones=100L, n_proyeciones=12L ) {
    
    source('RECURSOS-INVESTIGACION/R/pef-simulate-ts-models.R')
    source('RECURSOS-INVESTIGACION/R/pef-fitted-ts-models.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
    source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
    source('RECURSOS-INVESTIGACION/R/get-ts-from-dat.R')
    
    library(fpp2)
    library(dplyr)
    library(lubridate)
    library(ggplot2)
    library(patchwork)
    
    if (is.null(dat)) {
        dat <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
    }
    
    if (is.null(ids)) {
        ids <- c('ACTIVO')
    }
    
    
    gestionFn <- max(dat$FECHA) - years(1) + 4
    datTrain <- dat %>% filter(FECHA<gestionFn)
    datTest <- dat %>% filter(FECHA>gestionFn)
    
    listResult <- list()
    
    for (id in ids) {
        cat(paste0('\n',id))
        
        tsDatTrain <- getTsFromDat2(id,datTrain)
        tsDatTest <- getTsFromDat2(id,datTest)
        
        pps <- ifelse( ndiffs(tsDatTrain)>0, ndiffs(tsDatTrain),1)
            
        nnModel <- nnetar(tsDatTrain)
        mcoModel <- tslm(tsDatTrain~trend+season)
        arimaModel <- auto.arima(tsDatTrain)
        
        # Ajuste de modelos
        r2mcoModel <- fittedTsModels(mcoModel,tsDatTrain)
        r2nnModel <- fittedTsModels(nnModel,tsDatTrain)
        r2arimaModel <- fittedTsModels(arimaModel,tsDatTrain)
        
        # Simulación de modelos
        n_simulaicones <- n_simulaicones
        n_proyeciones <- n_proyeciones
        
        mcoModelSimulate <- simulateTsModels(mcoModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
        nnModelSimulate <- simulateTsModels(nnModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
        arimaModelSimulate <- simulateTsModels(arimaModel,n_simulaicones,n_proyeciones,tsDatTest,tsDatTrain)
        
        
        listResult[[id]] <- list(nameAccount=id,
                                 tsDatTrain=tsDatTrain,
                                 tsDatTest=tsDatTest,
                                 mcoModel=mcoModel,
                                 nnModel=nnModel,
                                 arimaModel=arimaModel,
                                 r2mcoModel=r2mcoModel,
                                 r2nnModel=r2nnModel,
                                 r2arimaModel=r2arimaModel,
                                 mcoModelSimulate=mcoModelSimulate,
                                 nnModelSimulate=nnModelSimulate,
                                 arimaModelSimulate=arimaModelSimulate)
    }
    
    return(listResult)
}

#############################################################
# Sin simulaciones
#############################################################

getListFittedAndSimulateModelsRNN <- function(dat=NULL, ids=NULL) {
    
    source('RECURSOS-INVESTIGACION/R/pef-fitted-ts-models.R')
    source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
    source('RECURSOS-INVESTIGACION/R/camel-plot-functions.R')
    source('RECURSOS-INVESTIGACION/R/get-ts-from-dat.R')
    
    library(fpp2)
    library(dplyr)
    library(lubridate)
    library(ggplot2)
    library(patchwork)
    
    if (is.null(dat)) {
        dat <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
    }
    
    if (is.null(ids)) {
        ids <- c('ACTIVO')
    }
    
    
    gestionFn <- max(dat$FECHA) - years(1) + 4
    datTrain <- dat %>% filter(FECHA<gestionFn)
    datTest <- dat %>% filter(FECHA>gestionFn)
    
    listResult <- list()
    
    for (id in ids) {
        
        tsDatTrain <- getTsFromDat2(id,datTrain)
        tsDatTest <- getTsFromDat2(id,datTest)
        
        nnModel <- nnetar(tsDatTrain)
        
        listResult[[id]] <- list(nameAccount=id,
                                 tsDatTrain=tsDatTrain,
                                 tsDatTest=tsDatTest,
                                 nnModel=nnModel)
    }
    
    print('Next ListFittedAndSimulateModelsRNN...')
    
    return(listResult)
}


