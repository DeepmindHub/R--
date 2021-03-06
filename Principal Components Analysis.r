closeAllConnections()
rm(list=ls())
setwd("/Volumes/16 DOS/R_nbs")
sampleML<-read.csv("logitML.csv",sep=",",header=TRUE)
head(sampleML)


#missing
require(mice)
md.pattern(sampleML)
require(VIM)
imputation<-mice(sampleML,m=5,maxit=10,method='pmm',seed=500)
completeDataML<-complete(imputation,2)
completeDataML
  
#outliers
require(DMwR)
outliers.score<-lofactor(completeDataML,k=5)
outliers <- order(outliers.score, decreasing=T)[1:30]
outliers
delete=list(outliers)
t<-c(outliers)
filteredGame<-completeDataML[-t,]
dim(completeDataML)
dim(filteredGame)


#Linear Regression
dim(filteredGame)
x_train<-filteredGame[1:100,1:20]
y_train<-filteredGame[1:100,3]
test<-filteredGame[80:134,1:20]
x<-cbind(x_train,y_train)
y_train
head(x_train)

str(x)
apply(x,2,var)
head(x,2)
library(stats)
pca<-prcomp(x_train,center=TRUE,scale=FALSE)
summary(pca)
names(pca)
pca$x
pca$center
pca$rotation
pca$sdev
Var<-pca$sdev/sum(pca$sdev)

plot(pca)

# FACTORS
plot(Var,type="b",col='red',pch=20)
plot(cumsum(Var),type="b")

biplot (pca , scale =1)
# LINEAR REGRESSION COM 2 FATORES PRINCIPAIS DA PCA
data1<-pca$x[,1:3]
as.numeric(x[,1]-data[,1])
data2<-data.frame(cbind(data1,y_train))
fit<-lm(y_train~data1,data2)
summary(fit)

# LINEAR REGRESSION COM 20 VARIAVEIS ORIGINAIS
n<-names(x_train)
f <- paste(n,collapse=' + ')
f2<-paste('selected~',f)
form<-as.formula(f2)
f2
form
fit2<-lm(form,filteredGame)
summary(fit2)
names(fit2)
fit2$coefficients
fit$coefficients