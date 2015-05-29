library(klaR)
library(UsingR)
data("survey")
sapply(survey, class)

levels(survey$W.Hnd)
levels(survey$Fold)
levels(survey$Clap)

maos <- survey[,c('W.Hnd','Fold','Clap')]
plot(maos$W.Hnd, maos$Fold)
sum(is.na(maos))
maos <- maos[c(-43,-45),]

model <- kmodes(maos, 3)
model$size
model$modes
