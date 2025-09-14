{ container_name = "paperless-tika"
, image = "docker.io/apache/tika:latest"
, restart = "unless-stopped"
, networks = [ "proxy" ]
}