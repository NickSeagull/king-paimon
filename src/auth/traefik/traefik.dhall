let secrets = ../../secrets.dhall

in  { container_name = "traefik"
    , image = "traefik:v3.4.0"
    , restart = "always"
    , networks = { net = { aliases = [] : List Text } }
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
      , "--certificatesresolvers.letsencrypt.acme.email=${secrets.traefik.sslEmail}"
      , "--certificatesresolvers.letsencrypt.acme.storage=/etc/traefik/acme.json"
      , "--certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=http"
      , "--log=true"
      , "--log.level=DEBUG"
      ]
    , ports = [ "80:80", "443:443" ]
    , volumes =
      [ "/data/volumes/traefik/letsencrypt:/letsencrypt:rw"
      , "/var/run/docker.sock:/var/run/docker.sock:ro"
      , "/data/volumes/traefik/certs-config.yaml:/etc/traefik/dynamic/certs-config.yaml:ro"
      , "/data/volumes/traefik/certs:/etc/certs:ro"
      ]
    }
