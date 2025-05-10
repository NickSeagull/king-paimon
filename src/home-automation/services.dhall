{ services = 
      { mosquitto = ./mosquitto.dhall
      , homeassistant = ./homeassistant.dhall
      , zigbee2mqtt = ./zigbee2mqtt.dhall
      , nodered = ./nodered.dhall
      }
}
