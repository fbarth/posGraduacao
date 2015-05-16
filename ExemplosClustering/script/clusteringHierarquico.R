modelH <- hclust(dist(iris))

png(filename = paste(dir,"clusterIrisHierarquico.png", sep=""), 
    height = 600, width = 1000)
plot(modelH)
dev.off()

printTable <- xtable(iris[c(108,131),])
print(printTable)

printTable <- xtable(iris[c(108,131,42),])
print(printTable)
