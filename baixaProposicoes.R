# Recuperação de proposições da Camâra dos Deputados

# Pacotes
library(XML)

# Parâmetros
anos <- 2007:2017
#tipos <- c("PEC","PLP","PL","MPV","PLV","PDC","PRC","REQ","RIC","RCP","MSC","INC")
tipos <- c("PL","PLP","PEC","MPV")

# Baixa proposições
dados <- data.frame()
for(ano in anos){
  # Imprime ano atual
  print(ano)
  for(tipo in tipos){
    # Imprime tipo atual
    print(tipo)
    
    # URL de busca
    url <- paste0("http://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=",tipo,"&numero=&ano=",ano,"&datApresentacaoIni=&datApresentacaoFim=&parteNomeAutor=&idTipoAutor=&siglaPartidoAutor=&siglaUFAutor=&generoAutor=&codEstado=&codOrgaoEstado=&emTramitacao=")
    
    # Baixa proposições
    xmlfile <- xmlParse(url)
    
    # Guarda resultados
    dados <- rbind(dados, xmlToDataFrame(xmlfile))
    
    # Salva resultados
    save(dados, file = "dados.RData")
  }
}



