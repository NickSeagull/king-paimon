let secrets = ../secrets.dhall

in  { container_name = "paperless-ai"
    , image = "clusterzx/paperless-ai"
    , restart = "unless-stopped"
    , cap_drop = [ "ALL" ]
    , security_opt = [ "no-new-privileges=true" ]
    , environment =
      [ "PUID=1000"
      , "PGID=1000"
      , "PAPERLESS_AI_PORT=3000"
      , "RAG_SERVICE_URL=http://paperless-webserver:8000"
      , "RAG_SERVICE_ENABLED=true"
      ]
    , ports = [ "3001:3000" ]
    , volumes = [ "/data/volumes/paperless/ai:/app/data" ]
    , networks = [ "proxy" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.paperless-ai.rule=Host(`${secrets.paperless.hostAI}.${secrets.paperless.domainName}`)"
      , "traefik.http.routers.paperless-ai.entrypoints=websecure"
      , "traefik.http.routers.paperless-ai.tls.certresolver=letsencrypt"
      , "traefik.http.services.paperless-ai.loadbalancer.server.port=3000"
      ]
    }