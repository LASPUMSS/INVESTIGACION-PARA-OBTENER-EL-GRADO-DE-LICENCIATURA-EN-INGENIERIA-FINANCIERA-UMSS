
getEntidadesCompModelo <- function() {
    
    # Paquetes Necesarios
    require(dplyr)
    require(openxlsx)
    
    # Funciones necesarias
    source("RECURSOS-INVESTIGACION/R/get-dat-basic.R")
    
    dateInEnt <- function(siglaEntidad, dat) {
        return(dat %>% 
                   filter(ENTIDIDAD==siglaEntidad) %>% 
                   select(FECHA) %>% 
                   pull() %>% 
                   min() %>% 
                   as.character())
    }
    
    dateFnEnt <- function(siglaEntidad,dat) {
        return(dat %>% 
                   filter(ENTIDIDAD==siglaEntidad) %>% 
                   select(FECHA) %>% 
                   pull() %>% 
                   max() %>% 
                   as.character())
    }
    
    # Cuerpo de la funcion
    dat <- getDatEEFF()
    
    datDefEntMod <- dat %>% group_by(ENTIDIDAD,TIPO_DE_ENTIDAD) %>% summarise()
    names(datDefEntMod) <- c('SIGLA','TIPO_DE_ENTIDAD')
    
    BMU_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/SiglasEntidadesFinancieras/SIGLAS-BANCOS-MULTIPLES.xlsx') 
    BPY_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/SiglasEntidadesFinancieras/SIGLAS-BANCOS-PYME.xlsx') 
    BDR_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/SiglasEntidadesFinancieras/SIGLAS-BDR.xlsx') 
    COO_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/SiglasEntidadesFinancieras/SIGLAS-COOPERATIVAS.xlsx') 
    EFV_s <- read.xlsx('FUENTES-DE-DATOS/ASFI/SiglasEntidadesFinancieras/SIGLAS-EFV.xlsx') 
    IFD_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/SiglasEntidadesFinancieras/SIGLAS-IFD.xlsx') 
    
    siglasEncotradas <- bind_rows(BMU_S,BPY_S,BDR_S,COO_S,EFV_s,IFD_S)
    
    siglasResult <- 
        left_join(datDefEntMod, siglasEncotradas, by = join_by(SIGLA == SIGLA)) %>% 
        mutate(DE=as.Date(sapply(SIGLA,dateInEnt, dat=dat)), 
               HASTA=as.Date(sapply(SIGLA,dateFnEnt, dat=dat))) %>% 
        arrange(TIPO_DE_ENTIDAD, DE)
    
    return(siglasResult)
}
