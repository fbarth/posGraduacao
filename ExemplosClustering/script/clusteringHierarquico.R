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
    height = 600, width = 800, res = 120)
plot(x,y,col="blue",pch=19,cex=2) 
text(x+0.05,y+0.05,labels=as.character(1:10))
dev.off()

dataFrame <- data.frame(x=x,y=y) 
t <- xtable(as.matrix(dist(dataFrame)))
print(t)

dataFrame <- data.frame(x=x,y=y) 
distxy <- dist(dataFrame) 
png(filename = paste(dir,"exemploClusterHie.png", sep=""), 
    height = 800, width = 800, res=120)
hClustering <- hclust(distxy) 
plot(hClustering)
dev.off()

dataFrame <- data.frame(x=x,y=y) 
distxy <- dist(dataFrame) 
png(filename = paste(dir,"exemploClusterHieSingle.png", sep=""), 
    height = 800, width = 800, res = 120)
hClustering <- hclust(distxy, "single") 
plot(hClustering)
dev.off()

dataFrame <- data.frame(x=x,y=y) 
distxy <- dist(dataFrame) 
png(filename = paste(dir,"exemploClusterHieAverage.png", sep=""), 
    height = 800, width = 800, res = 120)
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

par(mfrow=c(1,1))

png(filename = paste(dir,"pontosCars.png", sep=""), 
    height = 800, width = 900, res = 120)
#par(mfrow=c(1,2))
plot(cars$speed, cars$dist, pch=21, col= "red", cex=2)
text(cars$speed+0.05,cars$dist+0.05,labels=as.character(1:nrow(cars)))
dev.off()

png(filename = paste(dir,"pontosCarsNorm.png", sep=""), 
    height = 800, width = 900, res = 120)
plot(cars$speed_scale, cars$dist_scale, pch=19, col = "red",
     main="Plot dos pontos com valores normalizados")
text(cars$speed_scale+0.05,cars$dist_scale+0.05,labels=as.character(1:nrow(cars)))
dev.off()

m <- dist(cars[,3:4])

# Agrupamento hierárquico formado a partir de **ligação completa**.

png(filename = paste(dir,"exemploClusterHieComplete.png", sep=""), 
    height = 800, width = 900)
plot(hclust(m, method= "complete"), main="Dendograma com ligação completa")
dev.off()

# Agrupamento hierárquico formado a partir de **ligação simples**.

png(filename = paste(dir,"exemploClusterHieSingle.png", sep=""), 
    height = 800, width = 900)
plot(hclust(m, method= "single"), main="Dendograma com ligação simples")
dev.off()

# Agrupamento hierárquico formado a partir da **média do grupo**

png(filename = paste(dir,"exemploClusterHieAverage.png", sep=""), 
    height = 800, width = 900)  
plot(hclust(m, method= "average"), main="Dendograma com ligação média do grupo")
dev.off()

# Agrupamento plano com dois _clusters_

clusterModel <- kmeans(cars[,3:4], centers=2)
plot(cars[,3], cars[,4], col = clusterModel$cluster, pch=19)