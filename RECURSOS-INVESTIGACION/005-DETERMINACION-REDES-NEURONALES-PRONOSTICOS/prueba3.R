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

dat <- getDatEEFFNormalizada(by = 'ENTIDAD')

EEFF_CCB <- dat %>% filter(TIPO_DE_ENTIDAD=='CCB')
