library(openxlsx)
library(dplyr)
library(zoo)

dat <- read.xlsx('FUENTES-DE-DATOS\\ASFI\\ConsoleAppPrepararDatos\\bin\\Debug\\DATOS_ASFI\\BBDD_ESTADOS_FINANCIEROS.xlsx')

dat$FECHA <- convertToDate(dat$FECHA)
