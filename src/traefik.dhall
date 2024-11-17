let secrets = ./secrets.dhall

in  { container_name = "traefik"
    , image = "traefik"
    , restart = "always"
    , command =
      [ "--api=true"
      , "--api.insecure=true"
      , "--log.level=DEBUG"
      , "--providers.docker=true"
      , "--providers.docker.exposedbydefault=false"
      , "--providers.file.filename=/etc/traefik/dynamic/certs-config.yaml"
      , "--entrypoints.web.address=:80"
      , "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      , "--entrypoints.web.http.redirections.entrypoint.scheme=https"
      , "--entrypoints.websecure.address=:443"
      ]
    , ports = [ "80:80", "443:443" ]
    , volumes =
      [ "./data/letsencrypt:/letsencrypt:rw"
      , "/var/run/docker.sock:/var/run/docker.sock:ro"
      , "./certs-config.yaml:/etc/traefik/dynamic/certs-config.yaml:ro"
      , "./certs:/etc/certs:ro"
      ]
    }
