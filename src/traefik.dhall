let secrets = ./secrets.dhall

in  { container_name = "traefik"
    , image = "docker.io/traefik:v2.6.1"
    , restart = "unless-stopped"
    , command =
      [ "--api.insecure=false"
      , "--providers.docker=true"
      , "--providers.docker.exposedbydefault=false"
      , "--entrypoints.http.address=:${secrets.rocketchat.port}"
      ]
    , ports =
      [ "${secrets.rocketchat.port}:3000"
      , "${secrets.traefik.dashboardPort}:8080"
      ]
    , volumes =
      [ "./data/letsencrypt:/letsencrypt:rw"
      , "/var/run/docker.sock:/var/run/docker.sock:ro"
      ]
    , depends_on = [ "mongodb", "rocketchat" ]
    }
