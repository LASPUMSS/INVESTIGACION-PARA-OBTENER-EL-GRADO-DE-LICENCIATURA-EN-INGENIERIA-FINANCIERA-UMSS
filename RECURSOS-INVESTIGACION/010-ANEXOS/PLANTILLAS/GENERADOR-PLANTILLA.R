source('RECURSOS-INVESTIGACION/R/get-dat-basic-normalizada.R')
source('RECURSOS-INVESTIGACION/R/pef-r2-ids-eeff-forecast.R')
source('RECURSOS-INVESTIGACION/R/pef-list-summary-resumen.R')
source('RECURSOS-INVESTIGACION/R/pef-get-dats-for-forescat.R')
source('RECURSOS-INVESTIGACION/R/pef-get-ids-for-models.R')
source("RECURSOS-INVESTIGACION/R/pef-get-camel-test.R")
source("RECURSOS-INVESTIGACION/R/pef-aux-render-table.R")
source("RECURSOS-INVESTIGACION/R/pef-aux-render-plot.R")
source("RECURSOS-INVESTIGACION/R/render-table-basic.R")

require(kableExtra)
require(patchwork)
require(ggplot2)
require(dplyr)
require(fpp2)

if (!('listResultPEF' %in% ls())) {
    
    datTotalSistema <- getDatEEFFNormalizada(by = 'TOTAL_SISTEMA')
    
    ids <- getVariablesForModelsForecast()
    
    if (!file.exists('FUENTES-DE-DATOS/DATA/listResultPEF.rds')) {
        listResultPEF <- getListFittedAndSimulateModels(datTotalSistema,ids)
    }else{
        listResultPEF <- readRDS(file ='FUENTES-DE-DATOS/DATA/listResultPEF.rds')
    }
    
    
}

excluirCuentas <- c(
    # UTILIZADOS EN EN CAP 5
    'ACTIVO',
    'PASIVO',
    'PATRIMONIO',
    'INGRESOS_FINANCIEROS',
    'GASTOS_FINANCIEROS',
    'RESULTADO_FINANCIERO_BRUTO',
    'RESULTADO_DE_OPERACION_BRUTO',
    'EERR_S2_RESULTADO_DE_OPERACION_NETO',
    'EERR_S2_RESULTADO_NETO_DE_LA_GESTION',
    
    # GRAFICO INCIAL ANEXOS
    'ACTIVO_DISPONIBILIDADES'
    )

siglasCuentas <- names(listResultPEF)[!names(listResultPEF) %in% excluirCuentas]

all_dirs <-
    rep('RECURSOS-INVESTIGACION/010-ANEXOS/PLANTILLAS/PLANTILLA-GRAFICO-PROYECCION-MODELOS.Rmd', 
        length(siglasCuentas))

new_dirs <- 
    paste0('RECURSOS-INVESTIGACION/010-ANEXOS/GRAFICOS-PROYECCIONES-POR-CUENTA/',
           siglasCuentas,
           '.Rmd')
rm_dirs <- 
    paste0('RECURSOS-INVESTIGACION/010-ANEXOS/GRAFICOS-PROYECCIONES-POR-CUENTA/',
           names(listResultPEF),
           '.Rmd')

file.remove(rm_dirs[file.exists(rm_dirs)])

file.copy(all_dirs, new_dirs)
