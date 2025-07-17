let secrets = ../secrets.dhall

in  { container_name = "n8n"
    , image = "docker.n8n.io/n8nio/n8n"
    , restart = "unless-stopped"
    , ports = [ "127.0.0.1:5678:5678" ]
    , networks = [ "proxy" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.n8n.rule=Host(`qliphoth.academiaatlantica.org`)"
      , "traefik.http.routers.n8n.entrypoints=websecure"
      , "traefik.http.routers.n8n.tls.certresolver=letsencrypt"
      , "traefik.http.services.n8n.loadbalancer.server.port=5678"
      , "traefik.http.routers.n8n.service=n8n"
      ]
    , environment =
      [ "N8N_HOST=qliphoth.academiaatlantica.org"
      , "N8N_PORT=5678"
      , "N8N_PROTOCOL=https"
      , "NODE_ENV=production"
      , "WEBHOOK_URL=https://qliphoth.academiaatlantica.org"
      , "GENERIC_TIMEZONE=Atlantic/Canary"
      , "N8N_LOG_LEVEL=info"
      ]
    , volumes = [ "/data/volumes/n8n/data:/home/node/.n8n" ]
    , depends_on = [] : List Text
    }