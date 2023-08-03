let secrets = ./secrets.dhall

in      { container_name = "homeassistant"
        , image = "ghcr.io/home-assistant/home-assistant:stable"
        , restart = "unless-stopped"
        , privileged = True
        , volumes =
          [ "./homeassistant:/config", "/etc/localtime:/etc/localtime:ro" ]
        , network_mode = "host"
        }
    /\  { depends_on = [ "mosquitto" ] }
