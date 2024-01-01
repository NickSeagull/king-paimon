let secrets = ./secrets.dhall

in  { container_name = "n8n"
    , image = "docker.n8n.io/n8nio/n8n"
    , restart = "always"
    , ports = [ "5678:5678" ]
    , environment =
      { N8N_HOST = "localhost"
      , N8N_PORT = "5678"
      , N8N_PROTOCOL = "http"
      , NODE_ENV = "production"
      , WEBHOOK_URL = secrets.n8n.webhookUrl
      , GENERIC_TIMEZONE = "Atlantic/Canary"
      }
    , volumes = [ "./n8n:/home/node/.n8n" ]
    }
