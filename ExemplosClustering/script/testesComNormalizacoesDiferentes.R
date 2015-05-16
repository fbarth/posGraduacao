elbow <- function(dataset){
  wss <- numeric(15)
  for (i in 1:15) 
    wss[i] <- sum(kmeans(dataset,centers=i, nstart=100)$withinss)
  plot(1:15, wss, type="b", main="Elbow method", xlab="Number of Clusters",ylab="Within groups sum of squares", pch=8)
}

data(cars)
head(cars)
summary(cars$speed)
summary(cars$dist)
cars$speed_scale <- scale(cars$speed)
cars$dist_scale <- scale(cars$dist)

cars$speed_norm <- cars$speed / max(cars$speed)
cars$dist_norm <- cars$dist / max(cars$dist)

head(cars)

elbow(cars[,3:4])
elbow(cars[,5:6])

set.seed(1234)
clusterModel <- kmeans(cars[,3:4], centers=6, nstart=100)
par(mfrow=c(1,2))
plot(cars[,3], cars[,4], 
     col = clusterModel$cluster, pch=19)

clusterModel <- kmeans(cars[,5:6], centers=6, nstart=100)
plot(cars[,5], cars[,6], 
     col = clusterModel$cluster, pch=19)


