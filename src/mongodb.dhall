let secrets = ./secrets.dhall

in  { container_name = "mongodb"
    , image = "docker.io/bitnami/mongodb:4.4"
    , restart = "unless-stopped"
    , volumes = [ "./data/db:/bitnami/mongodb" ]
    , environment =
      { MONGODB_REPLICA_SET_MODE = "primary"
      , MONGODB_REPLICA_SET_NAME = "rs0"
      , MONGODB_PORT_NUMBER = "27017"
      , MONGODB_INITIAL_PRIMARY_HOST = "mongodb"
      , MONGODB_INITIAL_PRIMARY_PORT_NUMBER = "7017"
      , MONGODB_ADVERTISED_HOSTNAME = "mongodb"
      , MONGODB_ENABLE_JOURNAL = "true"
      , ALLOW_EMPTY_PASSWORD = "yes"
      , PUID = "1000"
      , PGID = "1000"
      }
    }
