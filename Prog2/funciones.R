library(png)

LeeIMG <- function(file=''){
	img <- readPNG(file)
}

LocalizaRegion <- function(img=0){
	ss = dim(img)
	nx = ss[1]
	ny = ss[2]

	i0 = 565
	j0 = 440
	del = 10
	
	imgt = img
	imgt[(i0-del):(i0+del), (j0-del):(j0+del)] = 0

	DespliegaIMG(imgt)

	imgM = img[(i0-del):(i0+del), (j0-del):(j0+del)]
	imgR = imgM
	m = dim(imgM)
	dim(imgM) = m[1]*m[2]

	me = median(imgM)
	sd1 = sd(imgM)

	imgt = img
	imgt[,] = 0
	val = c()
	px = c()
	py = c()
	del = round(2*del)
	for (i in (i0-del):(i0+del)){
		for (j in (j0-del):(j0+del)){
			if (abs(img[i,j] - me)< sd1){
				val = c(val, imgt[i,j])
				px = c(px, i)
				py = c(py, j)
				imgt[i,j] = 1
			}
		}
	}
	x = as.cimg(imgt)
	y = shrink(x,5)
	y = grow(y,15)
    imgt = as.matrix(y)
    
    for (i in 1:nx){
    	for (j in 1:ny){
    		if (imgt[i,j] == 1 & abs(img[i,j] - me) < sd1){
    			imgt[i,j] = 1
    		} else {
    			imgt[i,j] = 0
    		}
    	}
    }
    
    x = as.cimg(imgt)
	y = shrink(x,3)
	y = grow(y,3)
    imgt = as.matrix(y)
    
    val = c()
	px = c()
	py = c()
	
    for (i in 1:nx){
    	for (j in 1:ny){
    		if (imgt[i,j] == 1){
    			val = c(val, img[i,j])
				px = c(px, i)
				py = c(py, j)
    		} 
    	}
    }
    
	DespliegaIMG(imgt)
	res = list(val, px, py)
}

DespliegaIMG <- function(img=0){
	image(img, col=gray.colors(255))
}

distancia <- function(p1, p2){
	sqrt((p1[1]-p2[1])^2 + (p1[2]-p2[2])^2)
}

Segmenta <- function(n=0, R=0){
	file = paste('../nuevo/frn-',n,'.png', sep='')
	img <- LeeIMG(file)

	i0 = mean(R[[2]])
	j0 = mean(R[[3]])
	x1 = min(R[[2]])
	x2 = max(R[[2]])
	y1 = min(R[[3]])
	y2 = max(R[[3]])

	if (y2-y1 > x2-x1) {
		del = round((y2-y2)/2)
	} else {
		del = round((x2-x1)/2)
	}

	imgt = img
	imgt[(i0-del):(i0+del), (j0-del):(j0+del)] = 0

	DespliegaIMG(imgt)	

	me = median(R[[1]])
	sd1 = sd(R[[1]])

	imgt[,] = 0

	for (i in (i0-del):(i0+del)){
		for (j in (j0-del):(j0+del)) {
			if (abs(img[i,j] - me) < sd1) {
				imgt[i,j] = 1
			}	
		}
	}

	DespliegaIMG(imgt)

	x = as.cimg(imgt)
	y = shrink(x,3)
	y = grow(y,3)
    imgt = as.matrix(y)
    
    val = c()
	px = c()
	py = c()
	
    for (i in 1:nx){
    	for (j in 1:ny){
    		if (imgt[i,j] == 1){
    			val = c(val, img[i,j])
				px = c(px, i)
				py = c(py, j)
    		} 
    	}
    }
    
	DespliegaIMG(imgt)
	res = list(val, px, py)

}
