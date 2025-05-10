let secrets = ../../secrets.dhall

let redis = ./redis.dhall

let postgresql = ./postgresql.dhall

let authentikServer = ./server.dhall

in  { container_name = "authentikProxy"
    , image = "ghcr.io/goauthentik/proxy"
    , ports = [ "9091:9000" ]
    , environment =
      [ "AUTHENTIK_HOST=http://${authentikServer.container_name}:9000"
      , "AUTHENTIK_INSECURE=true"
      , "AUTHENTIK_TOKEN=setme"
      , "AUTHENTIK_HOST_BROWSER=https://${secrets.authentik.domain}"
      , "AUTHENTIK_DEBUG=true"
      ]
    , depends_on = [ authentikServer.container_name ]
    , networks = [ "proxy" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.port=9000"
      , "traefik.http.routers.authentik-proxy.rule=Host(`http://authentikProxy`)"
      , "traefik.http.middlewares.authentik.forwardauth.address=http://authentikProxy:9000/outpost.goauthentik.io/auth/traefik"
      , "traefik.http.middlewares.authentik.forwardauth.trustForwardHeader=true"
      , "traefik.http.middlewares.authentik.forwardauth.authResponseHeaders=X-authentik-username,X-authentik-groups,X-authentik-email,X-authentik-name,X-authentik-uid,X-authentik-jwt,X-authentik-meta-jwks,X-authentik-meta-outpost,X-authentik-meta-provider,X-authentik-meta-app,X-authentik-meta-version"
      ]
    }
