# README

# Requisitos

Este desafio foi feito usando as seguintes versões das seguintes tecnologias:

* Ruby 2.3.3
* Rails 5.1.4
* Elasticsearch 6.1.3
* PostgreSQL 10.1

É necessário que estas, portanto, estejam instaladas. Convém subir seus serviços em suas portas padrões.

# Setup

É necessário instalar o ElasticSearch e garantir que o seu serviço está rodando antes de subir a aplicação para usar o mecanismo de busca. Se a aplicação não conseguir importar os models de Character e Comic logo no boot, haverá um warning no terminal. Ainda, se este passar despercebido e o usuário tentar realizar uma busca via browser, o mesmo será redirecionado para a página ``search_error``, que o notificará que algo deu errado.

O comando ``rake db:create:all`` pode ser usado para criar todas as base de dados. O comando ``rake db:migrate`` pode ser usado para gerar as tabelas a partir das migrations. Note que com este último comando apenas as tabelas do ambiente em uso (development, production ou test) serão construídas. Para mudar entre um ambiente ou outro você pode usar a variável de ambiente RAILS_ENV=*ambiente_desejado*.

A base de dados PostgreSQL pode ser preenchida a partir do comando ``rake seeds:rb``. Se por ventura existir qualquer problema, são fornecidos os dados em binários (encoding utf-8) para preencher o banco o 'manualmente'. Estes binários podem se encontrados no diretório ``../BD Table Binaries``.
Ainda quanto ao Banco de Dados, é necessário criar o usuário "Marvel", com um password da sua escolha. Este password deve ser então guardado em uma variável de ambiente "MARVEL_PASSW". Se o usuário quiser outro nome para o usuário e a variável de ambiente, é necessário refletir a mudança no arquivo ``config/database.yml``.

Finalmente, uma última variável de ambiente que pode ser necessária (caso o Rails peça) é um hash gerado pelo comando
``rails secret``. Caso seja necessário para rodar a aplicação, gere um segredo e guarde-o na variável de ambiente
"MARVEL_SECRET_KEY_BASE". Caso o usuário queira dar outro nome à variável de ambiente, é necessário refletir a mudança
no arquivo ``config/secrets.yml``.

Não esqueça de instalar as gemas listadas no ``Gemfile`` com o comando ``bundle install``!

# Subindo o serviço

Para subir o projeto, basta invocar do terminal o comando ``$ rails s`` e abrir o browser em ``localhost:3000``. Não se esqueça de subir o elasticsearch antes caso queira usar a *feature* de buscas!

# Adicionando novos registros

Os registros são todos adicionados a partir da adição de um personagem. **Não é possível adicionar comics diretamente**. As comics que são adicionadas são as providenciadas pela API da Marvel ao buscar um personagem (no máximo 20 por personagem). Assim, as comics são adicionadas (sem repetições) no momento que um novo personagem é adicionado. Para adicionar um personagem, basta acessar a rota ``characters_new`` e providenciar o nome de um personagem, junto das suas API Keys do serviço da Marvel (developer.marvel.com). Se as informações inseridas estiverem corretas (note que você deve escrever o nome do personagem da forma que está no serviço da Marvel), você deverá ser redirecionado para uma nova página com as informações do personagem e algumas comics que têm a participação deste.

# Sobre as buscas

As buscas são feitas de tal forma que os termos usados são procurados tanto nos objetos do tipo "Character" quanto nos objetos do tipo "Comics". Quando a busca termina, são apresentados separadamente todos os registros de cada um dos tipos que tiveram um *match* com os termos usados.

# Testes

Alguns testes unitários foram implementados. Para rodá-los, basta usar o comando ``rails test``. Alguns testes estão com skip devido a problemas de interação com o elasticsearch (que não deveria estar acontecendo. Os testes estão corretos).
