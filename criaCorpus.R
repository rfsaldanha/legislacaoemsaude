# Pacotes
library(tm)
library(dplyr)
library(stringr)
library(wordcloud)

# Carrega dados
load("dados.RData")

# Filtro de busca
sub <- dados
buscaLista <- c("saúde","doença","sus")
sub <- filter(sub, str_detect(txtEmenta, paste(buscaLista, collapse="|")))

# Corpus
corpus <- Corpus(VectorSource(sub$txtEmenta))
#inspect(corpus[1:6])

# Limpeza
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("portuguese"))

# Stem
ruido <- c("saúde","lei","leis","altera","nº","dispõe","sobre","providência","art","dá","1º","dispor","outra","institui","decretolei","código","nacional","outras","providências","cria")
corpus <- tm_map(corpus, removeWords, ruido)
#corpus <- tm_map(corpus, stemDocument)

# Wordcloud
pal2 <- brewer.pal(8,"Dark2")
wordcloud(corpus, 
          max.words = 200, 
          scale=c(2,.05),
          min.freq=1,
          random.order=FALSE,
          colors = pal2)

# Tabela
corpusDtm <- TermDocumentMatrix(corpus)
tab <- sort(rowSums(as.matrix(corpusDtm)), decreasing=TRUE)
head(tab, 50)

tab["neoplasia"]
tab["dengue"]
tab["zika"]
tab["constituição"]


