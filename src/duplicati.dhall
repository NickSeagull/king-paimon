let linuxserver = ./utils/linuxserver.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

in  linuxserver
      { name = "duplicati"
      , env = Map/empty Text Text
      , ports = [ { onHost = "8200", onGuest = "8200" } ]
      , volumes =
        [ { onHost = "/home/nick/config/appdata/duplicati"
          , onGuest = "/config"
          }
        , { onHost = "/home/nick/config", onGuest = "/source" }
        , { onHost = "/data", onGuest = "/data" }
        ]
      , puid = Some 0
      , pgid = Some 0
      }
