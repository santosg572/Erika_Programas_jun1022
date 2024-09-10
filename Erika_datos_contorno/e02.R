rm(list=ls())

source('funciones.R')

load("x_dat")

imgEnc = x
print(x)
nn = dim(imgEnc)
nx = nn[1]
ny = nn[2]

listas = list()
k = 1

for (i in 1:nx){
	for (j in 1:ny){
		if(imgEnc[i,j] == 1){
			xx = c(i)
			yy = c(j)
			EncReg(i, j)
			listas[[k]] = matrix(c(xx,yy), ncol=2)
			k = k+1
		}
	}
}

print(listas)

