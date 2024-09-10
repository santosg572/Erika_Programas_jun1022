rm(list=ls())

source('/Users/santosg/R_Analisis_Imagenes_may0922/funciones_imagenes.R')

CovierteMatTOVec <- function(mat){
	ss = dim(mat)
	dim(mat) = ss[1]*ss[2]
	res = mat
}

SegmentarBin2 <- function(i=0, j=0){
	IMGT[i,j] <<- 0
	PX <<- c(PX, i)
	PY <<- c(PY, j)

	for (ii in (i-1):(i+1)){
		for (jj in (j-1):(j+1)){
			if (IMGT[ii,jj] == 1 ){
				SegmentarBin2(ii, jj)
		    }
		 }
	}
}


SegmentarGris <- function(i=0, j=0){
	IMGT[i,j] <<- 999
	PX <<- c(PX, i)
	PY <<- c(PY, j)

	for (ii in (i-1):(i+1)){
		for (jj in (j-1):(j+1)){
			if (abs(IMGT[ii,jj]-MED) < SD1/3 & N>0){
				N <<-  N-1
				print(N)
				SegmentarGris(ii, jj)
		    }
		 }
	}
}

CreaImg <- function(nx, ny){
	img = matrix(rep(0, nx*ny), ncol=ny)
}

TomaMuestra <- function(img, i0, j0){
	del = 25
	imgt = img
	imgt[(i0-del):(i0+del), (j0-del):(j0+del)] = 0
    Despliega_Img(imgt)
    vec = img[(i0-del):(i0+del), (j0-del):(j0+del)]
    vec = CovierteMatTOVec(vec)
    med = mean(vec)
    sd1 = sd(vec)
    ret = c(med, sd1)	
}

filtroMediano <- function(img=0){
	s = dim(img)
	nx = s[1]
	ny = s[2]
	imgt = CreaImg(nx, ny)
	for (i in 2:(nx-1)){
		for (j in 2:(ny-1)){
			imgtt = img[(i-1):(i+1), (j-1):(j+1)]
			v = CovierteMatTOVec(imgtt)
			imgt[i,j] = median(v)
		}
	}
	ret = imgt
}

pat1 = '../nuevo/'
patO = '../rata/'
num = 151
filename = paste('frn-',num,'.png', sep='')
file = paste(pat1, filename, sep='')

img <- Lee_Img_PNG(file)
#img = filtroMediano(img)

par(mfrow=c(2,2))
Despliega_Img(img)

ss = dim(img)
nx = ss[1]
ny = ss[2]

imgt= img

p1 = c(265, 598)

i0 = 580
j0 = 50

mm = TomaMuestra(img, i0, j0)
print(mm)

con2 = 0
if (con2 ==1){
med = mm[1]
sd1 = mm[2]

imgt = CreaImg(nx, ny)

for (i in 1:nx){
	for (j in 1:ny){
		if (abs(img[i,j]-med) < sd1){
			imgt[i,j] = 1
		}
	}
}

Despliega_Img(imgt)
}

conti = 0
if (conti == 1){
med = mm[1]
sd1 = mm[2]

PX <<- c()
PY <<- c()
IMGT <<- img
MED <<- med
SD1 <<- sd1
N <<- 3000

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
}
