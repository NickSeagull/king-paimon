let secrets = ../../secrets.dhall

in  { container_name = "traefik"
    , image = "traefik:v3.4.0"
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
      , "--certificatesresolvers.letsencrypt.acme.email=${secrets.traefik.sslEmail}"
      , "--certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json"
      , "--certificatesresolvers.letsencrypt.acme.dnschallenge=true"
      , "--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=cloudflare"
      , "--certificatesresolvers.letsencrypt.acme.dnschallenge.delayBeforeCheck=0"
      , "--certificatesresolvers.letsencrypt.acme.dnschallenge.resolvers=1.1.1.1:53,8.8.8.8:53"
      , "--log=true"
      , "--log.level=DEBUG"
      , "--serversTransport.insecureSkipVerify=true"
      ]
    , environment = [ "CF_DNS_API_TOKEN=${secrets.cloudflare.apiKey}" ]
    , ports = [ "80:80", "443:443" ]
    , volumes =
      [ "/data/volumes/traefik/letsencrypt:/letsencrypt:rw"
      , "/var/run/docker.sock:/var/run/docker.sock:ro"
      , "/data/volumes/traefik/certs-config:/etc/traefik/dynamic:ro"
      , "/data/volumes/traefik/certs:/etc/certs:ro"
      ]
    }
