# Juno SDK Ruby

Configure

```
Juno.configure do |c|
  c.client_id = '36MlAdCaIQnKEV9l'
  c.client_secret = 'sdLcs>QmaKV3F~w1lM*;sD9CEjo$+?0K'
  c.private_token = '77782EX206XF25F96XDF6XC689B67X287X2339C777C2265F'
end
```

How to use

```
Juno::Transfer.create(
  type: "DEFAULT_BANK_ACCOUNT",
  amount: "200"
)
```

