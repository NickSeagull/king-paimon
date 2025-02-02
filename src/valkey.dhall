{ container_name = "valkey"
, image = "bitnami/valkey:latest"
, restart = "unless-stopped"
, volumes = [ "./appdata/valkey:/bitnami/valkey/data" ]
, environment.ALLOW_EMPTY_PASSWORD = "yes"
, ports = [ "6379:6379" ]
}
