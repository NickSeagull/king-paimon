{ services =
  { duplicati = ./src/duplicati.dhall
  , mosquitto = ./src/mosquitto.dhall
  , syncthing = ./src/syncthing.dhall
  , homeassistant = ./src/homeassistant.dhall
  , zigbee2mqtt = ./src/zigbee2mqtt.dhall
  , nodered = ./src/nodered.dhall
  , nextcloud = ./src/nextcloud.dhall
  , dokuwiki = ./src/dokuwiki.dhall
  , mariadb = ./src/mariadb.dhall
  , mariadb-gitea = ./src/mariadb-gitea.dhall
  , gitea = ./src/gitea.dhall
  , gitea-act-runner = ./src/gitea-act-runner.dhall
  , ddclient = ./src/ddclient.dhall
  , n8n = ./src/n8n.dhall
  , traefik = ./src/traefik.dhall
  , valkey = ./src/valkey.dhall
  , actual-budget = ./src/actual-budget.dhall
  }
, networks.wireguard.name = "wireguard"
, networks.gitea.external = False
}
