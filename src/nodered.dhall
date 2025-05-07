-- | Ensure that you run sudo chown -R 1000:1000 nodered in the config root
let secrets = ./secrets.dhall

in      { container_name = "nodered"
        , image = "nodered/node-red:latest"
        , restart = "unless-stopped"
        , volumes = [ "/data/volumes/nodered/data:/data" ]
        , ports = [ "1880:1880" ]
        , environment = [ "TZ=Atlantic/Canary",
          "PUID=1000",
          "PGID=1000" 
        ]
        , network_mode = "host"
        }
    /\  { depends_on = [ "homeassistant" ] }
