library(arules)
library(arulesViz)

# criando o conjunto de transacoes
tr <- read.transactions("dataset/temp_trans.csv",
                        format="single", sep=',',
                        cols = c('id','crime'),
                        rm.duplicates = TRUE)

# listando os itens frequentes de forma ordenada
barplot(sort(itemFrequency(tr)))

# descobrindo regras com um suporte baixo, mas com uma confianca
# muito alta. justificativa: os crimes com maior frequencia sao
# crimes muito comuns (obvio). se mantermos um suporte alto, talvez nao
# consigamos descobrir algo diferente. talvez ficamos apenas no
# senso comum.
rules <- apriori(tr, parameter= list(supp=0.001, conf=0.9))

plot(rules)

plot(rules, method = "matrix", measure = c("lift", "confidence"),
     control = list(reorder = TRUE))

#filtrando as regras

selectedRules <- rules[quality(rules)$lift > 4]
inspect(head(sort(selectedRules, by="lift"), 5))

plot(selectedRules, method="graph", control=list(type="items"))

plot(head(sort(selectedRules, by="lift"), 2), 
     method="graph", control=list(type="items"))
