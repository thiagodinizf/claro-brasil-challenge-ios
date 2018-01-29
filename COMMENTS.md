Arquitetura

- Por ser um projeto pequeno, a estrutura do projeto é organizada por package-by-layer, o pattern escolhido foi o MVVM, com o objetivo de diminuir ou eliminar a responsabilidade dos controllers com manipulação de dados e algumas regras de negócio, o viewmodel assume essa tarefa. 
- As requisições são assíncronas e utilizam protocolos para o tratamento das respostas de sucesso ou falha. Quando uma classe entra em conformidade com o protocolo de respostas, é passado por parâmetro o tipo da requisição, permitindo que a controller tenha a possibidade de tratar as respostas de diferentes maneiras.
- O projeto tenta utilizar o máximo possível a abordagem type-safety, reduzindo a utilização de strings espalhadas pelo código para chaves/identificadores, procurando utilizar mais enums e constantes.
- As funções comuns ou que são utilizadas com mais frequencia, foram movidas para classes utilitárias ou de extensão para um código mais limpo e com recursos centralizados.

Bibliotecas de terceiros

 - Alamofire - Framework para requisições assíncronas.
 - AlamofireObjectMapper - Extensão que permite a integração entre Alamofire e ObjectMapper
 - RealmSwift - Persistência local.
 - SwiftGen - Gerador de enums, facilitando o uso de assets, internacionalização, cores e storyboards. OBS: foram adicionados scripts em ruby no Build Phases do projeto para automatizar a geração dos arquivos .swift com as enums. Em desenvolvimento, é necessário a instalação de uma dependência utilizando o comando "brew install swiftgen" no Terminal (requer instalação do gerenciador de pacotes Homebrew)
 - Reusable - Extensão para reuso de células, nibs e storyboards.
 - ObjectMapper - Criação de objetos a partir de um JSON ou dicionário, permite mapeamento de-para.
 - SwiftMessages - Alertas com boas opcões de personalização.
 - Kingfisher - Download assíncrono de imagens direto para UIImageView e UIButton. Suporta cache e pós-processamento de imagem.
 - SwiftyJSON - Apesar do Swift4 nativamente manipular jsons, devido à familiaridade, foi escolhida essa biblitoteca
 - DeviceKit - Enum para ajudar na identificação do tipo de device com resolução e polegadas.
 - StatefulViewController - Biblioteca para ajudar nas transições de estado de uma tela, alterando entre loading, no-content e error.
 - SpringIndicator - Animação para indicar atividade.
 - youtube-ios-player-helper - Helper utilizado para tentar incorporar o player embed do youtube em uma webview.

Melhorias (com mais tempo disponível)

- Alguns tratamentos foram feitos para melhorar a experiência no iPad, recalculando o número de itens da CollectionView para ganhar mais espaço e melhorando a qualidade das imagens requisitadas com a API. Mas para aproveitar melhor o espaço da tela, usaria UISplitViewController para busca e detalhes do filme.
- Visualizar as imagens do filme em tela cheia.
- Utilização da biblioteca Moya para mapear os paths da API.
- Utilização de mais recursos da API, como a paginação dos resultados buscados no servidor (atualmente limitada em 20 registros) e mais informações sobre o filme (elenco e avaliações da crítica).
- Melhorar a experiência em landscape. Alguns cálculos foram feitos para evitar a distorção das imagens, mantendo o aspect ratio com qualidade aceitável. Novamente para aproveitar melhor o espaço, o reposicionamento de alguns elementos na tela de detalhe do filme seria mais indicado.
- Mais testes de usabilidade, melhor solução para reloadData com animação e outros pequenos ajustes de interface.
- Integração contínua com Travis. Devido ao curto prazo, não foi possível atender ao requisito desejável.


Requisitos obrigatórios

- Foi identificado que a API (por ser colaborativa) não possui storage/streaming para os vídeos, são utilizados links do Youtube cadastrados pela comunidade. O link do Youtube não funcionam no AVPlayer por ser uma iframe (embed). Após várias tentativas frustradas de adaptar o iframe dentro de uma WebView, como solução emergencial, utilizei uma biblioteca disponibilizada no github do Youtube para abstrair essa integração. Considero que esse requisito foi parcialmente atendido, também não foi possível atender o requisito desejável relacionado ao AVPlayer.
