let secrets = ./secrets.dhall

in  { container_name = "syncthing"
    , image = "lscr.io/linuxserver/syncthing:latest"
    , restart = "unless-stopped"
    , volumes =
      [ "./appdata/syncthing/config:/config", "./appdata/syncthing/data:/data" ]
    , ports =
      [ "8384:8384", "22000:22000/tcp", "22000:22000/udp", "21027:21027/udp" ]
    , environment = [ "PUID=1000", "PGID=1000", "TZ=Atlantic/Canary" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.syncthing.rule=Host(`${secrets.syncthing.host}`)"
      , "traefik.http.routers.syncthing.tls=true"
      , "traefik.http.routers.syncthing.entrypoints=web,websecure"
      , "traefik.http.routers.syncthing.tls.certresolver=mytlschallenge"
      , "traefik.http.middlewares.syncthing.headers.SSLRedirect=true"
      , "traefik.http.middlewares.syncthing.headers.STSSeconds=315360000"
      , "traefik.http.middlewares.syncthing.headers.browserXSSFilter=true"
      , "traefik.http.middlewares.syncthing.headers.contentTypeNosniff=true"
      , "traefik.http.middlewares.syncthing.headers.forceSTSHeader=true"
      , "traefik.http.middlewares.syncthing.headers.SSLHost=${secrets.syncthing.domainName}"
      , "traefik.http.middlewares.syncthing.headers.STSIncludeSubdomains=true"
      , "traefik.http.middlewares.syncthing.headers.STSPreload=true"
      , "traefik.http.routers.syncthing.middlewares=syncthing@docker"
      ]
    }
