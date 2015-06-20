library(ade4)
data("olympic")
names(olympic$tab)
dim(olympic$tab)
pca <- prcomp(olympic$tab, scale. = TRUE)
summary(pca)
biplot(pca)

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

snsdata <- read.csv("~/workspaces/R/posGraduacao/ExemplosClustering/data/snsdata.csv")
snsdata <- snsdata[,5:40]
pca <- prcomp(snsdata, scale. = TRUE)
