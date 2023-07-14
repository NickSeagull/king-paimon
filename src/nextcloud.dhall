let linuxserver = ./utils/linuxserver.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

in      linuxserver
          { name = "nextcloud"
          , env = Map/empty Text Text
          , ports = [ { onHost = "443", onGuest = "443" } ]
          , volumes =
            [ { onHost = "/home/nick/config/nextcloud", onGuest = "/config" }
            , { onHost = "/data", onGuest = "/data" }
            ]
          , puid = None Natural
          , pgid = None Natural
          }
    /\  { depends_on = [ "mariadb" ] }
