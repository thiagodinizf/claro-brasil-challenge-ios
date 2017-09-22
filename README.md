Claro Brasil Challenge - iOS
===================

O objetivo deste desafio é avaliar a competência técnica dos candidatos a desenvolvedor iOS na **Claro Brasil**. Será solicitado o desenvolvimento de um app nativo iOS em Swift que possibilitará o usuário buscar filmes, favoritá-los e assistir aos trailers sem sair do app.

----------

Especificações Técnicas
-------------

- **Plataforma suportada:** iOS 10.0 +
- **Linguagem:** Swift 4.0
- **Dispositivos:** iPhone e iPad
- **Idioma de escrita do código:** Inglês
- **Idiomas do app:** Inglês e Português (deve adaptar-se de acordo com o idioma do device do usuário)

----------

Requisitos do Produto
-------------

#### Funcionalidades

 - Listagem de filmes favoritados do usuário (persistidos)
 - Tela de busca de filmes on-line
 - Detalhe do filme contendo foto(s) título e sinopse
 - Player para a exibição do trailer do filme (quando disponível)

#### Requisitos obrigatórios

 - Utilização da API https://www.themoviedb.org/documentation/api
 - Apresentar indicadores de carregamento durante a execução de todas as requisições ou operações assíncronas que demandem um tempo perceptível ao usuário
 - Indicar para o usuário quando não há resultados na busca / filmes favoritados
 - Indicar para o usuário quando ocorrer algum erro nas requisições
 - Relizar requisições assíncronamente
 - Persistência local dos filmes favoritados
 - Utilização de um gerenciador de dependências (ex: Cocoapods, Carthage)
 - Utilizar auto-layout quando aplicável
 - Layout com foco nos iPhones (todos os tamanhos incluindo o iPhone X)
 - Orientação portrait
 - Orientação landscape durante a exibição do trailer
 - Pelo menos um teste automatizado de interface

#### Requisitos desejáveis

 - Uso de animações para apresentação do conteúdo
 - Customização da UI do AVPlayer para exibição dos trailers
 - Utilização de recursos do iOS 11 (caso o usuário esteja no iOS 11)
 - Busca automática (buscar na API conforme o usuário digita)
 - Layout diferenciado para iPad caso aplicável
 - Suporte a landscape nos iPhones e / ou iPads
 - Testes unitários
 - Integração contínua (Travis)

----------

Critérios de avaliação
-------------

 - Qualidade de escrita do código
 - Organização do projeto
 - Consistência das constraints do layout
 - Arquitetura utilizada
 - UI e UX
 - Adaptação do layout aos diferentes tamanhos de tela (atenção ao iPhone X)
 - Utilização do Git (quantidade e descrição dos commits, utilização ou não de branches)

----------

Instruções de entrega
-------------

 1. Crie um fork do repositório no seu GitHub
 2. Faça o push do código desenvolvido no seu Github
 3. Inclua um arquivo chamado COMMENTS.md explicando
	 - Explicação rápida da decisão arquitetura utilizada e o porquê
	 - Lista de bibliotecas de teceiros utilizadas
	 - O que você melhoraria se tivesse mais tempo
	 - Quais requisitos obrigatórios não foram entregues e o porquê 
 4. Informe ao recrutador quando concluir o desafio junto com o link do repositório
