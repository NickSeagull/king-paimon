{ container_name = "paperless-broker"
, image = "docker.io/library/redis:8"
, restart = "unless-stopped"
, volumes = [ "/data/volumes/paperless/redis:/data" ]
, networks = [ "proxy" ]
}