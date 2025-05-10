let secrets = ../secrets.dhall

in      { container_name = "homeassistant"
        , image = "ghcr.io/home-assistant/home-assistant:stable"
        , restart = "unless-stopped"
        , privileged = True
        , ports = [ "8123:8123" ]
        , volumes =
          [ "/data/volumes/homeassistant/config:/config"
          , "/etc/localtime:/etc/localtime:ro"
          ]
        , networks = [ "proxy" ]
        , environment = [
          "PUID=1000",
          "PGID=1000" 
        ]
        , labels =
          [ "traefik.enable=true"
          , "traefik.http.routers.homeassistant.rule=Host(`${secrets.homeassistant.host}`)"
          , "traefik.http.routers.homeassistant.middlewares=authentik-headers@docker"
          , "traefik.http.routers.homeassistant.entrypoints=websecure"
          , "traefik.http.routers.homeassistant.tls=true"
          ]
        }
    /\  { depends_on = [ "mosquitto", "zigbee2mqtt" ] }
