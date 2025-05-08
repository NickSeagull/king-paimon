{ services =
  { authentikServer = ./server.dhall
  , authentikRedis = ./redis.dhall
  , authentikPostgresql = ./postgresql.dhall
  , authentikWorker = ./worker.dhall
  }
, volumes = { database.driver = "local", redis.driver = "local" }
}
