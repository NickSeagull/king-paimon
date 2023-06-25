{ services =
  { code-server = ./src/code-server.dhall
  , duplicati = ./src/duplicati.dhall
  , minecraft = ./src/minecraft.dhall
  , portainer = ./src/portainer.dhall
  , mosquitto = ./src/mosquitto.dhall
  , homeassistant = ./src/homeassistant.dhall
  }
, version = "2.1"
}
