let linuxserver = ./utils/linuxserver.dhall

let secrets = ./secrets.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

in  linuxserver
      { name = "duplicati"
      , env = toMap {
        PUID = "1000",
        PGID = "1000",
        TZ = "Atlantic/Canary",
        SETTINGS_ENCRYPTION_KEY = secrets.duplicati.encryptionKey,
        DUPLICATI__WEBSERVICE_PASSWORD = secrets.duplicati.password,
      }
      , ports = [ { onHost = "8200", onGuest = "8200" } ]
      , volumes =
        [ { onHost = "/data/volumes/duplicati/config"
          , onGuest = "/config"
          }
        , { onHost = ".", onGuest = "/source" }
        , { onHost = "/data", onGuest = "/data" }
        ]
      , puid = Some 0
      , pgid = Some 0
      }
