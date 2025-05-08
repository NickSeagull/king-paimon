let secrets = ../../secrets.dhall

let redis = ./redis.dhall

let postgresql = ./postgresql.dhall

in  { container_name = "authentikWorker"
    , image = "ghcr.io/goauthentik/server:2025.4.0"
    , restart = "unless-stopped"
    , command = [ "worker" ]
    , environment =
      [ "AUTHENTIK_SECRET_KEY=${secrets.authentik.secretKey}"
      , "AUTHENTIK_REDIS__HOST=${redis.container_name}"
      , "AUTHENTIK_POSTGRESQL__HOST=${postgresql.container_name}"
      , "AUTHENTIK_POSTGRESQL__USER=${secrets.authentik.pgUser}"
      , "AUTHENTIK_POSTGRESQL__NAME=${secrets.authentik.pgDb}"
      , "AUTHENTIK_POSTGRESQL__PASSWORD=${secrets.authentik.pgPassword}"
      ]
    , user = "root"
    , volumes =
      [ "/var/run/docker.sock:/var/run/docker.sock"
      , "/data/volumes/authentik/media:/media"
      , "/data/volumes/authentik/certs:/certs"
      , "/data/volumes/authentik/custom-templates:/templates"
      ]
    , depends_on = [ postgresql.container_name, redis.container_name ]
    }
