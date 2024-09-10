rm(list=ls())

pat1 = "/Users/santosg/Desktop/Erika_MOVIE/"
bib = paste(pat1, 'funciones_imagenes.R', sep='')
source(bib)

pat1 = '../nuevo/'
patO = '../rata/'
num = 151
filename = paste('frn-',num,'.png', sep='')
file = paste(pat1, filename, sep='')

img <- Lee_Img_PNG(file)

par(mfrow=c(2,2))
Despliega_Img(img)

