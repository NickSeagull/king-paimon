let secrets = ../../secrets.dhall

in  { container_name = "secure"
    , image = "traefik/whoami"
    , restart = "unless-stopped"
    , networks = { net = { aliases = [] : List Text } }
    , labels = [
      "traefik.enable=true"
      , "traefik.http.routers.secure.rule=Host(`${secrets.traefik.secureHost}`)"
      , "traefik.http.routers.secure.entrypoints=https"
      , "traefik.http.routers.secure.tls=true"
      , "traefik.http.routers.secure.tls.certresolver=letsencrypt"
      , "traefik.http.routers.secure.middlewares=authelia@docker"
      ]
    }
