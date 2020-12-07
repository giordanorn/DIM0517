# DIM0517
## Backend API
### Rodando com Docker
- *No terminal* instale o [Docker](https://docs.docker.com/engine/install/)
- Instale o [Docker Compose](https://docs.docker.com/compose/install/)
- Execute `cd dim0517-api/`
- Execute `sudo docker-compose up --build`
- Em outra aba do terminal, execute `sudo docker-compose run dim0517-api.rails.web rails db:create db:migrate db:seed`

### Endpoints
- GET `/accounts/:id/balance`

Retorna o saldo de uma conta, onde `:id` é o indicador da conta.

- GET `/accounts/:id/bonus_balance`

Retorna o saldo bônus de uma conta, onde `:id` é o indicador da conta.

- POST `/accounts/:id/deposit`

Deposita um valor em R$ na conta, onde o `:id` é o indicador da conta.
```
{
  "value": `valor` como double
}
```

- POST `/accounts/:id/withdraw`

Retira um valor em R$ na conta, onde o `:id` é o indicador da conta.
```
{
  "value": `valor` como double
}
```

- POST `/accounts/:id/transfer`

Retira um valor em R$ de uma conta à outra, onde o `:id` é o indicador da conta de onde sairá a transferência.
```
{
  "receiver_id": id indicador da conta que vai receber a transferência
  "value": `valor` como double
}
```

### Usuários cadastrados via `seed`
```json
{
  "users": [
    {
      "id": 1,
      "first_name": "John",
      "last_name": "Johnson",
      "email": "john@johnson",
      "account": {
        "id": 1,
        "account_number": "00001",
        "bank_number": "00000001",
        "balance": 100.0,
        "user_id": 1
      }
    },
    {
      "id": 2,
      "first_name": "Mary",
      "last_name": "Adams",
      "email": "mary@adams",
      "account": {
        "id": 2,
        "account_number": "00002",
        "bank_number": "00000001",
        "balance": 200.0,
        "user_id": 2
      }
    },
    {
      "id": 3,
      "first_name": "Billy",
      "last_name": "Smith",
      "email": "billy@smith",
      "account": {
        "id": 3,
        "account_number": "00001",
        "bank_number": "00000002",
        "balance": 300.0,
        "user_id": 3
      }
    },
  ]
}
```
teste
alteração
