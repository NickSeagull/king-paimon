{ services =
  { code-server = ./src/code-server.dhall
  , duplicati = ./src/duplicati.dhall
  , minecraft = ./src/minecraft.dhall
  , portainer = ./src/portainer.dhall
  , mosquitto = ./src/mosquitto.dhall
  , homeassistant = ./src/homeassistant.dhall
  , zigbee2mqtt = ./src/zigbee2mqtt.dhall
  , nodered = ./src/nodered.dhall
  , nextcloud = ./src/nextcloud.dhall
  , mariadb = ./src/mariadb.dhall
  , wireguard = ./src/wireguard.dhall
  , ddclient = ./src/ddclient.dhall
  }
, version = "2.1"
, networks.wireguard.name = "wireguard"
}
