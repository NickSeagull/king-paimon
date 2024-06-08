let linuxserver = ./utils/linuxserver.dhall

let List/empty = https://prelude.dhall-lang.org/List/empty.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

let emptyPorts = List/empty { onHost : Text, onGuest : Text }

in  linuxserver
      { name = "ddclient"
      , env = Map/empty Text Text
      , ports = emptyPorts
      , volumes =
        [ { onHost = "/home/nick/config/ddclient", onGuest = "/config" } ]
      , puid = None Natural
      , pgid = None Natural
      }
