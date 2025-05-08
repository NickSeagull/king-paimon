let secrets = ../../secrets.dhall

in  { container_name = "public"
    , image = "traefik/whoami"
    , restart = "unless-stopped"
    , networks = { net = { aliases = [] : List Text } }
    , labels = [
      "traefik.enable=true"
      , "traefik.http.routers.public.rule=Host(`${secrets.traefik.publicHost}`)"
      , "traefik.http.routers.public.entrypoints=https"
      , "traefik.http.routers.public.tls=true"
      , "traefik.http.routers.public.tls.certresolver=letsencrypt"
      , "traefik.http.routers.public.middlewares=authelia@docker"
      ]
    }
