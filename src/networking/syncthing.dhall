let secrets = ../secrets.dhall

in  { container_name = "syncthing"
    , image = "syncthing/syncthing:2"
    , restart = "unless-stopped"
    , networks = [ "proxy" ]
    , volumes =
      [ "/data/volumes/syncthing/config:/var/syncthing/config"
      , "/data/volumes/syncthing/data:/var/syncthing"
      ]
    , ports =
      [ "8384:8384"
      , "22000:22000/tcp"
      , "22000:22000/udp"
      , "21027:21027/udp"
      ]
    , environment =
      [ "PUID=1000"
      , "PGID=1000"
      ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.syncthing.rule=Host(`${secrets.syncthing.host}`)"
      , "traefik.http.routers.syncthing.entrypoints=websecure"
      , "traefik.http.routers.syncthing.tls=true"
      , "traefik.http.routers.syncthing.tls.certresolver=letsencrypt"
      , "traefik.http.services.syncthing.loadbalancer.server.port=8384"
      , "traefik.http.routers.syncthing.service=syncthing"
      , "traefik.http.routers.syncthing.middlewares=syncthing-headers"
      , "traefik.http.middlewares.syncthing-headers.headers.SSLRedirect=true"
      , "traefik.http.middlewares.syncthing-headers.headers.STSSeconds=315360000"
      , "traefik.http.middlewares.syncthing-headers.headers.browserXSSFilter=true"
      , "traefik.http.middlewares.syncthing-headers.headers.contentTypeNosniff=true"
      , "traefik.http.middlewares.syncthing-headers.headers.forceSTSHeader=true"
      , "traefik.http.middlewares.syncthing-headers.headers.SSLHost=${secrets.syncthing.host}"
      , "traefik.http.middlewares.syncthing-headers.headers.STSIncludeSubdomains=true"
      , "traefik.http.middlewares.syncthing-headers.headers.STSPreload=true"
      ]
    }