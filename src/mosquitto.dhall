let secrets = ./secrets.dhall

in  { build.context = "."
    , container_name = "mosquitto"
    , image = "eclipse-mosquitto"
    , ports = [ "1883:1883", "9001:9001" ]
    , restart = "unless-stopped"
    , volumes =
      [ "./appdata/mosquitto:/mosquitto"
      , "./appdata/mosquitto/data:/mosquitto/data"
      , "../appdata/mosquitto/.mosquitto-logs:/mosquitto/log"
      ]
    , working_dir = "/data"
    }
