# LIBRERIAS NECESARIAS
pkgs <-  data.frame(utils::installed.packages())[,'Package']
pkgs_v <- c('fpp2', 'dplyr', 'openxlsx','rmarkdown','ggplot2','kableExtra','patchwork','scales','glue')
pkgs_v2 <- pkgs_v
pkgs_v <- pkgs_v[!(pkgs_v %in% pkgs)]

if (length(pkgs_v)>=1) {
    install.packages(pkgs_v)
}else{
    print('Ya existe todos los paquete listados.')
}


lapply(pkgs_v2, require, character.only = TRUE)


rm(list = c('pkgs','pkgs_v','pkgs_v2'))
