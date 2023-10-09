
listResultPEF <- readRDS(file ='FUENTES-DE-DATOS/DATA/listResultPEF.rds')

CUENTA <- sapply(listResultPEF, FUN = function(cuenta){
    
    cuenta[['nameAccount']]
    
})

DIFERENCIAL <- sapply(listResultPEF, FUN = function(cuenta){
    
    arimaModel <- cuenta[['arimaModel']]
    arimaNdiff <- arimaorder(arimaModel)['d']
    arimaNdiff
    
    })


datResult <- data.frame(CUENTA=CUENTA,
                        DIFERENCIAL=DIFERENCIAL, row.names = NULL)
