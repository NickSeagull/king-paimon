let linuxserver = ./utils/linuxserver.dhall

let secrets = ./secrets.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

in      linuxserver
          { name = "nextcloud"
          , env = Map/empty Text Text
          , ports = [ { onHost = "8243", onGuest = "443" } ]
          , volumes =
            [ { onHost = "/home/nick/config/nextcloud", onGuest = "/config" }
            , { onHost = "/data", onGuest = "/data" }
            ]
          , puid = None Natural
          , pgid = None Natural
          }
    /\  { depends_on = [ "mariadb" ]
        , labels =
          [ "traefik.enable=true"
          , "traefik.http.routers.nextcloud.rule=Host(`${secrets.nextcloud.host}`)"
          , "traefik.http.routers.nextcloud.tls=true"
          , "traefik.http.routers.nextcloud.entrypoints=web,websecure"
          , "traefik.http.routers.nextcloud.tls.certresolver=mytlschallenge"
          , "traefik.http.middlewares.nextcloud.headers.SSLRedirect=true"
          , "traefik.http.middlewares.nextcloud.headers.STSSeconds=315360000"
          , "traefik.http.middlewares.nextcloud.headers.browserXSSFilter=true"
          , "traefik.http.middlewares.nextcloud.headers.contentTypeNosniff=true"
          , "traefik.http.middlewares.nextcloud.headers.forceSTSHeader=true"
          , "traefik.http.middlewares.nextcloud.headers.SSLHost=${secrets.nextcloud.domainName}"
          , "traefik.http.middlewares.nextcloud.headers.STSIncludeSubdomains=true"
          , "traefik.http.middlewares.nextcloud.headers.STSPreload=true"
          , "traefik.http.routers.nextcloud.middlewares=nextcloud@docker"
          ]
        }
