
Saca_parametros_Rata_Inicial <- function(i0=0, j0=0,val_mascara=0, img=0){	
	ss = dim(img)
	nx = ss[1]
	ny = ss[2]
	
	imgt= img
	
	del = 10
	imgt[(i0-del):(i0+del), (j0-del):(j0+del)] = val_mascara
	
	Despliega_Img(imgt, 'con mascara')
	
	vec = img[(i0-del):(i0+del), (j0-del):(j0+del)]
	vec = CovierteMatTOVec(vec)
	
	med = median(vec)
	sd1 = sd(vec)

    res = c(med, sd1)	
}


Segmenta_Rata_Inicial <- function(img=0, r=0){
	PX <<- c()
	PY <<- c()
	IMGT <<- img
	MED <<- r[1]
	SD1 <<- r[2]
	N <<- 650
	SegmentarGris(i0, j0)
	imgt= CreaImg(nx, ny)
	n = length(PX)
	vec = c()
	
	for (i in 1:n){
		imgt[PX[i], PY[i]] = 1
		vec = c(vec, img[PX[i], PY[i]])
	}
	
	Despliega_Img(imgt)
	filenameO = paste('frnO-',num,'.png', sep='')
	fileO = paste(patO, filenameO, sep='')
	writePNG(imgt, fileO)
	r = list(PX, PY)
}


Segmenta_Imagen <- function(img=0, media=0, des_estan=0, i0=0, j0=0){
	PX <<- c()
	PY <<- c()
	IMGT <<- img
	MED <<- media
	SD1 <<- des_estan
	N <<- 2000
	ss = dim(img)
	NX <<- ss[1]
	NY <<- ss[2]
	SegmentarGris(i0, j0)

	r = list(PX, PY)
}
