dir <- "~/Documents/aulas/bandtec/posGraduacao/modelagemDescritivaPreditiva/slides/Aula03-agrupamento/figuras/"

data("iris")
iris$Species <- NULL

library(xtable)
printTable <- xtable(head(iris))
print(printTable)

model <- kmeans(iris, centers = 3, nstart = 100)

png(filename = paste(dir,"clusterIris.png", sep=""), 
    height = 600, width = 800)
plot(iris$Petal.Width, iris$Petal.Length, col=model$cluster, 
     pch=19)
points(model$centers[,c('Petal.Width','Petal.Length')], 
       col =c('black','red','green'), pch=8,cex=2,lwd=3)
dev.off()

png(filename = paste(dir,"clusterIris2.png", sep=""), 
    height = 600, width = 800)
plot(iris$Sepal.Width, iris$Sepal.Length, col=model$cluster, 
     pch=19)
points(model$centers[,c('Sepal.Width','Sepal.Length')], 
       col =c('black','red','green'), pch=8,cex=2,lwd=3)
dev.off()

png(filename = paste(dir,"clusterIris3.png", sep=""), 
    height = 600, width = 800)
plot(iris, pch=21, bg=model$cluster)
dev.off()

model2 <- kmeans(iris, centers = 2, nstart = 100)
model3 <- kmeans(iris, centers = 3, nstart = 100)
model4 <- kmeans(iris, centers = 4, nstart = 100)
model5 <- kmeans(iris, centers = 5, nstart = 100)

png(filename = paste(dir,"variosModelos.png", sep=""), 
    height = 600, width = 800)
par(mfrow=c(2,2))
plot(iris$Petal.Length, iris$Sepal.Width, pch=21, 
     bg=model2$cluster, main="k = 2")
plot(iris$Petal.Length, iris$Sepal.Width, pch=21, 
     bg=model3$cluster, main="k = 3")
plot(iris$Petal.Length, iris$Sepal.Width, pch=21, 
     bg=model4$cluster, main="k = 4")
plot(iris$Petal.Length, iris$Sepal.Width, pch=21, 
     bg=model5$cluster, main="k = 5")
dev.off()

elbow <- function(dataset){
  wss <- numeric(15)
  for (i in 1:15) 
    wss[i] <- sum(kmeans(dataset,centers=i, nstart=100)$withinss)
  plot(1:15, wss, type="b", main="Elbow method", 
       xlab="Number of Clusters",
       ylab="Within groups sum of squares", 
       pch=8, col="red")
}

png(filename = paste(dir,"bestNumberK.png", sep=""), 
    height = 600, width = 800)
elbow(iris)
dev.off()

#
# Mini-exercicio
#

library(UsingR)
data(survey)

dados <- survey[,c('Wr.Hnd','NW.Hnd')]
filtrados <- dados[!is.na(dados$Wr.Hnd),]
elbow(filtrados)
model <- kmeans(filtrados, centers = 4, nstart = 100)
plot(filtrados$Wr.Hnd, filtrados$NW.Hnd, col=model$cluster, pch=19)

abalos <- read.csv("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv")
filtrados <- abalos[,c('depth','mag')]
sum(is.na(filtrados))
elbow(filtrados)
model <- kmeans(filtrados, centers = 6, nstart = 100)

png(filename = paste(dir,"clusterSemEscala.png", sep=""), 
    height = 600, width = 800)
plot(filtrados$depth, filtrados$mag, 
     col=model$cluster, 
     pch=19, main="Cluster de abalos sísmicos",
     xlab="Profundidade", ylab="Magnitude")
dev.off()

filtrados$depthKM <- filtrados$depth / 1000
model <- kmeans(filtrados[,c('mag','depthKM')], centers = 6, nstart = 100)

png(filename = paste(dir,"clusterSemEscala2.png", sep=""), 
    height = 600, width = 800)
plot(filtrados$depthKM, filtrados$mag, 
     col=model$cluster,
     pch=19, main="Cluster de abalos sísmicos",
     xlab="Profundidade em km", ylab="Magnitude")
dev.off()

featureScaling <- function(x){
  return ((x - min(x)) / (max(x) - min(x))) 
}

standardization <- function(x){
  return ((x - mean(x)) / sd(x))
}

filtrados$depthR <- standardization(filtrados$depth)
filtrados$magR <- standardization(filtrados$mag)
elbow(filtrados[,c('depthR','magR')])
model <- kmeans(filtrados[,c('depthR','magR')], centers = 6, nstart = 100)

png(filename = paste(dir,"clusterComEscala.png", sep=""), 
    height = 600, width = 800)
plot(filtrados$depthR, filtrados$magR, 
     col=model$cluster,
     pch=11, main="Cluster de abalos sísmicos",
     xlab="Profundidade (rescaled)", ylab="Magnitude (rescaled)")
points(model$centers, col = "yellow", pch=19,cex=2,lwd=3)
dev.off()

#
# Exemplos do diagnostico
#

x <- c(1,1,1,2,2,2,1,1,1,2,2,2,8,8,8,8,8,9,9,9,9,8,8,8,8,8,9,9,9,9)
y <- c(2,8,2,8,2,8,3,7,3,7,3,9,2,8,2,8,2,8,2,8,2,3,7,4,9,3,9,3,7,4)

ddummy <- data.frame(x = x, y =y)
mdummy <- kmeans(ddummy, centers = 4,
                 nstart = 100)

set.seed(1)
x <- sample(10, 100, replace = TRUE)
y <- sample(10, 100, replace = TRUE)

ddummy2 <- data.frame(x = x, y =y)
mdummy2 <- kmeans(ddummy2, centers = 3,
                 nstart = 100)

png(filename = paste(dir,"clusterDiagnostico.png", sep=""), 
    height = 600, width = 800)
par(mfrow=c(2,1))
plot(jitter(ddummy$x), jitter(ddummy$y), 
     col=mdummy$cluster, pch=19,
     xlab="x", ylab = "y",
     main="Exemplo de clusters distintos")

plot(jitter(ddummy2$x), jitter(ddummy2$y), 
     col=mdummy2$cluster, pch=19,
     xlab="x", ylab = "y",
     main="Exemplo não tão claro de clusters")
dev.off()