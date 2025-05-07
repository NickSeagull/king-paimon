{ services =
  { duplicati = ./src/duplicati.dhall
  , mosquitto = ./src/mosquitto.dhall
  , homeassistant = ./src/homeassistant.dhall
  , zigbee2mqtt = ./src/zigbee2mqtt.dhall
  , nodered = ./src/nodered.dhall
  }
}
