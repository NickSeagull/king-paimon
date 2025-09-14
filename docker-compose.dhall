    { services =
      { duplicati = ./src/duplicati.dhall
      , mosquitto = ./src/mosquitto.dhall
      , homeassistant = ./src/homeassistant.dhall
      , zigbee2mqtt = ./src/zigbee2mqtt.dhall
      , nodered = ./src/nodered.dhall
      , ddclient = ./src/ddclient.dhall
      , code-server = ./src/code-server.dhall
      }
    , networks =
      { proxy = { name = "proxy" }
      }
    }
/\  ./src/auth/services.dhall
/\  ./src/automation/services.dhall
/\  ./src/networking/services.dhall
/\  ./src/paperless/services.dhall
-- /\  ./src/games/services.dhall
