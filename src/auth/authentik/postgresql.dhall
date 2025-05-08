let secrets = ../../secrets.dhall
in { container_name = "authentikPostgresql"
, image = "docker.io/library/postgres:16-alpine"
, restart = "unless-stopped"
, volumes = [ "/data/volumes/authentikPostgresql/data:/var/lib/postgresql/data" ]
, environment =
  [ "POSTGRES_PASSWORD=${secrets.authentik.pgPassword}"
  , "POSTGRES_USER=${secrets.authentik.pgUser}"
  , "POSTGRES_DB=${secrets.authentik.pgDb}"
  ]
, healthcheck =
  { test = [ "CMD", "pg_isready", "-d", "${secrets.authentik.pgDb}", "-U", "${secrets.authentik.pgUser}" ]
  , interval = "10s"
  , timeout = "5s"
  , retries = 3
  , start_period = "10s"
  }
}
