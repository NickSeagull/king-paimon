{ container_name = "postiz-redis"
, image = "docker.io/library/redis:7.2"
, restart = "unless-stopped"
, volumes = [ "/data/volumes/postiz/redis:/data" ]
, networks = [ "proxy" ]
, healthcheck =
  { test = [ "CMD", "redis-cli", "ping" ]
  , interval = "10s"
  , timeout = "5s"
  , retries = 5
  , start_period = "10s"
  }
}
