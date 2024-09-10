rm(list=ls())

source('funciones_imagenes.R')
source('funciones_Trayectoria.R')

folder = "R022-d1-c2-nuevo"
patI = paste("/Users/santosg/ubuntu21_MatLab_may2722/", folder, sep='')

patO = paste(patI, '/rata', sep='')

#dir.create (patO)

num = 1
filename = paste('/frn-',num,'.png', sep='')
file = paste(patI, filename, sep='')
img <- Lee_Img_PNG(file)
cat('max img: ', max(img), '\n')
#img = round(256*img)
img = Filtra_Imagen(img)
ss = dim(img)
nx = ss[1]
ny = ss[2]

i0 = 300
j0 = 368
del = 10
par(mfrow=c(2,2))

r = toma_Muestra(img, i0, j0, del, 0)

media = median(r)
sd1 = sd(r)

#cat('media: ', media, ' sd: ', sd1, '\n')

	
r = Segmenta_Imagen(img, media, sd1, i0, j0)

ii = r[[1]]
jj = r[[2]]

np =  length(ii)

imgt = CreaImg(nx, ny)

for (i in 1:np){
	imgt[ii[i], jj[i]] = 1
}

Despliega_Img(imgt, 'segmentada')

continua = 1
if (continua){

for (k in 2:10){
	filename = paste('/frn-',k,'.png', sep='')
	file = paste(patI, filename, sep='')
	img <- Lee_Img_PNG(file)
	img = Filtra_Imagen(img)
	
	Despliega_Img(img, paste('imagen cruda: ', k))
	
	vec = c()
	
	for (i in 1:np){
		vec = c(vec, img[ii[i], jj[i]])
	}
	
	med = mean(vec)
	sd1 = sd(vec)
	i0 = round(mean(ii))
	j0 = round(mean(jj))
    s = Segmenta_Imagen(img, med, sd1, i0, j0)	
    
    ii = s[[1]]
    jj = s[[2]]

np =  length(ii)

#cat(" num puntos: ", np, " media inicial: ", r[[1]], " des. standard: ", r[[2]] , '\n' )

imgt = CreaImg(nx, ny)

for (i in 1:np){
	imgt[ii[i], jj[i]] = 1
}

Despliega_Img(imgt, 'segmentada')

	
}
}
