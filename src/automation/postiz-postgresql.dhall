let secrets = ../secrets.dhall

in  { container_name = "postiz-postgres"
    , image = "docker.io/library/postgres:17-alpine"
    , restart = "unless-stopped"
    , volumes = [ "/data/volumes/postiz/postgresql:/var/lib/postgresql/data" ]
    , environment =
      [ "POSTGRES_DB=${secrets.postiz.pgDb}"
      , "POSTGRES_USER=${secrets.postiz.pgUser}"
      , "POSTGRES_PASSWORD=${secrets.postiz.pgPassword}"
      ]
    , networks = [ "proxy" ]
    , healthcheck =
      { test = [ "CMD-SHELL", "pg_isready -d ${secrets.postiz.pgDb} -U ${secrets.postiz.pgUser}" ]
      , interval = "10s"
      , timeout = "5s"
      , retries = 5
      , start_period = "10s"
      }
    }
