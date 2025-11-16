{ services =
  { n8n = ./n8n.dhall
  , valkey = ./valkey.dhall
  , `postiz-postgres` = ./postiz-postgresql.dhall
  , `postiz-redis` = ./postiz-redis.dhall
  , postiz = ./postiz.dhall
  }
}