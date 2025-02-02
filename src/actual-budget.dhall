let secrets = ./secrets.dhall

in  { container_name = "actual-budget"
    , image = "actualbudget/actual-server:latest"
    , restart = "always"
    , ports = [ "127.0.0.1:5006:5006" ]
    , volumes = [ "./appdata/actual-budget:/data" ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.actual-budget.rule=Host(`${secrets.actual-budget.host}`)"
      , "traefik.http.routers.actual-budget.tls=true"
      , "traefik.http.routers.actual-budget.entrypoints=web,websecure"
      , "traefik.http.routers.actual-budget.tls.certresolver=mytlschallenge"
      , "traefik.http.middlewares.actual-budget.headers.SSLRedirect=true"
      , "traefik.http.middlewares.actual-budget.headers.STSSeconds=315360000"
      , "traefik.http.middlewares.actual-budget.headers.browserXSSFilter=true"
      , "traefik.http.middlewares.actual-budget.headers.contentTypeNosniff=true"
      , "traefik.http.middlewares.actual-budget.headers.forceSTSHeader=true"
      , "traefik.http.middlewares.actual-budget.headers.SSLHost=${secrets.actual-budget.domainName}"
      , "traefik.http.middlewares.actual-budget.headers.STSIncludeSubdomains=true"
      , "traefik.http.middlewares.actual-budget.headers.STSPreload=true"
      , "traefik.http.routers.actual-budget.middlewares=actual-budget@docker"
      ]
    }
