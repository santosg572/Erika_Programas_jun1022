rm(list=ls())

source('funciones_imagenes.R')

pati = '/Users/santosg/Desktop/Erika_MOVIE/nuevo/'
pat1 = pati
patO = './rata/'

Saca_parametros_Rata_Inicial <- function(img=0){
		
	par(mfrow=c(2,2))
	Despliega_Img(img, 'cruda')
	
	ss = dim(img)
	nx = ss[1]
	ny = ss[2]
	
	imgt= img
	
	i0 = 565
	j0 = 440
	del = 10
	imgt[(i0-del):(i0+del), (j0-del):(j0+del)] = 0
	
	Despliega_Img(imgt, 'con mascara')
	
	vec = img[(i0-del):(i0+del), (j0-del):(j0+del)]
	vec = CovierteMatTOVec(vec)
	
	med = median(vec)
	sd1 = sd(vec)
	print(c(med, sd1))

    res = c(med, sd1)	
}

num = 151
i0 = 565
j0 = 440
filename = paste('frn-',num,'.png', sep='')
file = paste(pat1, filename, sep='')
img <- Lee_Img_PNG(file)
ss = dim(img)
nx = ss[1]
ny = ss[2]


r = Saca_parametros_Rata_Inicial(img)

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
print(n)

vec = c()
for (i in 1:n){
	imgt[PX[i], PY[i]] = 1
	vec = c(vec, img[PX[i], PY[i]])
}

Despliega_Img(imgt)


filenameO = paste('frnO-',num,'.png', sep='')
fileO = paste(patO, filenameO, sep='')

writePNG(imgt, fileO)
}

Segmenta_Rata_Inicial(img, r)

#--------------------------------------------------------------------------
load('/Users/santosg/Desktop/Erika_datos_contorno/aro.RData')


continua = 1
if (continua){
for (k in 152:1778){

par(mfrow=c(2,2))

filename = paste('frn-',k,'.png', sep='')
file = paste(pat1, filename, sep='')
img <- Lee_Img_PNG(file)
ss = dim(img)
nx = ss[1]
ny = ss[2]
m = length(x)
del =5
for (i in 1:m){
	img[(x[i]-del):(x[i]+del), (y[i]-del):(y[i]+del)] = 0
}

Despliega_Img(img)

vec = c()
n = length(PX)

for (i in 1:n){
	vec = c(vec, img[PX[i], PY[i]])
}

med = median(vec)
sd1 = sd(vec)
cat('Media: ', med, ' Desciacion: ' ,sd1, '\n')

imgt= CreaImg(nx, ny)

i0 = 0
j0 = 0
for (i in 1:n){
	if(abs(img[PX[i], PY[i]]-med) < sd1){
		imgt[PX[i], PY[i]] = 1
		i0 = PX[i]
		j0 = PY[i]
	}
}

Despliega_Img(imgt)

cat ('i0: ', i0, ' j0: ', j0, '\n')
i0 = round(mean(PX))
j0 = round(mean(PY))

PX <<- c()
PY <<- c()
IMGT <<- img
MED <<- med
SD1 <<- sd1
N <<- 700

SegmentarGris(i0, j0)

imgt= CreaImg(nx, ny)

n = length(PX)
cat('Imagen:', k,' num. puntos= ', n, '\n')

for (i in 1:n){
	imgt[PX[i], PY[i]] = 1
}

Despliega_Img(imgt)

filenameO = paste('frnO-',k,'.png', sep='')
fileO = paste(patO, filenameO, sep='')

writePNG(imgt, fileO)
print(paste('----------------------------', k, '-------------------------'))
}
}