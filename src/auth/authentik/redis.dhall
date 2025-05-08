{ container_name = "authentikRedis"
, image = "docker.io/valkey/valkey:8-alpine"
, restart = "unless-stopped"
, volumes = [ "/data/volumes/authentikRedis/data:/data" ]
, command = [ "valkey-server", "--save", "30", "1", "--loglevel", "warning" ]
, healthcheck =
  { test = [ "CMD", "valkey-server", "--version" ]
  , interval = "10s"
  , timeout = "5s"
  , retries = 3
  , start_period = "10s"
  }
}
