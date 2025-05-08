let secrets = ../../secrets.dhall

in  { container_name = "public"
    , image = "traefik/whoami"
    , restart = "unless-stopped"
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.public.rule=Host(`${secrets.traefik.publicHost}`)"
      , "traefik.http.routers.public.entrypoints=websecure"
      , "traefik.http.routers.public.tls=true"
      , "traefik.http.routers.public.tls.certresolver=letsencrypt"
      ]
    }
