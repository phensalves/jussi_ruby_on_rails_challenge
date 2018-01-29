# jussi_ruby_on_rails_challenge
Construção de API de heróis da Marvel

Você deverá criar uma conta no site "https://developer.marvel.com" e gerar uma api key. Feito isso, construa uma estrutura de api utilizando Ruby on Rails que irá consumir a API que deverá ter endpoints que listarão os personagens, e outro endpoint que exibirá os detalhes desse personagem com as HQ's que os mesmos pertençam. Será interessante dispor de endpoints de um CRUD. Todos os requests deverão ter o mínimo de segurança aceitável por parte da API.  Não utilize nenhuma gem externa para a construção da API e é importante utilizar o Rails a partir da versão 3 ou 4 (5 é um diferencial).

Como fator diferencial, pedimos para espetar essa API no Elasticsearch e utilize a gem oficial do Elasticsearch:
* 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
* 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'

E também demonstre algum conhecimento com sidekiq para eventualmente gerenciar jobs assíncronos.

# Exigências:
- Rails 3, 4 ou 5
- Ruby a partir do 2.2.2
- Elasticsearch
- Sidekiq
- API REST (JSON)
- Documentação explicando como subir o projeto em desenvolvimento, e o funcionamento de seu sistema assim como execução dos testes

É permitido a utilização de qualquer banco relacional que esteja habituado em ambiente de desenvolvimento, entretanto, é necessária a utilização do Postgres em produção.

Pedimos que abra o pull request para o repositório assim que o teste for finalizado.

Lembre-se que seu código será avaliado tanto em funcionalidade quanto em estética (clean code sempre).

Uma boa cobertura de testes será avaliada. Utilize o framework/gem de sua preferência.

Boa Sorte!
