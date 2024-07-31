let secrets = ./secrets.dhall

in  { container_name = "n8n"
    , image = "n8n"
    , restart = "always"
    , ports = [ "127.0.0.1:5678:5678" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.n8n.rule=Host(`${secrets.n8n.host}`)"
      , "traefik.http.routers.n8n.tls=true"
      , "traefik.http.routers.n8n.entrypoints=web,websecure"
      , "traefik.http.routers.n8n.tls.certresolver=mytlschallenge"
      , "traefik.http.middlewares.n8n.headers.SSLRedirect=true"
      , "traefik.http.middlewares.n8n.headers.STSSeconds=315360000"
      , "traefik.http.middlewares.n8n.headers.browserXSSFilter=true"
      , "traefik.http.middlewares.n8n.headers.contentTypeNosniff=true"
      , "traefik.http.middlewares.n8n.headers.forceSTSHeader=true"
      , "traefik.http.middlewares.n8n.headers.SSLHost=${secrets.n8n.domainName}"
      , "traefik.http.middlewares.n8n.headers.STSIncludeSubdomains=true"
      , "traefik.http.middlewares.n8n.headers.STSPreload=true"
      , "traefik.http.routers.n8n.middlewares=n8n@docker"
      ]
    , environment =
      { N8N_HOST = secrets.n8n.host
      , N8N_PORT = "5678"
      , N8N_PROTOCOL = "https"
      , NODE_ENV = "production"
      , WEBHOOK_URL = secrets.n8n.webhookUrl
      , GENERIC_TIMEZONE = "Atlantic/Canary"
      }
    , volumes = [ "./n8n:/home/node/.n8n" ]
    , depends_on = [ "valkey" ]
    }
