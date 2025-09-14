let secrets = ../secrets.dhall

in  { container_name = "paperless-db"
    , image = "docker.io/library/postgres:17"
    , restart = "unless-stopped"
    , volumes = [ "/data/volumes/paperless/postgresql:/var/lib/postgresql/data" ]
    , environment =
      [ "POSTGRES_DB=${secrets.paperless.pgDb}"
      , "POSTGRES_USER=${secrets.paperless.pgUser}"
      , "POSTGRES_PASSWORD=${secrets.paperless.pgPassword}"
      ]
    , networks = [ "proxy" ]
    , healthcheck =
      { test = [ "CMD", "pg_isready", "-d", "${secrets.paperless.pgDb}", "-U", "${secrets.paperless.pgUser}" ]
      , interval = "10s"
      , timeout = "5s"
      , retries = 3
      , start_period = "10s"
      }
    }