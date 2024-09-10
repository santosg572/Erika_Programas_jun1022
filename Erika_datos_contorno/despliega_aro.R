rm(list=ls())

folder = "R022-d1-c2-nuevo"
patI = "/Users/santosg/ubuntu21_MatLab_may2722/"

source('funciones_imagenes.R')


file = paste(patI, folder, '/', folder,'_aro', '.RData', sep='')
load(file=file)

plot(x,y
)