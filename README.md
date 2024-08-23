# tractian_mobile_challenge


## Demonstração

![](demonstration.mp4)

## Possíveis Melhorias

1. Levar a reestruturação dos dados para a camada de serviço
   1. A forma como trabalhei os Services condicionaram o resto dos tratamento dos dados, se tivesse investido menos tempo nisso, faria algo mais simples.
   2. Trabalharia as modificações no json completo, já criando as relações e até "tabelas auxiliares" de relação entre os nós.
2. Trabalhar uma só classe para `Location` e `Asset`
   1. Apesar de serem do tipo `Item`, a separação de subtipos poderia ter sido mais fácil levando em consideração apenas `ItemType`, acredito que foi OO demais.
3. Reduzir as recursividades (o que está ligado com o item 1)
   1. Como segui trabalhando com uma lista plana (pensando nos filtros), creio que perdi muita performance repetindo buscas para diversos fins.
   
Esses foram os pontos de melhoria prioritária que consegui elencar, creio que outras otimizações (UI, memória, etc.) serão consequências das correções anteriores.
