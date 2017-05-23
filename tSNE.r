closeAllConnections()
rm(list=ls())
setwd("/Volumes/16 DOS/R_nbs")
logitML<-read.csv("Digits_.csv",sep=",",header=TRUE,fileEncoding="latin1")
dim(logitML)
X<-logitML[,2:65]
Y<-logitML[,1]

library(tsne)
colors = rainbow(length(unique(Y)))
names(colors) = unique(Y)
ecb = function(x,y){ plot(x,t='n'); text(x,labels=Y, col=colors[Y]) }
a=tsne(X, epoch_callback = ecb, perplexity=50,max_iter = 500,epoch=500)

plot(a,col=colors,pch=20)