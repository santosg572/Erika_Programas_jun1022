library(imager)

im <- load.example("birds")
plot(im)

im.g <- grayscale(im)
plot(im.g)

# https://dahtah.github.io/imager/morphology.html

layout(t(1:3))
threshold(im.g,"20%") %>% plot
threshold(im.g,"15%") %>% plot
threshold(im.g,"10%") %>% plot

df <- as.data.frame(im.g)
head(df,5) 

m <- lm(value ~ x + y,data=df) #linear trend
summary(m)

layout(t(1:2))
im.f <- im.g-fitted(m)
plot(im.g,main="Before")
plot(im.f,main="After trend removal")


#Note the use of map_il, which is a kind of "lapply" that returns an image list
#map_il wraps map, from the purrr package
paste0(c(20,15,10),"%") %>% map_il(~ threshold(im.f,.)) %>% plot(layout="row")

im.t <- threshold(im.f,"16%")
px <- as.pixset(1-im.t) #Convert to pixset
plot(px)


grow(px,3) %>% plot(main="Growing by 3 pixels")


