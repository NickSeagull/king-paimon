let secrets = ./secrets.dhall

in  { build.context = "."
    , container_name = "mosquitto"
    , image = "eclipse-mosquitto"
    , ports = [ "1883:1883", "9001:9001" ]
    , restart = "unless-stopped"
    , volumes =
      [ "/data/volumes/mosquitto/:/mosquitto"
      ]
    }
