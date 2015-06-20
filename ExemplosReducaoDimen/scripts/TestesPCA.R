data("iris")
log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]
ir.pca <- prcomp(log.ir,
center = TRUE,
scale. = TRUE)
z = t(t(ir.pca$rotation[,1:2]) %*% t(iris[,1:4]))
z = as.data.frame(z)
library(scatterplot3d)
plot(z, pch=19, col=ir.species)
scatterplot3d(z$PC1, z$PC2, z$PC3, color=as.numeric(ir.species), pch=19)

data("USArrests")
class(USArrests)
pr.out=princomp(USArrests, scale=TRUE, center=TRUE)
pr.out$rotation
biplot(pr.out, scale=0)


snsdata <- read.csv("~/workspaces/R/posGraduacao/ExemplosClustering/data/snsdata.csv")
snsdata <- snsdata[,5:40]
u <- prcomp(snsdata, scale. = TRUE)
#u <- prcomp(snsdata)
z = t(t(u$rotation[,1:2]) %*% t(snsdata))
z = as.data.frame(z)
plot(z, pch=19)


data(iris)
iris.attr <- iris[,1:4]
pca <- princomp(iris.attr, cor = TRUE, scores = TRUE)
summary(pca)
biplot(pca)
plot(pca$scores[,1:2], pch=19, col=iris$Species)
scatterplot3d(pca$scores[,1], pca$scores[,2], pca$scores[,3], 
              color=as.numeric(ir.species), pch=19)

data("USArrests")
names(USArrests)
dim(USArrests)
pca <- princomp(USArrests, cor = TRUE, scores = TRUE)
summary(pca)

plot(pca$scores[,1:2])

snsdata <- read.csv("~/workspaces/R/posGraduacao/ExemplosClustering/data/snsdata.csv")
snsdata <- snsdata[,5:40]
pca <- princomp(snsdata, cor = TRUE, scores = TRUE)
summary(pca)


library(ade4)
data("olympic")
names(olympic$tab)
dim(olympic$tab)
pca <- prcomp(olympic$tab, scale. = TRUE)
summary(pca)
biplot(pca)

train <- read.csv("~/workspaces/R/tfi/dataset/train.csv")
test <- read.csv("~/workspaces/R/tfi/dataset/test.csv")
dt <- rbind(train[,-43], test)
dt <- dt[,6:42]
pca <- prcomp(dt, scale. = TRUE)
summary(pca)

library(kernlab)
data("spam")
spam <- spam[,-58]
pca <- prcomp(spam, scale. = TRUE)
summary(pca)
plot(spam[,34], spam[,32])
smallSpan <- spam[,c(34,32)]
pcaSmall <- princomp(smallSpan, cor=TRUE, scores = TRUE)
plot(pcaSmall$scores)
summary(pcaSmall)

library(vegan)
data(varespec)



data(cars)
plot(cars, pch=19)
pca <- princomp(cars, cor = TRUE, scores = TRUE)
summary(pca)
plot(pca$scores[,1])


casas <- data.frame(tamanho=c(60,80,90,100,140,150,180),
                    preco=c(550,780,910,1100,1350,1500,1600))
pca <- princomp(casas, cor = TRUE, scores = TRUE)
summary(pca)
plot(casas,pch=19)
plot(pca$scores[,1],pch=19)
pca$scores[,1]
