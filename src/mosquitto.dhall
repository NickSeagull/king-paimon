let secrets = ./secrets.dhall

in  { build.context = "."
    , container_name = "mosquitto"
    , image = "eclipse-mosquitto"
    , ports = [ "1883:1883", "9001:9001" ]
    , restart = "unless-stopped"
    , volumes =
      [ "./mosquitto:/mosquitto"
      , "./mosquitto/data:/mosquitto/data"
      , "../.mosquitto-logs:/mosquitto/log"
      ]
    , working_dir = "/data"
    }
