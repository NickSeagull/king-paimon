let secrets = ./secrets.dhall

in  { container_name = "memgpt-db-test"
    , image = "pg-test:latest"
    , restart = "unless-stopped"
    , volumes = [ "./data/memgpt_db_test:/var/lib/postgresql/data" ]
    , ports = [ "8888:5432" ]
    , environment =
      { POSTGRES_PASSWORD = secrets.memgpt-db.password
      , PUID = "1000"
      , PGID = "1000"
      }
    }
