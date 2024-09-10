library(imager)

mat = matrix(rep(0,256^2), ncol=256)

mat[30:40,30:40] = 1

x = as.cimg(mat)

par(mfrow=c(2,2))
plot(x)

y = grow(x,5) #%>% plot(main="Growing by 3 pixels")

plot(y)