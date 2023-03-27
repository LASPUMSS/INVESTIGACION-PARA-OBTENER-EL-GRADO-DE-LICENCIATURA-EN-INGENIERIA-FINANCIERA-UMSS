# LIBRERIAS NECESARIAS
pkgs <- utils::installed.packages()
pkgs_v <- c('fpp2',
            'patchwork', 
            'quantmod', 
            'tsbox', 
            'openxlsx',
            'GetoptLong', 
            'ggplot2',
            'dplyr')

vrf <- pkgs_v %in% pkgs[,1]

if (!all(vrf==TRUE)) {
    install.packages('fpp2')
    install.packages('patchwork')
    install.packages('quantmod')
    install.packages('tsbox')
    install.packages('openxlsx')
    install.packages('GetoptLong')
    install.packages('ggplot2')
    install.packages('dplyr')
}

library(fpp2)
library(quantmod)
library(tsbox)
library(openxlsx)
library(GetoptLong)
library(patchwork)

rm(list = c('pkgs','pkgs_v','vrf'))