{ services =
  { code-server = ./src/code-server.dhall
  , duplicati = ./src/duplicati.dhall
  , portainer = ./src/portainer.dhall
  , mosquitto = ./src/mosquitto.dhall
  , homeassistant = ./src/homeassistant.dhall
  , zigbee2mqtt = ./src/zigbee2mqtt.dhall
  , nodered = ./src/nodered.dhall
  , nextcloud = ./src/nextcloud.dhall
  , mariadb = ./src/mariadb.dhall
  , mariadb-gitea = ./src/mariadb-gitea.dhall
  , gitea = ./src/gitea.dhall
  , gitea-act-runner = ./src/gitea-act-runner.dhall
  , wireguard = ./src/wireguard.dhall
  , ddclient = ./src/ddclient.dhall
  , dashy = ./src/dashy.dhall
  , n8n = ./src/n8n.dhall
  , traefik = ./src/traefik.dhall
  , typesense = ./src/typesense.dhall
  , chatbot-ui = ./src/chatbot-ui.dhall
  , yhlygh = ./src/yhlygh.dhall
  }
, version = "2.1"
, networks.wireguard.name = "wireguard"
, networks.gitea.external = False
}
