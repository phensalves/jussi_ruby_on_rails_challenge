=== VERSOES UTILIZADAS
- Rails 5.1.6
- Ruby 2.3.1p112
- Elasticsearch 6.2.3
- API REST (JSON)
- SIDEKIQ 5.1.3

=== Como subir o Projeto:
- Execute ```bundle exec rails s```
- Execute ```elasticsearch```
- Execute ```bundle exec sidekiq```

- Execute ```bundle exec rake db:seed``` => Ele vai criar o Token que vamos utilizar para acessar as rotas
- Faça uma requisição na rota '/api/v1/characters', utilizando o Token de acesso -> key: Api-Key  value: X/w5jIHXq+krWtVlAhkepQ==

Ao acessar essa rota, a aplicação starta o sidekiq para a criação dos personagens e das HQ`s

- Acesse novamente essa rota após alguns segundos e os Personagens estaram criados, assim como as HQ`s

=== Endpoints Elastichsearch

/api/v1/characters/characters_elastic -> contem somente o nome e id

/api/v1/characters/characters_elastic_full -> contem somente o nome, id e imagem

obs1: enviar o parametro "q" para realização da busca no elasticsearch.

obs2: Como só vamos precisar do nome, id e imagem, só importei para o elasticsearch as informações necessarias.