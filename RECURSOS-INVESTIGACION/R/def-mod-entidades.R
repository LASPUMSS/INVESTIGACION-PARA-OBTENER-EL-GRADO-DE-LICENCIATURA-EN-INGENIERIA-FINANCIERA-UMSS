source("RECURSOS-INVESTIGACION\\R\\get-dat-basic.R")

require(dplyr)
require(openxlsx)

dat <- getDatEEFF()

datDefEntMod <- dat %>% group_by(ENTIDIDAD,TIPO_DE_ENTIDAD) %>% summarise()
names(datDefEntMod) <- c('SIGLA','TIPO_DE_ENTIDAD')

BMU_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/siglas-entidades-financieras/SIGLAS-BANCOS-MULTIPLES.xlsx') 
BPY_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/siglas-entidades-financieras/SIGLAS-BANCOS-PYME.xlsx') 
BDR_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/siglas-entidades-financieras/SIGLAS-BDR.xlsx') 
COO_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/siglas-entidades-financieras/SIGLAS-COOPERATIVAS.xlsx') 
EFV_s <- read.xlsx('FUENTES-DE-DATOS/ASFI/siglas-entidades-financieras/SIGLAS-EFV.xlsx') 
IFD_S <- read.xlsx('FUENTES-DE-DATOS/ASFI/siglas-entidades-financieras/SIGLAS-IFD.xlsx') 

siglasEncotradas <- bind_rows(BMU_S,BPY_S,BDR_S,COO_S,EFV_s,IFD_S)

siglasResult <- left_join(datDefEntMod, siglasEncotradas, by = join_by(SIGLA == SIGLA))

siglasResult$TIPO_DE_ENTIDAD <- gsub('_',' ',siglasResult$TIPO_DE_ENTIDAD)
siglasResult$TIPO_DE_ENTIDAD <- gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(siglasResult$TIPO_DE_ENTIDAD), perl=TRUE)

