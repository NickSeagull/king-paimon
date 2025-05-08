let secrets = ../../secrets.dhall

in  { container_name = "secure"
    , image = "traefik/whoami"
    , restart = "unless-stopped"
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.secure.rule=Host(`${secrets.traefik.secureHost}`)"
      , "traefik.http.routers.secure.entrypoints=websecure"
      , "traefik.http.routers.secure.tls=true"
      , "traefik.http.routers.secure.tls.certresolver=letsencrypt"
      ]
    }
