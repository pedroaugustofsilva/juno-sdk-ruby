# Juno SDK Ruby

Juno SDK is a minimalist gem to interact with Juno API.

## Configure

```ruby
Juno.configure do |c|
  c.client_id = CLIENT_ID
  c.client_secret = CLIENT_SECRET
  c.private_token = PRIVATE_TOKEN
end
```

## How to use

### Charges

#### Create
```ruby
Juno::Charges.create({charge: {...}, billing: {...})
```

To see which parameters to pass on creation see [Criar uma ou mais cobraças](https://dev.juno.com.br/api/v2#operation/createCharge) in the Juno API
documentation.

#### List all charges
```ruby
Juno::Charges.list
```

#### Show charge
```ruby
Juno::Charges.show('charge_id')
```

#### Cancel charge
```ruby
Juno::Charges.cancel('charge_id')
```

#### Update split
```ruby
Juno::Charges.update_split({ split: [] })
```

Options: [Atualizar split](https://dev.juno.com.br/api/v2#operation/updateById)