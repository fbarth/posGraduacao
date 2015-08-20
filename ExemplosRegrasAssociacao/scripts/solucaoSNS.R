library(arules)
library(arulesViz)
library(xtable)

# Aquisicao e pre-processamento

snsdata <- read.csv("dataset/snsdata.csv")
snsdata <- snsdata[,5:40]

map_to_boolean <- function(attr){
  attr <- ifelse(attr >= 1, TRUE, FALSE)
}

snsdata <- as.data.frame(sapply(snsdata, map_to_boolean))
tr <- as(snsdata, "transactions")

# Analise descritiva
itemFrequencyPlot(tr, support=0.1, main="Itens mais frequentes")

# Modelagem
rules <- apriori(tr, parameter= list(supp=0.01, conf=0.6))

plot(rules)
plot(rules, method = "matrix", measure = c("lift", "confidence"),
     control = list(reorder = TRUE))
# das 36 classes de conteudo, apenas 10 estao do lado direito da regra.
# a grande maioria das regras tem apenas duas classes como consequencia. 
# Que são hair, sex e music.  

# Detalhando as regras com a maior confianca 
# Analisando apenas as 5 regras com maior confianca
rules1 <- head(sort(rules, by="confidence"), 5)
#rules1 <- rules[quality(rules)$confidence > 0.9]
plot(rules1, method="graph", control=list(type="items"), main="Cinco regras com maior confiança")

# imprimindo as regras em formato LaTeX
ruledf = data.frame(
  lhs = labels(lhs(rules1))$elements,
  rhs = labels(rhs(rules1))$elements, 
  rules1@quality)
xtable(ruledf)

# Detalhando as regras com o maior lift 
# analisando apenas as 5 regras com maior lift
rules2 <- head(sort(rules, by="lift"), 5)
#rules2 <- rules[quality(rules)$lift > 10]
plot(rules2, method="graph", control=list(type="items"), main="Cinco regras com maior lift")

# imprimindo as regras em formato LaTeX
ruledf = data.frame(
  lhs = labels(lhs(rules2))$elements,
  rhs = labels(rhs(rules2))$elements, 
  rules2@quality)
xtable(ruledf)

