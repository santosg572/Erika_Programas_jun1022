rm(list=ls())

library(imager)

folder = "R022-d1-c2-nuevo"
patI = "/Users/santosg/ubuntu21_MatLab_may2722/"

source('funciones_imagenes.R')


pat_datos = './'
file = 'frn-1.png'
file = paste(patI, folder, '/', file, sep='')
img = Lee_Img_PNG(file)
cat ('dimensiones imagen: ', dim(img), '\n')
par(mfrow=c(3,3))
#Despliega_Img(img, 'cruda')

ban=1
uno=1
	
ss = dim(img)
nx = ss[1]
ny = ss[2]

i0 = 320
j0 = 70

imgN = img
del = 7
imgN[(i0-del):(i0+del), (j0-del):(j0+del)] = 1
Despliega_Img(imgN, 'fija el cuadrado')

if (ban == uno){	
	vec = img[(i0-del):(i0+del), (j0-del):(j0+del)]
	s = dim(vec)
	dim(vec) = s[1]*s[2]
	med = median(vec)
	sd1 = sd(vec)
	
	imgB = abs(img - med) > sd1
	
	Despliega_Img(imgB, 'umbralizacion')
	imgErode = rep(0, nx*ny)
	dim(imgErode) = c(nx, ny, 1,1) 
	imgErode[,,1,1] = imgB
	imgB = erode_square(imgErode, 3)
	imgB = imgB[,,1,1]
	#print(dim(imgB))
	Despliega_Img(imgB, 'erode')
	
	s = Enc_i0j0(imgB, i0, j0)
	i0 = s[1]
	j0 = s[2]
	print(c(i0, j0, img[i0, j0]))
	
	del = 7
	imgN[(i0-del):(i0+del), (j0-del):(j0+del)] = 1
	#Despliega_Img(imgN, 'punto frontera')
	
		res = Enc_Frontera(imgB, i0, j0)
		print(res)
		imgN = matrix(rep(0, nx*ny), ncol=ny)
		
		x = res[[1]]
		y = res[[2]]
		
		n = length(x)
		print(n)
		
		del = 5
		
		for (i in 1:n){
			imgN[(x[i]-del):(x[i]+del), (y[i]-del):(y[i]+del)] = 1
		}
		
		Despliega_Img(imgN, 'contorno-crecido')
		
		imgN = imgN*imgB
Despliega_Img(imgN, 'contorno-pelado')
file = paste(patI, folder, '/', folder,'_aro', '.RData', sep='')
save(x,y, file=file)
}
