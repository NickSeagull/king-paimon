let secrets = ./secrets.dhall

in  { container_name = "rocketchat"
    , image = "registry.rocket.chat/rocketchat/rocket.chat:4.8.1"
    , restart = "unless-stopped"
    , volumes = [ "./data/uploads:/app/uploads" ]
    , environment =
      { MONGO_URL = "mongodb://mongodb:27017/rocketchat?replicaSet=rs0"
      , MONGO_OPLOG_URL = "mongodb://mongodb:27017/local?replicaSet=rs0"
      , ROOT_URL = "http://${secrets.rocketchat.host}:7000"
      , PORT = "7000"
      }
    , labels =
      { `traefik.enable` = True
      , `traefik.http.routers.rocketchat.rule` =
          "Host(`${secrets.rocketchat.host}`)"
      , `traefik.http.routers.rocketchat.entrypoints` = "http"
      }
    , depends_on = [ "mongodb" ]
    }
