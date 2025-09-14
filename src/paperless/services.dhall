{ services =
  { `paperless-db` = ./postgresql.dhall
  , `paperless-broker` = ./redis.dhall
  , `paperless-gotenberg` = ./gotenberg.dhall
  , `paperless-tika` = ./tika.dhall
  , `paperless-webserver` = ./webserver.dhall
  , `paperless-ai` = ./ai.dhall
  }
}