let secrets = ./secrets.dhall

in 
      { container_name = "code-server"
      , image = "linuxserver/code-server:latest"
      , restart = "unless-stopped"
      , environment = [ "PASSWORD=${secrets.code-server.password}"
      , "SUDO_PASSWORD=${secrets.code-server.sudoPassword}"
      , "DEFAULT_WORKSPACE=/data"
      , "PUID=1000"
      , "PGID=1000"
      , "TZ=Atlantic/Canary"
      ]
      , ports = [ "8443:8443" ]
      , volumes =
        [ "/home/nick/config/appdata/code-server:/config"
        , "/home/nick/config:/root-config"
        , "/data/code-server:/data"
        ]
      , networks = [ "proxy" ]
      , labels =
        [ "traefik.enable=true"
        , "traefik.http.routers.code-server.rule=Host(`${secrets.code-server.host}`)"
        , "traefik.http.routers.code-server.entrypoints=websecure"
        , "traefik.http.routers.code-server.tls.certresolver=letsencrypt"
        , "traefik.http.services.code-server.loadbalancer.server.port=8443"
        , "traefik.http.routers.code-server.service=code-server"
        ]
      }
