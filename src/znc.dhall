let linuxserver = ./utils/linuxserver.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

in  linuxserver
      { name = "znc"
      , env = Map/empty Text Text
      , ports = [ { onHost = "6501", onGuest = "6501" } ]
      , volumes = [ { onHost = "/home/nick/config/znc", onGuest = "/config" } ]
      , puid = None Natural
      , pgid = None Natural
      }
