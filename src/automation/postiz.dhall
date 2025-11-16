let secrets = ../secrets.dhall

in  { container_name = "postiz"
    , image = "ghcr.io/gitroomhq/postiz-app:latest"
    , restart = "unless-stopped"
    , depends_on = [ "postiz-postgres", "postiz-redis" ]
    , ports = [ "127.0.0.1:5000:5000" ]
    , networks = [ "proxy" ]
    , volumes = [ "/data/volumes/postiz/config:/config/" ]
    , environment =
      [ "DATABASE_URL=postgresql://${secrets.postiz.pgUser}:${secrets.postiz.pgPassword}@postiz-postgres:5432/${secrets.postiz.pgDb}"
      , "REDIS_URL=redis://postiz-redis:6379"
      , "BACKEND_INTERNAL_URL=http://localhost:3000"
      , "FRONTEND_URL=https://${secrets.postiz.host}.${secrets.postiz.domainName}"
      , "NEXT_PUBLIC_BACKEND_URL=https://${secrets.postiz.host}.${secrets.postiz.domainName}/api"
      , "JWT_SECRET=${secrets.postiz.jwtSecret}"
      , "MAIN_URL=https://${secrets.postiz.host}.${secrets.postiz.domainName}"
      , "UPLOAD_DIRECTORY=/config/uploads"
      ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.postiz.rule=Host(`${secrets.postiz.host}.${secrets.postiz.domainName}`)"
      , "traefik.http.routers.postiz.entrypoints=websecure"
      , "traefik.http.routers.postiz.tls.certresolver=letsencrypt"
      , "traefik.http.services.postiz.loadbalancer.server.port=5000"
      , "traefik.http.routers.postiz.service=postiz"
      ]
    }
