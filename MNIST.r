closeAllConnections()
rm(list=ls())

setwd("/Volumes/16 DOS/R_nbs")
train<-read.csv("mnist_train2.csv",sep=",",header=FALSE)
test<-read.csv("mnist_test2.csv",sep=",",header=FALSE)
 
t<-1
p<-c()
r<-c()
while(t<51){
    zz<-for(i in 1:200){p[[i]]<-sum(abs(t(test)[2:785,t]-t(train)[2:785,i]))}
    r[[t]]<-p
    t<-t+1}

q<-lapply(r, function(x) min(x))

o<-lapply(r,function(x) which(x==min(x)))
op<-as.numeric(o)
op
l<-c()
for(j in 1:2000){l[[j]]<-t(test)[1,][[j]]-t(train)[1,op[[j]]]}
l

part<-op[[19]]
a<-t(train)
b<-a[2:785,part]
c<-matrix(b,nrow=28,ncol=28)
rotate <- function(c) t(apply(c, 2, rev))
d<-rotate(rotate(rotate(c)))
e<-apply(d, -2, rev)
f<-rotate(rotate(as.matrix(rev(as.data.frame(e)))))

a2<-t(test)
b2<-a2[2:785,19]
c2<-matrix(b2,nrow=28,ncol=28)
rotate <- function(c2) t(apply(c2, 2, rev))
d2<-rotate(rotate(rotate(c2)))
e2<-apply(d2, -2, rev)
f2<-rotate(rotate(as.matrix(rev(as.data.frame(e2)))))

part3<-op[[13]]
a3<-t(train)
b3<-a3[2:785,part3]
c3<-matrix(b3,nrow=28,ncol=28)
rotate3 <- function(c3) t(apply(c3, 2, rev))
d3<-rotate3(rotate3(rotate3(c3)))
e3<-apply(d3, -2, rev)
f3<-rotate3(rotate3(as.matrix(rev(as.data.frame(e3)))))

a4<-t(test)
b4<-a4[2:785,13]
c4<-matrix(b4,nrow=28,ncol=28)
rotate <- function(c4) t(apply(c4, 2, rev))
d4<-rotate(rotate(rotate(c4)))
e4<-apply(d4, -2, rev)
f4<-rotate(rotate(as.matrix(rev(as.data.frame(e4)))))

library(lattice)
attach(mtcars)
par(mfrow=c(2,2)) 
image(f,col=c("yellow","blue"),main="MNIST Task Train")+grid(lty=1,col="black",nx=14,ny=14)
image(f2,col=c("yellow","blue"),main="MNIST Task Test")+grid(lty=1,col="black",nx=14,ny=14)
image(f3,col=c("yellow","blue"),main="MNIST Task Train")+grid(lty=1,col="black",nx=14,ny=14)
image(f4,col=c("yellow","blue"),main="MNIST Task Test")+grid(lty=1,col="black",nx=14,ny=14)
acc<-length(which(l==0))/length(l)
acc
print(c("ACCURACY=",acc))
table(t(test)[1,1:50],t(train)[1,op])
