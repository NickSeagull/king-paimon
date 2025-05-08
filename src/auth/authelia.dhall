let secrets = ../secrets.dhall

in      { container_name = "authelia"
        , image = "docker.io/authelia/authelia:latest"
        , restart = "unless-stopped"
        , networks = { 
          net = { 
            aliases = []  : List Text
          } 
        }
        , volumes =
          [ "/data/volumes/authelia/config:/config", 
          "/run/udev:/run/udev:ro" ]
        , environment = [ 
          "TZ=Atlantic/Canary",
          "AUTHELIA_IDENTITY_VALIDATION_RESET_PASSWORD_JWT_SECRET=${secrets.authelia.jwt}",
          "AUTHELIA_SESSION_SECRET=${secrets.authelia.session}",
          "AUTHELIA_STORAGE_POSTGRES_PASSWORD=${secrets.authelia.storagePassword}",
          "AUTHELIA_STORAGE_ENCRYPTION_KEY=${secrets.authelia.encryptionKey}",
          ]
        , labels = [  
          "traefik.enable=true",
          "traefik.http.routers.authelia.rule=Host(`${secrets.authelia.host}`)",
          "traefik.http.routers.authelia.entrypoints=https",
          "traefik.http.routers.authelia.tls=true",
          "traefik.http.routers.authelia.tls.certresolver=letsencrypt",
          "traefik.http.middlewares.authelia.forwardauth.address=http://authelia:9091/api/authz/forward-auth",
          "traefik.http.middlewares.authelia.forwardauth.trustForwardHeader=true",
          "traefik.http.middlewares.authelia.forwardauth.authResponseHeaders=Remote-User,Remote-Groups,Remote-Name,Remote-Email",
          ]
        }