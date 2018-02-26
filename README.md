# Jussi

Para rodar local, faça um clone do projeto e siga os passo:

  - bundle
  - rails db:create && rails db:migrate && rails db:seed

## Listar personagens

  - listar todos os personagens (index)
    - curl https://jussi-challenge.herokuapp.com/api/v1/characters

  - listar personagem específico (show)
    - curl https://jussi-challenge.herokuapp.com/api/v1/characters/100

  - Criar um personagem (create)
    - curl -d "character[char_id]=999999&character[name]=deadpool&character[image]=deadpool.jpg" -X POST https://jussi-challenge.herokuapp.com/api/v1/characters

  - Atualizar um personagem (update)
    - curl -d "character[char_id]=999999&character[name]=deadpool&character[image]=deadpool.jpg" -X PATCH https://jussi-challenge.herokuapp.com/api/v1/characters/101

  - remover um personagem (destroy)
    - curl -X DELETE https://jussi-challenge.herokuapp.com/api/v1/characters/101


## Listar Comics

  - listar todos os comics (index)
    - curl https://jussi-challenge.herokuapp.com/api/v1/comics

  - listar comic específico (show)
    - curl https://jussi-challenge.herokuapp.com/api/v1/comics/847

  - Criar um comic (create)
    - curl -d "comic[title]=999999&comic[cover_number]=comic---1&comic[image]=deadpool.jpg" -X POST https://jussi-challenge.herokuapp.com/api/v1/comics

  - Atualizar um Comic (update)
    - curl -d "comic[cover_numver]=999999&comic[title]=deadpool&comic[image]=deadpool.jpg" -X PATCH https://jussi-challenge.herokuapp.com/api/v1/comics/848

  - Remover um Comic (destroy)
    - curl -X DELETE https://jussi-challenge.herokuapp.com/api/v1/comics/848

## ElasticSearch

  * requerimentos

    ElasticSearch

      - Usar Model.import (Comic.import e Character.import)

### Exmplos

  response = Comic.search 'agents'
  # lista o resultado dos comics com agents
  response.result


## Test
