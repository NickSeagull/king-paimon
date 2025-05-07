let secrets = ./secrets.dhall

in      { container_name = "homeassistant"
        , image = "ghcr.io/home-assistant/home-assistant:stable"
        , restart = "unless-stopped"
        , privileged = True
        , volumes =
          [ "/data/volumes/homeassistant/config:/config"
          , "/etc/localtime:/etc/localtime:ro"
          ]
        , network_mode = "host"
        , environment = [
          "PUID=1000",
          "PGID=1000" 
        ]
        }
    /\  { depends_on = [ "mosquitto", "zigbee2mqtt" ] }
