Lee_Img_JPG <- function(file=''){
	library(jpeg) 
	img <- readJPEG(file)
}

Lee_Img_PNG <- function(file=''){
	library(png) 
	img <- readPNG(file)
}

Despliega_Img <- function(img=0, let=''){
	ss = dim(img)
	if(exists("rasterImage")){
      plot(1:2, type='n', main=let)
      rasterImage(img,1,1,2,2)
   }
 }


Enc_i0j0 <- function(img=0, i0=1, j0=1){
	nn = dim(img)
	nx = nn[1]
	ny = nn[2]
	
	i = i0
	while (i <= nx){
		j = j0
		while (j <= ny){
			if(img[i,j] == 1){
				i0 = i
				j0 = j
				i = nx+1
				j = ny+1
			} 
			j = j+1
		}
		i = i+1
	}
	res = c(i0,j0)
}

EncReg <- function(ii=0, jj=0){
	imgEnc[ii, jj] <<-  0
	i1 = ii-1
	if (i1 < 1){
		i1 = 1
	}
	i2 = ii+1
	if (i2 > nx){
		i2 = nx
	}
	
	j1 = jj-1
	if (j1 < 1){
		j1 = 1
	}
	j2 = jj+1
	if (j2 > ny){
		j2 = ny
	}
		
	for (i in i1:i2){
		for (j in j1:j2){
			if(imgEnc[i,j] == 1){
				xx <<- c(xx, i)
				yy <<- c(yy, j)
				EncReg(i,j)
			}
		}
	}
}

Fue_Uno <- function(x1,y1, x2, y2){
	if (x1 == x2){
		if (y1 < y2){
			x2 = x1-1
			y2 = y1
		} else {
			x2 = x1+1
			y2 = y1
		}
	} else {
		if (x1 < x2){
			x2 = x1
			y2 = y1+1
		} else{
			x2 = x1
			y2 = y1-1
		}
	}
	res = c(x1, y1, x2, y2)
}

Fue_Cero <- function(x1,y1, x2, y2){
	if(x1 == x2){
		if (y1 < y2){
			x1 = x2
			y1 = y2
			x2 = x1+1
			y2 = y1
		} else {
			x1 = x2
			y1 = y2
			x2 = x1-1
			y2 = y1
		}
	} else {
		if (x1 < x2){
			x1 = x2
			y1 = y2
			x2 = x2
			y2 = y1-1
		} else {
			x1 = x2
			y1 = y2
			x2 = x2
			y2 = y2+1
		}
	}
	ret = c(x1,y1,x2,y2)
}


Enc_Frontera <- function(img=0, i=0, j=0){
x1 = s[1]
y1 = s[2]-1
x2 = s[1]
y2 = s[2]

np = 10000
x = rep(0,np)
y = rep(0,np)
k = 1
x[1] = x2
y[1] = y2

res = c(x1, y1, x2, y2)
s = Fue_Uno(x1, y1, x2, y2)

m = 1
while (1){
	print(c(m,s))
	m = m+1
	if (res[1] == s[1] & res[2] == s[2] & res[3] == s[3] & res[4] == s[4] | m == 10000){
		break
	} else {
		if (imgB[s[3], s[4]] == 0){
			s = Fue_Cero(s[1], s[2], s[3], s[4])
		}else {
			k = k+1
			print(k)
			x[k] = s[3]
			y[k] = s[4]
			s = Fue_Uno(s[1], s[2], s[3], s[4])
		}
	}
}

x = x[1:k]
y = y[1:k]

ret = list(x,y)
}

SegmentarBin <- function(i=0, j=0){
	imgt[i,j] <<- 0
	px <<- c(px, i)
	py <<- c(py, j)

	for (ii in (i-1):(i+1)){
		for (jj in (j-1):(j+1)){
			if (imgt[ii,jj] == 1 ){
				SegmentarBin(ii, jj)
		    }
		 }
	}
}

DespliegaHistIMG <- function(img=0){
	ss = dim(img)
	vec = img
	dim(vec) = ss[1]*ss[2]
	hist(vec)
}




