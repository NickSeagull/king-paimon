let secrets = ../../secrets.dhall

let redis = ./redis.dhall

let postgresql = ./postgresql.dhall

in  { container_name = "authentikServer"
    , image = "ghcr.io/goauthentik/server:2025.4.0"
    , restart = "unless-stopped"
    , command = [ "server" ]
    , ports = [ "9000:9000", "9443:9443" ]
    , environment =
      [ "AUTHENTIK_SECRET_KEY=${secrets.authentik.secretKey}"
      , "AUTHENTIK_REDIS__HOST=${redis.container_name}"
      , "AUTHENTIK_POSTGRESQL__HOST=${postgresql.container_name}"
      , "AUTHENTIK_POSTGRESQL__USER=${secrets.authentik.pgUser}"
      , "AUTHENTIK_POSTGRESQL__NAME=${secrets.authentik.pgDb}"
      , "AUTHENTIK_POSTGRESQL__PASSWORD=${secrets.authentik.pgPassword}"
      , "AUTHENTIK_ERROR_REPORTING__ENABLED=true"
      ]
    , volumes =
      [ "/data/volumes/authentik/media:/media"
      , "/data/volumes/authentik/custom-templates:/templates"
      ]
    , networks = [ "proxy" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.authentik.rule=Host(`${secrets.authentik.domain}`)"
      , "traefik.http.routers.authentik.entrypoints=websecure"
      , "traefik.http.routers.authentik.tls.certresolver=letsencrypt"
      , "traefik.http.services.authentik.loadbalancer.server.port=9443"
      , "traefik.http.routers.authentik.service=authentik"
      , "traefik.http.routers.authentik.middlewares=authentik-headers"
      , "traefik.http.middlewares.authentik-headers.headers.customrequestheaders.X-Forwarded-Proto=https"
      , "traefik.http.middlewares.authentik-headers.headers.customrequestheaders.X-Forwarded-For={client_ip}"
      , "traefik.http.middlewares.authentik-headers.headers.customrequestheaders.Host={host}"
      , "traefik.http.routers.authentik-websocket.rule=Host(`${secrets.authentik.domain}`)"
      , "traefik.http.routers.authentik-websocket.entrypoints=websecure"
      , "traefik.http.routers.authentik-websocket.tls.certresolver=letsencrypt"
      , "traefik.http.routers.authentik-websocket.service=authentik"
      , "traefik.http.routers.authentik-websocket.middlewares=authentik-headers"
      , "traefik.http.services.authentik.loadbalancer.server.scheme=https"
      ]
    , depends_on = [ postgresql.container_name, redis.container_name ]
    }
