let secrets = ./secrets.dhall

in  { container_name = "memgpt"
    , image = "memgpt:latest"
    , restart = "unless-stopped"
    , volumes = [ "/home/nick/config/memgpt:/root/.memgpt" ]
    , ports = [ "8283:8283" ]
    , depends_on = [ "memgpt-db-test" ]
    , environment =
      { OPENAI_API_KEY = secrets.memgpt.openaiApiKey
      , PUID = "1000"
      , PGID = "1000"
      }
    }
