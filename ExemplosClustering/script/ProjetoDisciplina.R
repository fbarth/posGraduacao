snsdata <- read.csv("data/snsdata.csv")

# removendo informacoes pessoais (gradyear, gender, age, friends)
# fazendo a analise de clustering considerando apenas as categorias dos
# posts das pessoas

snsdata <- snsdata[,5:40]

# o dataset nao possui nehum valor missing:

sum(is.na(snsdata))

dados <- as.data.frame(lapply(snsdata , scale))

elbow <- function(dataset, title){
  wss <- numeric(15)
  for (i in 1:15) 
    wss[i] <- sum(kmeans(dataset,centers=i, nstart=100)$withinss)
  plot(1:15, wss, type="b", main=paste(title), xlab="Number of Clusters",ylab="Within groups sum of squares", pch=8)
}

set.seed(1234)
elbow(dados, "Elbow com dados pré-processados com scale")

simpleNorm <- function(x){
  return (x / max(x))
}

dados <- as.data.frame(lapply(snsdata , simpleNorm))

set.seed(1234)
elbow(dados, "Elbow com dados pré-processados com normalização simples")

set.seed(1234)
elbow(snsdata, "Elbow com dados sem normalização ou scale")

modelH <- hclust(dist(snsdata))

png(filename = "results/clusterHier.png", 
    height = 600, width = 1000)
plot(modelH)
dev.off()

# gerando o modelo

dados <- as.data.frame(lapply(snsdata , scale))
model <- kmeans(dados, centers = 7, nstart = 100)

# inspecionando o modelo e os centróides do modelo

model$withinss
model$size
x <- as.data.frame(model$centers)
sort(x[1,],decreasing = TRUE)[1:3]
sort(x[2,],decreasing = TRUE)[1:3]
sort(x[3,],decreasing = TRUE)[1:3]
sort(x[4,],decreasing = TRUE)[1:3]
sort(x[5,],decreasing = TRUE)[1:3]
sort(x[6,],decreasing = TRUE)[1:3]
sort(x[7,],decreasing = TRUE)[1:3]



