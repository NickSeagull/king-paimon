{ container_name = "valkey"
, image = "bitnami/valkey:latest"
, restart = "unless-stopped"
, volumes = [ "/data/volumes/valkey/data:/bitnami/valkey/data" ]
, environment = [ "ALLOW_EMPTY_PASSWORD=yes" ]
, ports = [ "6379:6379" ]
}