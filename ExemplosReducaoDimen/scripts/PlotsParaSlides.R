dir <- "~/Documents/aulas/bandtec/posGraduacao/modelagemDescritivaPreditiva/slides/Aula04-reducaoDimensao/figuras/"

casas <- data.frame(tamanho=c(60,80,90,100,140,150,180),
                    preco=c(550,780,910,1100,1350,1500,1600))

png(filename = paste(dir,"duasDimensoes.png", sep=""), 
    height = 600, width = 800, pointsize = 24)
plot(casas, main="Exemplo de dataset com 2 dimensões",
     xlab="Tamanho do imóvel",
     ylab="Preço do imóvel (em milhares de reais)",
     pch=19, lwd=3)
dev.off()

library(xtable)
printTable <- xtable(head(casas))
print(printTable)


png(filename = paste(dir,"duasDimensoesComLinha.png", sep=""), 
    height = 600, width = 800, pointsize = 24)
plot(casas, main="Exemplo de dataset com 2 dimensões",
     xlab="Tamanho do imóvel",
     ylab="Preço do imóvel (em milhares de reais)",
     pch=19, lwd=3)
abline(lm(casas$preco ~ casas$tamanho), col="red", lwd=3)
dev.off()

pca <- prcomp(casas, scale. = TRUE)
summary(pca)
z <- pca$x[,1]

png(filename = paste(dir,"pontosZ.png", sep=""), 
    height = 600, width = 800, pointsize = 24)
plot(pca$x[,1],pch=19,
     main="Pontos do vetor z",
     ylab="z", xaxt='n', xlab="", lwd=3)
dev.off()

z

print(xtable(summary(pca)))

#
# Segundo exemplo, ainda em R2
#

data(cars)

png(filename = paste(dir,"duasDimCarros.png", sep=""), 
    height = 600, width = 800, pointsize = 24)
plot(cars, pch=19,
     main="Dados sobre velocidade e distância de frenagem de carros",
     xlab="Velocidade (em mph)",
     ylab="Distância (em fit)", lwd=3)
dev.off()

pca <- prcomp(cars, scale. = TRUE)
summary(pca)

png(filename = paste(dir,"pontosZCarros.png", sep=""), 
    height = 600, width = 800, pointsize = 24)
plot(pca$x[,1],pch=19,
     main="Pontos do vetor z para o exemplo dos carros",
     ylab="z", xaxt='n', xlab="", lwd=3)
dev.off()

print(xtable(summary(pca)))
z <- pca$x[,1]
z

#
# Exemplo com 4 dimensoes
#

data("USArrests")
print(xtable(head(USArrests)))

library(scatterplot3d)

png(filename = paste(dir,"plot3d.png", sep=""), 
    height = 600, width = 800, pointsize = 18)
s3d <- scatterplot3d(USArrests$Assault, USArrests$Murder, 
                     USArrests$Rape, pch=19,
                     color="blue",
                     xlab="Assaltantes presos",
                     ylab="Assassinos presos",
                     zlab="Estupradores presos",
                     main="Dados sobre 50 estados americanos em 1973")
s3d.coords <- s3d$xyz.convert(USArrests$Assault, 
                              USArrests$Murder, USArrests$Rape)
text(s3d.coords$x, s3d.coords$y, 
     labels=row.names(USArrests), cex=.5, pos=4)
dev.off()

png(filename = paste(dir,"plotSeguranca.png", sep=""), 
    height = 600, width = 800, pointsize = 18)
plot(USArrests$UrbanPop, USArrests$Assault,
     main="Outra visão sobre o dataset",
     xlab="Percentual da população urbana",
     ylab="Assaltantes presos", pch=19,
     col="blue")
text(USArrests$UrbanPop, USArrests$Assault, 
     row.names(USArrests), cex=.5, pos=4)
dev.off()

#
# Levando-se em consideracao apenas Murder, Assault e Rape
#
pca <- prcomp(USArrests[,c(1,2,4)], scale. = TRUE)
print(xtable(summary(pca)))

print(xtable(head(pca$x[,1:2])))

png(filename = paste(dir,"pca1.png", sep=""), 
    height = 600, width = 800, pointsize = 12)
plot(pca$x[,1], pca$x[,2], 
     col="blue", 
     pch=19, xlab="PCA1", ylab="PCA2",
     main="Dados sobre 50 estados americanos em 1973")

text(pca$x[,1], pca$x[,2], 
     row.names(pca$x), cex=1, pos=4)
dev.off()

png(filename = paste(dir,"biplot1.png", sep=""), 
    height = 600, width = 800, pointsize = 12)
biplot(pca, xlab="Componente principal 1", 
       ylab="Componente principal 2",  
       main="Dados sobre os estados americanos em 1973")
dev.off()


#
# Para todo o dataset
#
pca <- prcomp(USArrests, scale. = TRUE)
print(xtable(summary(pca)))

print(xtable(pca$rotation))

png(filename = paste(dir,"pca2.png", sep=""), 
    height = 600, width = 800, pointsize = 12)
plot(pca$x[,1], pca$x[,2], 
     col="blue", 
     pch=19, xlab="Índice de violência", ylab="Índice de Urbanização",
     main="Dados sobre 50 estados americanos em 1973")

text(pca$x[,1], pca$x[,2], 
     row.names(pca$x), cex=1, pos=4)
dev.off()

png(filename = paste(dir,"biplot2.png", sep=""), 
    height = 600, width = 800, pointsize = 12)
biplot(pca, xlab="Componente principal 1", 
       ylab="Componente principal 2",  
       main="Dados sobre os estados americanos em 1973")
dev.off()