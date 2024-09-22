let linuxserver = ./utils/linuxserver.dhall

let secrets = ./secrets.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

in      linuxserver
          { name = "dokuwiki"
          , env = Map/empty Text Text
          , ports =
            [ { onHost = "8343", onGuest = "443" }
            , { onHost = "8380", onGuest = "80" }
            ]
          , volumes =
            [ { onHost = "/home/nick/config/dokuwiki", onGuest = "/config" } ]
          , puid = None Natural
          , pgid = None Natural
          }
    /\  { labels =
          [ "traefik.enable=true"
          , "traefik.http.routers.dokuwiki.rule=Host(`${secrets.dokuwiki.host}`)"
          , "traefik.http.routers.dokuwiki.tls=true"
          , "traefik.http.routers.dokuwiki.entrypoints=web,websecure"
          , "traefik.http.routers.dokuwiki.tls.certresolver=mytlschallenge"
          , "traefik.http.middlewares.dokuwiki.headers.SSLRedirect=true"
          , "traefik.http.middlewares.dokuwiki.headers.STSSeconds=315360000"
          , "traefik.http.middlewares.dokuwiki.headers.browserXSSFilter=true"
          , "traefik.http.middlewares.dokuwiki.headers.contentTypeNosniff=true"
          , "traefik.http.middlewares.dokuwiki.headers.forceSTSHeader=true"
          , "traefik.http.middlewares.dokuwiki.headers.SSLHost=${secrets.dokuwiki.domainName}"
          , "traefik.http.middlewares.dokuwiki.headers.STSIncludeSubdomains=true"
          , "traefik.http.middlewares.dokuwiki.headers.STSPreload=true"
          , "traefik.http.routers.dokuwiki.middlewares=dokuwiki@docker"
          ]
        }
