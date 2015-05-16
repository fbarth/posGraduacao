library(xtable)

dir <- "~/Documents/aulas/bandtec/posGraduacao/modelagemDescritivaPreditiva/slides/Aula03-agrupamento/figuras/"

modelH <- hclust(dist(iris))

png(filename = paste(dir,"clusterIrisHierarquico.png", sep=""), 
    height = 600, width = 1000)
plot(modelH)
dev.off()

printTable <- xtable(iris[c(108,131),])
print(printTable)

printTable <- xtable(iris[c(108,131,42),])
print(printTable)

set.seed(1234);
x <- rnorm(10,mean=rep(1:3,each=4),sd=0.2)
y <- rnorm(10,mean=rep(c(1,2,1),each=4),sd=0.2) 

png(filename = paste(dir,"datasetClusterHie.png", sep=""), 
    height = 600, width = 800)
plot(x,y,col="blue",pch=19,cex=2) 
text(x+0.05,y+0.05,labels=as.character(1:10))
dev.off()

dataFrame <- data.frame(x=x,y=y) 
t <- xtable(as.matrix(dist(dataFrame)))
print(t)

dataFrame <- data.frame(x=x,y=y) 
distxy <- dist(dataFrame) 
png(filename = paste(dir,"exemploClusterHie.png", sep=""), 
    height = 800, width = 800)
hClustering <- hclust(distxy) 
plot(hClustering)
dev.off()

dataFrame <- data.frame(x=x,y=y) 
distxy <- dist(dataFrame) 
png(filename = paste(dir,"exemploClusterHieSingle.png", sep=""), 
    height = 800, width = 800)
hClustering <- hclust(distxy, "single") 
plot(hClustering)
dev.off()

dataFrame <- data.frame(x=x,y=y) 
distxy <- dist(dataFrame) 
png(filename = paste(dir,"exemploClusterHieAverage.png", sep=""), 
    height = 800, width = 800)
hClustering <- hclust(distxy, "average") 
plot(hClustering)
dev.off()


# Vamos utilizar um dataset sobre carros com medidas de velocidade 
# e distância de parada. Este dataset foi gerado em 1920. As 
# velocidades foram medidas em _mph_ e a distância em _ft_

data(cars)
head(cars)
summary(cars$speed)
summary(cars$dist)
cars$speed_scale <- scale(cars$speed)
cars$dist_scale <- scale(cars$dist)

m <- dist(cars[,3:4])

plot(cars[,1:2], pch=19)

# Agrupamento hierárquico formado a partir de **ligação completa**.

plot(hclust(m, method= "complete"))

# Agrupamento hierárquico formado a partir de **ligação simples**.

plot(hclust(m, method= "single"))

# Agrupamento hierárquico formado a partir da **média do grupo**
  
plot(hclust(m, method= "average"))

# Agrupamento plano com dois _clusters_

clusterModel <- kmeans(cars[,3:4], centers=2)
plot(cars[,3], cars[,4], col = clusterModel$cluster, pch=19)