rm(list=ls())

pat1 = "../"
bib = paste(pat1, 'funciones_imagenes.R', sep='')
source(bib)

SegmentarGris <- function(i=0, j=0){
	IMGT[i,j] <<- 999
	PX <<- c(PX, i)
	PY <<- c(PY, j)

	for (ii in (i-1):(i+1)){
		for (jj in (j-1):(j+1)){
			if (abs(IMGT[ii,jj]-MED) < SD1 & N > 0){
				N <<- N-1
				SegmentarGris(ii, jj)
			}
		}
	}
}

CreaImg <- function(nx, ny){
	img = matrix(rep(0, nx*ny), ncol=ny)
}

CovierteMatTOVec <- function(mat){
	ss = dim(mat)
	dim(mat) = ss[1]*ss[2]
	res = mat
}

pat1 = '../nuevo/'
patO = '../rata/'
num = 151
filename = paste('frn-',num,'.png', sep='')
file = paste(pat1, filename, sep='')

img <- Lee_Img_PNG(file)

par(mfrow=c(2,2))
Despliega_Img(img)

ss = dim(img)
nx = ss[1]
ny = ss[2]

imgt= CreaImg(nx, ny)

i0 = 565
j0 = 440
del = 10
imgt[(i0-del):(i0+del), (j0-del):(j0+del)] = 1

Despliega_Img(imgt)

vec = img[(i0-del):(i0+del), (j0-del):(j0+del)]

vec = CovierteMatTOVec(vec)

med = median(vec)
sd1 = sd(vec)
print(c(med, sd1))

imgt= CreaImg(nx, ny)

for (i in (i0-del):(i0+del)){
	for (j in (j0-del):(j0+del)){
		if (abs(img[i,j]-med)< sd1){
			imgt[i,j] = 1
		}
	}
}

Despliega_Img(imgt)


PX <<- c()
PY <<- c()
IMGT <<- img
MED <<- med
SD1 <<- sd1
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
#--------------------------------------------------------------------------
for (k in 152:1778){

par(mfrow=c(2,2))

filename = paste('frn-',k,'.png', sep='')
file = paste(pat1, filename, sep='')
img <- Lee_Img_PNG(file)

Despliega_Img(img)

vec = c()
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
