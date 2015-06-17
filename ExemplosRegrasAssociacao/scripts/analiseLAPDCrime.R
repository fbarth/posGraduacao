#
# O objetivo deste script eh fazer uma analise
# dos crimes em Los Angeles que ocorreram nos meses
# de novembro e dezembro de 2014.
#

# Lendo os dados e convertendo os tipos
ocorrencias <- read.csv("dataset/LAPD_Crime_and_Collision_Raw_Data_-_2014.csv")
ocorrencias <- ocorrencias[,c(3,4,6,9)]
ocorrencias$periodo <- ifelse(ocorrencias$TIME.OCC < 600, "Madrugada",
                               ifelse(ocorrencias$TIME.OCC < 1200, "Manha",
                                      ifelse(ocorrencias$TIME.OCC < 1800, "Tarde", "Noite")))
ocorrencias$TIME.OCC <- NULL
names(ocorrencias) <- c('data','area','descricao','periodo')
ocorrencias$data <- as.Date(ocorrencias$data, format = '%m/%d/%Y')

library(dplyr)
# Calculando e imprimindo a quantidade de crimes por dia
byData <- group_by(ocorrencias, data)
sumData <- summarize(byData, count=n())
plot(sumData$count ~ sumData$data, type='l', 
     col='red', main="Quantidade de crimes por dia na cidade de Los Angeles", 
     xlab="Período", ylab="Quantidade de crimes")

# Calculando e imprimindo a quantidade crimes por regiao
par(las=2)
par(cex.axis=0.6)
barplot(table(ocorrencias$area), main="Quantidade de crimes por região",
     xlab="Região", ylab="Quantidade", col="cyan")

# Calculando e imprimindo a quantidade de ocorrencias por crime
par(cex.axis=0.3)
barplot(sort(table(ocorrencias$descricao), decreasing = TRUE), 
        main="Quantidade de ocorrências por crime",
        xlab="Crimes", ylab="Quantidade", col="cyan")

# removendo ocorrencias do tipo TRAFFIC DR #
# trata-se de um crime que tem uma quantidade de ocorrencias muito fora do padrao
ocorrencias <- subset(ocorrencias, ocorrencias$descricao != 'TRAFFIC DR #')

# novo plot de quantidade de ocorrencias por crime
barplot(sort(table(ocorrencias$descricao), decreasing = TRUE), 
        main="Quantidade de ocorrências por crime",
        xlab="Crimes", ylab="Quantidade", col="cyan")

# Gerando a base de transacoes de tipo de crime agrupadas por data e regiao
library(arules)
temp <- data.frame(id=paste(ocorrencias$periodo,ocorrencias$data,ocorrencias$area,sep = "-",collapse = NULL),
                   crime=ocorrencias$descricao)
write.csv(temp, file = "dataset/temp_trans.csv")

tr <- read.transactions("dataset/temp_trans.csv", format="single", sep=',',
                        cols = c('id','crime'),rm.duplicates = TRUE)
tr

#analise das regras de associacao
par(cex.axis=0.5)
image(sample(tr,300))
