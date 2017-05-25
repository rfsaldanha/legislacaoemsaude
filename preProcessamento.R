# Pacotes
library(lubridate)

# Carrega dados
load("dados.RData")

# Pré-processamento
dados$txtEmenta <- as.character(dados$txtEmenta)
dados$datApresentacao <- as.character(dados$datApresentacao)
dados$datApresentacao <- as.Date(dados$datApresentacao, "%d/%m/%Y %H:%M:%S")

# Salva dados
save(dados, file = "dados.RData")
