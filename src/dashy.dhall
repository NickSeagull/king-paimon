{ container_name = "dashy"
, image = "lissy93/dashy:latest"
, restart = "unless-stopped"
, volumes = [ "./dashy:/app/public" ]
, ports = [ "4000:80" ]
, environment = [ "NODE_ENV=debug" ]
, healthcheck =
  { test = [ "CMD", "node", "/app/services/healthcheck" ]
  , interval = "1m30s"
  , timeout = "10s"
  , retries = 3
  , start_period = "40s"
  }
}
