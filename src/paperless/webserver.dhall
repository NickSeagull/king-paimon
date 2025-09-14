let secrets = ../secrets.dhall

in  { container_name = "paperless-webserver"
    , image = "ghcr.io/paperless-ngx/paperless-ngx:latest"
    , restart = "unless-stopped"
    , depends_on = [ "paperless-db", "paperless-broker", "paperless-gotenberg", "paperless-tika" ]
    , ports = [ "8765:8000" ]
    , volumes = 
      [ "/data/volumes/paperless/data:/usr/src/paperless/data"
      , "/data/volumes/paperless/media:/usr/src/paperless/media"
      , "/data/volumes/paperless/export:/usr/src/paperless/export"
      , "/data/volumes/paperless/consume:/usr/src/paperless/consume"
      ]
    , environment =
      [ "PAPERLESS_REDIS=redis://paperless-broker:6379"
      , "PAPERLESS_DBHOST=paperless-db"
      , "PAPERLESS_DBUSER=${secrets.paperless.pgUser}"
      , "PAPERLESS_DBPASS=${secrets.paperless.pgPassword}"
      , "PAPERLESS_DBNAME=${secrets.paperless.pgDb}"
      , "PAPERLESS_TIKA_ENABLED=1"
      , "PAPERLESS_TIKA_GOTENBERG_ENDPOINT=http://paperless-gotenberg:3000"
      , "PAPERLESS_TIKA_ENDPOINT=http://paperless-tika:9998"
      , "PAPERLESS_SECRET_KEY=${secrets.paperless.secretKey}"
      , "PAPERLESS_ADMIN_USER=${secrets.paperless.adminUser}"
      , "PAPERLESS_ADMIN_PASSWORD=${secrets.paperless.adminPassword}"
      , "PAPERLESS_URL=https://${secrets.paperless.host}.${secrets.paperless.domainName}"
      , "PAPERLESS_ALLOWED_HOSTS=${secrets.paperless.host}.${secrets.paperless.domainName}"
      , "PAPERLESS_CORS_ALLOWED_HOSTS=https://${secrets.paperless.host}.${secrets.paperless.domainName}"
      , "PAPERLESS_TRUSTED_PROXIES=traefik"
      ]
    , networks = [ "proxy" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.paperless.rule=Host(`${secrets.paperless.host}.${secrets.paperless.domainName}`)"
      , "traefik.http.routers.paperless.entrypoints=websecure"
      , "traefik.http.routers.paperless.tls.certresolver=letsencrypt"
      , "traefik.http.services.paperless.loadbalancer.server.port=8000"
      ]
    }