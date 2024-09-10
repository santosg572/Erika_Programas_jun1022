
rm(list=ls())

source('funciones_Imagenes.R')
source('funciones_Trayectoria.R')

toma_Muestra <- function(img=0, i0=0, j0=0, del=0, val=0){
	imgt = img
	imgt[(i0-del):(i0+del), (j0-del):(j0+del)] = 1
	Despliega_Img(imgt, let='imagen')
	imgm = img[(i0-del):(i0+del), (j0-del):(j0+del)]
	ss = dim(imgm)
	dim(imgm) = ss[1]*ss[2]
	ret = imgm
}

nx = 256
ny = 256

circulo <- function(img=0, i0=0, j0=0, rad=0, m1=0, m2=0){
	ss = dim(img)
	nx = ss[1]
	ny = ss[2]
	for (i in (i0-rad):(i0+rad)){
		for (j in (j0-rad):(j0+rad)){
			if (1 <= i & i <= nx & 1 <=j & j <= ny){
				del = (i-i0)^2 + (j -j0)^2
				if (del  < rad^2){
					img[i,j] = runif(1, min=m1, max=m2)
				}
			}
		}
	}
	ret = img
}

img = CreaImg(nx, ny)

img = circulo(img, nx/2, ny/2, 50, 0, .5)
img = circulo(img, 10, 20, 10, 0, .5)
img = circulo(img, 70, 80, 20, .5, 1)

Despliega_Img(img)

i0=70
j0=80
del = 2

m = toma_Muestra(img, i0, j0, del, 1)

media = mean(m)
sd1 = sd(m)

cat('media: ', media, ' sd: ', sd1, '\ns')

r = Segmenta_Imagen(img, media, sd1, i0, j0)

imgt = CreaImg(nx, ny)

ii = r[[1]]
jj = r[[2]]
np = length(ii)

for (i in 1:np){
	imgt[ii[i], jj[i]] = 1
}

Despliega_Img(imgt)