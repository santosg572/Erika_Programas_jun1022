rm(list=ls())

u = c(0,1)

x = sample(u, 42, replace=T, prob=c(.7, .3))

dim(x) = c(6,7)

print(x)

save(x, file='x_dat')



