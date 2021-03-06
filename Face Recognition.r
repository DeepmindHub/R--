closeAllConnections()
rm(list=ls())
setwd("/Volumes/16 DOS/R_nbs")
library("jpeg")
library("imager")
im=readJPEG('Jennifer.jpg')
par(mfrow=c(1,1))
a=imrotate(as.cimg(im),90,interpolation=1,boundary = 0)
plot(a)
im<-a
scl=0.5
cim=im
plot(cim)
FUNC<-function(im,sigma=3){
  eps=5.e-10
  ix=imgradient(im,"x")
  iy=imgradient(im,"y")
  ix2=isoblur(ix*ix,sigma,gaussian = F)
  iy2=isoblur(iy*iy,sigma,gaussian = F)
  ixy=isoblur(ix*iy,sigma,gaussian = F)
  (ix2*iy2-ixy*ixy)/(ix2+iy2+eps)
}
cim_FUNC=FUNC(cim,sigma=6*scl)

c(60,200)[1]

get.centers <- function(im,thr="98%",sigma=6*scl,bord=400){
  dt <- FUNC(im,sigma) %>% imager::threshold(thr) %>% label
  as.data.frame(dt) %>% subset(value>10 ) %>% dplyr::group_by(value) %>% dplyr::summarise(mx=round(mean(x)),my=round(mean(y))) %>% subset(mx>100 & mx<400 & my>300 & my<700)
}
par(mfrow=c(1,1))
plot(log(cim_FUNC+.1))
par(mfrow=c(1,2))
plot(cim) 

kp=as.data.frame(cim %>% get.centers(sigma=3*scl,"98%"))[,2:3]
kp %$% points(mx,my,col="yellow",pch=18)
rect(80, 680, 425, 200, col =NULL,border ='red', lty = par("lty"),lwd = 3)
cim

### Code adapted from Kaggle competition on maps to faces.