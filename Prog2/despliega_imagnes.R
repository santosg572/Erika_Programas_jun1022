rm(list=ls())

source('funciones_imagenes.R')

folder = "R022-d1-c2-nuevo"
patI = paste("/Users/santosg/ubuntu21_MatLab_may2722/", folder, sep='')

n = 11

file1 = paste('/frn-',n,'.png', sep='')
file1 = paste(patI, file1, sep='')
img1 <- Lee_Img_PNG(file1)

ss = dim(img1)


file2 = paste('/frn-',n+1,'.png', sep='')
file2 = paste(patI, file2, sep='')
img2 <- Lee_Img_PNG(file2)

file3 = paste('/frn-',n+2,'.png', sep='')
file3 = paste(patI, file3, sep='')
img3 <- Lee_Img_PNG(file3)

par(mfrow= c(2,2))

Despliega_Img(img1)
Despliega_Img(img2)
Despliega_Img(img3)

img3d = rep(0, ss[1]*ss[2]*3)
dim(img3d) = c(ss[1], ss[2], 3)

img3d[,,1] = img1
img3d[,,2] = img2
img3d[,,3] = img3

Despliega_Img(img3d)